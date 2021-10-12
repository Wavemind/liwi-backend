import * as React from "react";
import I18n from "i18n-js";
import FadeIn from "react-fade-in";
import { Form, Button } from "react-bootstrap";
import { Formik } from "formik";

import { drugSchema } from "../constants/schema";
import SliderComponent from "../components/Slider";
import {
  NO_ANSWERS_ATTACHED_ANSWER_TYPE,
  NO_ANSWERS_ATTACHED_TYPE
} from "../constants/constants";
import { getStudyLanguage } from "../../utils";

export default class DrugForm extends React.Component {
  /**
   * Create drug or go throw next step (formulationForm)
   * @params [Object] values
   */
  handleOnSubmit = values => {
    const { setFormData, save, nextStep, method, is_deployed } = this.props;
    setFormData(values);

    // Skip formulations form if the drug is deployed
    if (method === "update" && is_deployed) {
      save([]);
    } else {
      nextStep();
    }
  };

  render() {
    const { formData, setFormData, nextStep, is_deployed } = this.props;
    const language = getStudyLanguage();

    return (
      <FadeIn>
        <Formik
          validationSchema={drugSchema}
          initialValues={formData}
          onSubmit={values => {
            this.handleOnSubmit(values);
          }}
        >
          {({ handleChange, handleSubmit, values, errors, touched }) => (
            <Form noValidate onSubmit={handleSubmit}>
              <Form.Group controlId="validationLabel">
                <Form.Label>
                  {I18n.t("activerecord.attributes.node.label_translations")}
                </Form.Label>
                <Form.Control
                  name={`label_${language}`}
                  value={values[`label_${language}`]}
                  onChange={handleChange}
                  isInvalid={touched[`label_${language}`] && !!errors[`label_${language}`]}
                />
                <Form.Control.Feedback type="invalid">
                  {errors[`label_${language}`]}
                </Form.Control.Feedback>
              </Form.Group>

              <Form.Group controlId="validationDescription">
                <Form.Label>
                  {I18n.t(
                    "activerecord.attributes.node.description_translations"
                  )}
                </Form.Label>
                <Form.Control
                  name={`description_${language}`}
                  as="textarea"
                  value={values[`description_${language}`]}
                  onChange={handleChange}
                  isInvalid={touched[`description_${language}`] && !!errors[`description_${language}`]}
                />
                <Form.Control.Feedback type="invalid">
                  {errors[`description_${language}`]}
                </Form.Control.Feedback>
              </Form.Group>

              <Form.Group controlId="validationLevelOfUrgency">
                <Form.Label>
                  {I18n.t("activerecord.attributes.node.level_of_urgency")}
                </Form.Label>
                <Form.Control
                  name="level_of_urgency"
                  as={SliderComponent}
                  value={values.level_of_urgency}
                  onChange={handleChange}
                />
                <Form.Control.Feedback type="invalid">
                  {errors.level_of_urgency}
                </Form.Control.Feedback>
              </Form.Group>

              <Form.Group controlId="validationIsNeonat">
                <Form.Check
                  name="is_neonat"
                  label={I18n.t("activerecord.attributes.question.is_neonat")}
                  value={values.is_neonat}
                  checked={values.is_neonat}
                  onChange={handleChange}
                  disabled={is_deployed}
                  isInvalid={touched.is_neonat && !!errors.is_neonat}
                />
                <Form.Control.Feedback type="invalid">
                  {errors.is_neonat}
                </Form.Control.Feedback>
              </Form.Group>

              <Form.Group controlId="validationIsAntiMalarial">
                <Form.Check
                  name="is_anti_malarial"
                  label={I18n.t(
                    "activerecord.attributes.drug.is_anti_malarial"
                  )}
                  value={values.is_anti_malarial}
                  checked={values.is_anti_malarial}
                  onChange={handleChange}
                  disabled={is_deployed}
                  isInvalid={
                    touched.is_anti_malarial && !!errors.is_anti_malarial
                  }
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
                  disabled={is_deployed}
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
