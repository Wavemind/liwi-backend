import * as React from "react";
import Autocomplete from "@material-ui/lab/Autocomplete";
import { createFilterOptions } from "@material-ui/lab/Autocomplete";
import TextField from "@material-ui/core/TextField";
import Chip from "@material-ui/core/Chip";
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
import {getTranslatedText, getStudyLanguage} from "../../utils";


const filterOptions = createFilterOptions({
  stringify: option => option.label_translations.en
});

export default class QuestionsSequenceForm extends React.Component {

  constructor(props) {
    super(props);

    this.state = {
      updateMode: props.method === "update",
      deployedMode: props.method === "update" && props.is_deployed,
      categories: [],
      complaintCategories: [],
      isLoading: true,
      language: getStudyLanguage()
    };

    this.initForm();
  }

  /**
   * Fetch questions sequence categories
   */
  initForm = async () => {
    const http = new Http();

    const httpRequest = await http.fetchQuestionsSequenceLists();
    const result = await httpRequest.json();

    if (httpRequest.status === 200) {
      this.setState({
        categories: result.categories,
        complaintCategories: result.complaint_categories,
        isLoading: false
      });
    }
  };

  /**
   * Create or update value in database + update diagram if we're editting from diagram
   * @param [Object] values
   * @param [Object] actions
   */
  handleOnSubmit = async (values, actions) => {
    const { method, from, engine, diagramObject, addAvailableNode } = this.props;
    const http = new Http();
    const complaint_category_ids = [];
    let httpRequest = {};
    values.complaint_categories_attributes.map(cc => (complaint_category_ids.push(cc.id)));

    if (method === "create") {
      httpRequest = await http.createQuestionsSequence(values.label_translations, values.description_translations, values.type, values.min_score, values.cut_off_start, values.cut_off_end, values.cut_off_value_type, complaint_category_ids, from);
    } else {
      httpRequest = await http.updateQuestionsSequence(values.id, values.label_translations, values.description_translations, values.type, values.min_score, values.cut_off_start, values.cut_off_end, values.cut_off_value_type, complaint_category_ids, from);
    }

    const result = await httpRequest.json();

    if (httpRequest.status === 200) {
      if (from === "rails") {
        window.location.replace(result.url);
      } else {
        if (method === "create") {
          const diagramInstance = createNode(result, addAvailableNode, false, result.node.category_name, engine);
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
    const { questionsSequence } = this.props;
    const { categories, isLoading, complaintCategories, updateMode, deployedMode, language } = this.state;

    return (
      isLoading ? <Loader/> :
        <FadeIn>
          <Formik
            validationSchema={questionSequencesSchema}
            initialValues={{
              id: questionsSequence?.id || "",
              type: questionsSequence?.type || "",
              label_translations: getTranslatedText(questionsSequence?.label_translations, language),
              description_translations: getTranslatedText(questionsSequence?.description_translations, language),
              min_score: questionsSequence?.min_score || "",
              cut_off_start: questionsSequence?.cut_off_start || "",
              cut_off_end: questionsSequence?.cut_off_end || "",
              cut_off_value_type: updateMode ? "days" : "months",
              complaint_categories_attributes: questionsSequence?.complaint_categories || []
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
                status,
                setFieldValue
              }) => (
              <Form noValidate onSubmit={handleSubmit}>
                {status ? <DisplayErrors errors={status}/> : null}
                <Form.Group controlId="validationType">
                  <Form.Label>{I18n.t("activerecord.attributes.node.type")}</Form.Label>
                  <Form.Control
                    as="select"
                    name="type"
                    disabled={updateMode}
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
                  <Form.Label>
                    <p dangerouslySetInnerHTML={{__html: I18n.t("activerecord.attributes.node.node")}}/>
                  </Form.Label>
                  <Autocomplete
                    autoComplete
                    multiple
                    freeSolo
                    filterSelectedOptions
                    name="complaint_categories_attributes"
                    options={complaintCategories.map(option => option)}
                    defaultValue={questionsSequence?.complaint_categories}
                    filterOptions={filterOptions}
                    onChange={(_, value) => setFieldValue("complaint_categories_attributes", value)}
                    disabled={deployedMode}
                    renderOption={(option) => option.label_translations.en}
                    renderTags={(value, getTagProps) => (
                      value.map((option, index) => (
                        <Chip variant="outlined" label={option.label_translations.en} {...getTagProps({ index })} />
                      ))
                    )}
                    renderInput={params => (
                      <TextField
                        {...params}
                        variant="outlined"
                        fullWidth/>
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
                      disabled={deployedMode}
                      isInvalid={touched.min_score && !!errors.min_score}
                    />
                    <Form.Control.Feedback type="invalid">
                      {errors.min_score}
                    </Form.Control.Feedback>
                  </Form.Group>
                  : null}

                <Form.Row>
                  <Form.Label>{I18n.t("activerecord.attributes.node.cut_off_start")}&nbsp;&#x2265;&nbsp;</Form.Label>
                  <Form.Group controlId="validationCutOffStart">
                    <Form.Control
                      name="cut_off_start"
                      value={values.cut_off_start}
                      onChange={handleChange}
                      // disabled={deployedMode} Temporally not disabled to let cut_offs to be fixed
                      isInvalid={touched.cut_off_start && !!errors.cut_off_start}
                    />
                    <Form.Control.Feedback type="invalid">
                      {errors.cut_off_start}
                    </Form.Control.Feedback>
                  </Form.Group>
                  <Form.Label>&nbsp;{I18n.t("to")}&nbsp;&#x3c;&nbsp;</Form.Label>

                  <Form.Group controlId="validationCutOffEnd">
                    <Form.Control
                      name="cut_off_end"
                      value={values.cut_off_end}
                      onChange={handleChange}
                      // disabled={deployedMode}
                      isInvalid={touched.cut_off_end && !!errors.cut_off_end}
                    />
                    <Form.Control.Feedback type="invalid">
                      {errors.cut_off_end}
                    </Form.Control.Feedback>
                  </Form.Group>

                  <Form.Group controlId="validationCutOffValueType">
                    <Form.Control
                      as="select"
                      name="cut_off_value_type"
                      value={values.cut_off_value_type}
                      onChange={handleChange}
                      // disabled={deployedMode}
                      isInvalid={touched.cut_off_value_type && !!errors.cut_off_value_type}
                    >
                      <option value="months">{I18n.t("months")}</option>
                      <option value="days">{I18n.t("days")}</option>
                    </Form.Control>
                    <Form.Control.Feedback type="invalid">
                      {errors.cut_off_value_type}
                    </Form.Control.Feedback>
                  </Form.Group>
                </Form.Row>

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
