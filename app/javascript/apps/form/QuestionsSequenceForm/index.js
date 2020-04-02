import * as React from "react";
import I18n from "i18n-js";
import FadeIn from "react-fade-in";
import { Form, Button } from "react-bootstrap";
import { Formik } from "formik";

import DisplayErrors from "../components/DisplayErrors";
import Http from "../../diagram/engine/http";
import store from "../../diagram/engine/reducers/store";
import Loader from "../components/Loader";
import { questionSequencesSchema } from "../constants/schema";
import { closeModal } from "../../diagram/engine/reducers/creators.actions";
import { createNode } from "../../diagram/helpers/nodeHelpers";
import Autocomplete from "@material-ui/lab/Autocomplete";
import TextField from "@material-ui/core/TextField";


export default class QuestionsSequenceForm extends React.Component {

  constructor() {
    super();

    this.state = {
      categories: [],
      complaintCategories: [],
      complaintCategoryErrors: null,
      isLoading: true
    };

    this.initForm();
  }

  /**
   * Fetch questions sequence categories
   */
  initForm = async () => {
    let http = new Http();
    let httpRequest = {};

    httpRequest = await http.fetchQuestionsSequenceCategories();
    let result = await httpRequest.json();

    if (httpRequest.status === 200) {
      this.setState({
        categories: result,
        isLoading: false
      });
    }
  };

  /**
   * Search in complaint category to get results
   * @param [Object] event
   */
  searchComplaintCategory = async (event) => {
    const http = new Http();
    let httpRequest = {};

    httpRequest = await http.searchComplaintCategories(event.target.value);
    if (httpRequest?.status === 200) {
      let result = await httpRequest.json();

      this.setState({
        complaintCategories: result.items,
        complaintCategoryErrors: null
      });
    } else {
      this.setState({ complaintCategoryErrors: { message: I18n.t("errors.fetch_failed") } });
    }
  };


  /**
   * Create or update value in database + update diagram if we're editting from diagram
   * @param [Object] values
   * @param [Object] actions
   */
  handleOnSubmit = async (values, actions) => {
    const { method, from, engine, diagramObject, addAvailableNode } = this.props;
    let http = new Http();
    let httpRequest = {};

    if (method === "create") {
      httpRequest = await http.createQuestionsSequence(values.label_translations, values.description_translations, values.type, values.min_score, from);
    } else {
      httpRequest = await http.updateQuestionsSequence(values.id, values.label_translations, values.description_translations, values.type, values.min_score, from);
    }

    let result = await httpRequest.json();

    if (httpRequest.status === 200) {
      if (from === "rails") {
        window.location.replace(result.url);
      } else {
        if (method === "create") {
          let diagramInstance = createNode(result, addAvailableNode, false, result.node.category_name, engine);
          engine.getModel().addNode(diagramInstance);
        } else {
          diagramObject.options.dbInstance.node = result;
        }

        engine.repaintCanvas();

        store.dispatch(
          closeModal()
        );
      }
    } else {
      actions.setStatus({ result });
    }
  };

  render() {
    const { questionsSequence, method } = this.props;
    const { categories, isLoading, complaintCategories, complaintCategoryErrors } = this.state;

    return (
      isLoading ? <Loader/> :
        <FadeIn>
          <Formik
            validationSchema={questionSequencesSchema}
            initialValues={{
              id: questionsSequence?.id || "",
              type: questionsSequence?.type || "",
              label_translations: questionsSequence?.label_translations?.en || "",
              description_translations: questionsSequence?.description_translations?.en || "",
              min_score: questionsSequence?.min_score || ""
            }}
            onSubmit={(values, actions) => this.handleOnSubmit(values, actions)}
          >
            {({
                handleSubmit,
                handleChange,
                isSubmitting,
                values,
                touched,
                errors,
                status
              }) => (
              <Form noValidate onSubmit={handleSubmit}>
                {status ? <DisplayErrors errors={status}/> : null}
                {complaintCategoryErrors ? <DisplayErrors errors={complaintCategoryErrors}/> : null}

                {method === "create" ?
                  <Form.Group controlId="validationType">
                    <Form.Label>{I18n.t("activerecord.attributes.node.type")}</Form.Label>
                    <Form.Control
                      as="select"
                      name="type"
                      value={values.type}
                      onChange={handleChange}
                      isInvalid={touched.type && !!errors.type}
                    >
                      <option value="">{I18n.t("select")}</option>
                      {categories.map(category => (
                        <option key={category.reference_prefix} value={category.name}>{category.label}</option>
                      ))}
                    </Form.Control>
                    <Form.Control.Feedback type="invalid">
                      {errors.type}
                    </Form.Control.Feedback>
                  </Form.Group>
                  : null}

                <Form.Group controlId="validationLabel">
                  <Form.Label>{I18n.t("activerecord.attributes.node.label_translations")}</Form.Label>
                  <Form.Control
                    name="label_translations"
                    value={values.label_translations}
                    onChange={handleChange}
                    isInvalid={touched.label_translations && !!errors.label_translations}
                  />
                  <Form.Control.Feedback type="invalid">
                    {errors.label_translations}
                  </Form.Control.Feedback>
                </Form.Group>

                <Form.Group controlId="validationComplaintCategories">
                  <Form.Label>{I18n.t("activerecord.attributes.node.node_id")}</Form.Label>
                  <Autocomplete
                    multiple
                    name="node_id"
                    options={complaintCategories}
                    getOptionLabel={option => option.fsn.term}
                    autoComplete
                    includeInputInList
                    freeSolo
                    disableOpenOnFocus
                    onChange={this.complaintCategoryChange}
                    renderInput={params => (
                      <TextField
                        {...params}
                        variant="filled"
                        onChange={this.searchComplaintCategory} fullWidth/>
                    )}
                  />
                </Form.Group>

                {values.type === "QuestionsSequences::Scored" ?
                  <Form.Group controlId="validationMinScore">
                    <Form.Label>{I18n.t("activerecord.attributes.questions_sequence.min_score")}</Form.Label>
                    <Form.Control
                      name="min_score"
                      value={values.min_score}
                      onChange={handleChange}
                      isInvalid={touched.min_score && !!errors.min_score}
                    />
                    <Form.Control.Feedback type="invalid">
                      {errors.min_score}
                    </Form.Control.Feedback>
                  </Form.Group>
                  : null}

                <Form.Group controlId="validationDescription">
                  <Form.Label>{I18n.t("activerecord.attributes.node.description_translations")}</Form.Label>
                  <Form.Control
                    name="description_translations"
                    as="textarea"
                    value={values.description_translations}
                    onChange={handleChange}
                    isInvalid={touched.description_translations && !!errors.description_translations}
                  />
                  <Form.Control.Feedback type="invalid">
                    {errors.description_translations}
                  </Form.Control.Feedback>
                </Form.Group>

                <Button type="submit" disabled={isSubmitting}>
                  {I18n.t("save")}
                </Button>
              </Form>
            )}
          </Formik>
        </FadeIn>
    );
  }
}
