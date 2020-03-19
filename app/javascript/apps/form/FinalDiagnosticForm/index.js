import * as React from "react";
import I18n from "i18n-js";
import { Form, Button } from "react-bootstrap";
import { Formik } from "formik";

import { finalDiagnosticSchema } from "../schema";
import DisplayErrors from "../DisplayErrors";
import Http from "../../diagram/engine/http";

export default class ScoreForm extends React.Component {

  handleOnSubmit = async (values, actions) => {
    const { method } = this.props;
    let http = new Http();
    let httpRequest = {};

    if (method === "create") {
      httpRequest = await http.createFinalDiagnostic(values.label_en, values.description_en);
    } else {
      httpRequest = await http.updateFinalDiagnostic(values.id, values.label_en, values.description_en);
    }

    let result = await httpRequest.json();

    if (httpRequest.status === 200) {

    } else {
      actions.setStatus({ result });
    }
  };

  render() {
    const { finalDiagnostic } = this.props;

    return (
      <Formik
        validationSchema={finalDiagnosticSchema}
        initialValues={{ finalDiagnostic }}
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
