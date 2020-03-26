import * as React from "react";
import I18n from "i18n-js";
import FadeIn from "react-fade-in";
import { Form, Button } from "react-bootstrap";
import { Formik } from "formik";

import { drugSchema } from "../constants/schema";


export default class DrugForm extends React.Component {
  render() {
    const { formData, setFormData, nextStep } = this.props;

    return (
      <FadeIn>
        <Formik
          validationSchema={drugSchema}
          initialValues={formData}
          onSubmit={values => {
            setFormData(values);
            nextStep();
          }}
        >
          {({
              handleChange,
              handleSubmit,
              values,
              errors,
              touched
            }) => (
            <Form noValidate onSubmit={handleSubmit}>
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

              <Button type="submit">
                {I18n.t("save")}
              </Button>
            </Form>
          )}
        </Formik>
      </FadeIn>
    );
  }
}
