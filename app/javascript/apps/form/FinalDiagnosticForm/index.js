import * as React from "react";
import I18n from "i18n-js";
import { Form, Button } from "react-bootstrap";
import { Formik } from "formik";

import DisplayErrors from "../DisplayErrors";
import Http from "../../diagram/engine/http";
import store from "../../diagram/engine/reducers/store";
import { finalDiagnosticSchema } from "../schema";
import { closeModal } from "../../diagram/engine/reducers/creators.actions";
import { createNode } from "../../diagram/helpers/nodeHelpers";

export default class FinalDiagnosticForm extends React.Component {

  handleOnSubmit = async (values, actions) => {
    const { method, from, engine, diagramObject, addAvailableNode } = this.props;
    let http = new Http();
    let httpRequest = {};

    if (method === "create") {
      httpRequest = await http.createFinalDiagnostic(values.label_translations, values.description_translations, from);
    } else {
      httpRequest = await http.updateFinalDiagnostic(values.id, values.label_translations, values.description_translations, from);
    }

    let result = await httpRequest.json();

    if (httpRequest.status === 200) {
      if (from === 'rails') {
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
    const { finalDiagnostic } = this.props;

    return (
      <Formik
        validationSchema={finalDiagnosticSchema}
        initialValues={{
          id: finalDiagnostic?.id || "",
          label_translations: finalDiagnostic?.label_translations?.en || "",
          description_translations: finalDiagnostic?.description_translations?.en || ""
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
            <Form.Group controlId="validationLabel">
              <Form.Label>{I18n.t("activerecord.attributes.final_diagnostic.label_translations")}</Form.Label>
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

            <Form.Group controlId="validationDescription">
              <Form.Label>{I18n.t("activerecord.attributes.final_diagnostic.description_translations")}</Form.Label>
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
