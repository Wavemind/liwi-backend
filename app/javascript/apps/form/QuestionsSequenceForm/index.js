import * as React from "react";
import I18n from "i18n-js";
import { Form, Button } from "react-bootstrap";
import { Formik } from "formik";

import DisplayErrors from "../DisplayErrors";
import Http from "../../diagram/engine/http";
import store from "../../diagram/engine/reducers/store";
import { questionSequencesSchema } from "../schema";
import { closeModal } from "../../diagram/engine/reducers/creators.actions";
import { createNode } from "../../diagram/helpers/nodeHelpers";

export default class QuestionsSequenceForm extends React.Component {

  constructor() {
    super();

    this.state = {
      categories: [],
      isLoading: true
    };

    this.initForm();
  }

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
          let diagramInstance = createNode(result, addAvailableNode, false, "Diagnostic", engine);
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
    const { categories, isLoading } = this.state;

    return (
      isLoading ? null :
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
              errors,
              status
            }) => (
            <Form noValidate onSubmit={handleSubmit}>
              {status ? <DisplayErrors errors={status}/> : null}

              <Form.Group controlId="validationType">
                <Form.Label>{I18n.t("activerecord.attributes.questions_sequence.type")}</Form.Label>
                <Form.Control
                  as="select"
                  name="type"
                  value={values.type}
                  onChange={handleChange}
                  isInvalid={!!errors.type}
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
                <Form.Label>{I18n.t("activerecord.attributes.questions_sequence.label_translations")}</Form.Label>
                <Form.Control
                  name="label_translations"
                  value={values.label_translations}
                  onChange={handleChange}
                  isInvalid={!!errors.label_translations}
                />
                <Form.Control.Feedback type="invalid">
                  {errors.label_translations}
                </Form.Control.Feedback>
              </Form.Group>

              {values.type === "QuestionsSequences::Scored" ?
                <Form.Group controlId="validationMinScore">
                  <Form.Label>{I18n.t("activerecord.attributes.questions_sequence.min_score")}</Form.Label>
                  <Form.Control
                    name="min_score"
                    value={values.min_score}
                    onChange={handleChange}
                    isInvalid={!!errors.min_score}
                  />
                  <Form.Control.Feedback type="invalid">
                    {errors.min_score}
                  </Form.Control.Feedback>
                </Form.Group>
                : null}

              <Form.Group controlId="validationDescription">
                <Form.Label>{I18n.t("activerecord.attributes.questions_sequence.description_translations")}</Form.Label>
                <Form.Control
                  name="description_translations"
                  as="textarea"
                  value={values.description_translations}
                  onChange={handleChange}
                  isInvalid={!!errors.description_translations}
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
    );
  }
}
