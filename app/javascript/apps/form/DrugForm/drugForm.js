import * as React from "react";
import I18n from "i18n-js";
import FadeIn from "react-fade-in";
import { Form, Button } from "react-bootstrap";
import { Formik } from "formik";

import { drugSchema } from "../constants/schema";
import {NO_ANSWERS_ATTACHED_ANSWER_TYPE, NO_ANSWERS_ATTACHED_TYPE} from "../constants/constants";

export default class DrugForm extends React.Component {

  /**
   * Create drug or go throw next step (formulationForm)
   * @params [Object] values
   */
  handleOnSubmit = (values) => {
    const { setFormData, save, nextStep, method, is_deployed } = this.props;
    setFormData(values);

    // Skip formulations form if the drug is deployed
    if (method === "update" && is_deployed) {
      save();
    } else {
      nextStep();
    }
  };

  render() {
    const { formData, setFormData, nextStep } = this.props;

    return (
      <FadeIn>
        <Formik
          validationSchema={drugSchema}
          initialValues={formData}
          onSubmit={values => {
            this.handleOnSubmit(values);
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
                    name="label_en"
                    value={values.label_en}
                    onChange={handleChange}
                    isInvalid={touched.label_en && !!errors.label_en}
                  />
                  <Form.Control.Feedback type="invalid">
                    {errors.label_en}
                  </Form.Control.Feedback>
                </Form.Group>

                <Form.Group controlId="validationDescription">
                  <Form.Label>{I18n.t("activerecord.attributes.node.description_translations")}</Form.Label>
                  <Form.Control
                    name="description_en"
                    as="textarea"
                    value={values.description_en}
                    onChange={handleChange}
                    isInvalid={touched.description_en && !!errors.description_en}
                  />
                  <Form.Control.Feedback type="invalid">
                    {errors.description_en}
                  </Form.Control.Feedback>
                </Form.Group>

                <Form.Group controlId="validationIsAntiMalarial">
                  <Form.Check
                    name="is_anti_malarial"
                    label={I18n.t("activerecord.attributes.drug.is_anti_malarial")}
                    value={values.is_anti_malarial}
                    checked={values.is_anti_malarial}
                    onChange={handleChange}
                    isInvalid={touched.is_anti_malarial && !!errors.is_anti_malarial}
                  />
                  <Form.Control.Feedback type="invalid">
                    {errors.is_anti_malarial}
                  </Form.Control.Feedback>
                </Form.Group>

                <Form.Group controlId="validationIsAntibiotic">
                  <Form.Check
                    name="is_antibiotic"
                    label={I18n.t("activerecord.attributes.drug.is_antibiotic")}
                    value={values.is_antibiotic}
                    checked={values.is_antibiotic}
                    onChange={handleChange}
                    isInvalid={touched.is_antibiotic && !!errors.is_antibiotic}
                  />
                  <Form.Control.Feedback type="invalid">
                    {errors.is_antibiotic}
                  </Form.Control.Feedback>
                </Form.Group>

                <Button className="float-right" type="submit">
                  {I18n.t("next")}
                </Button>
              </Form>
            )}
        </Formik>
      </FadeIn>
    );
  }
}
