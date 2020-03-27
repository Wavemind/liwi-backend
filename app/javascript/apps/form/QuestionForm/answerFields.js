import * as React from "react";
import I18n from "i18n-js";
import FadeIn from "react-fade-in";
import {Form} from "react-bootstrap";
import {Formik} from "formik";

import DisplayErrors from "../components/DisplayErrors";
import {formulationSchema} from "../constants/schema";

export default class AnswerFields extends React.Component {

  constructor(props) {
    super(props);
  }

  // Push the answer object to the container
  handleFormChange = (e) => {
    // Get the name and value by additional param for Select (can't get it in the usual way...)
    const name = event.target.name !== undefined ? event.target.name : e.target.name;
    let value = null;
    if (name === "by_age") {
      value = event.target.checked;
    } else if (name === "administration_route_id") {
      value = e.target.value;
    } else {
      value = event.target.value;
    }

    const {
      index,
      formulations,
      setFormulation
    } = this.props;

    let formulation = formulations[index];
    formulation[name] = value;

    setFormulation(index, formulation);
    this.forceUpdate(); // Since there is no more state component does not rerender itself. I force it to make the form work. TODO better way to do so
  };


  render() {
    const {
      answer,
      operators,
      values,
      index,
      handleChange,
      answer_type
    } = this.props;

    return (
      <FadeIn>
        <Form.Row>
          <Form.Group controlId="validationLabelTranslations">
            <Form.Label>{I18n.t("activerecord.attributes.node.label_translations")}</Form.Label>
            <Form.Control
              as="text"
              name="label_en"
              onChange={handleChange}
              value={values[index].label_translations}
              isInvalid={touched.label_translations && !!errors.label_translations}>
            </Form.Control>
            <Form.Control.Feedback type="invalid">
              {errors.label_translations}
            </Form.Control.Feedback>
          </Form.Group>
        </Form.Row>

        {/*Do not ask for value and operator if it is an array*/}
        {(values.answer_type !== 2) ? (
          <Form.Row>

            <Form.Group controlId="validationOperator">
              <Form.Label>{I18n.t("activerecord.attributes.answer.operator")}</Form.Label>
              <Form.Control
                as="select"
                name="operator"
                onChange={handleChange}
                value={values[index].operator}
                isInvalid={touched.operator && !!errors.operator}>
                <option value="">{I18n.t("select")}</option>
                {operators.map(operator => (
                  <option value={operator[1]}>{operator[0]}</option>
                ))}
              </Form.Control>
              <Form.Control.Feedback type="invalid">
                {errors.operator}
              </Form.Control.Feedback>
            </Form.Group>

            <Form.Group controlId="validationValue">
              <Form.Label>{I18n.t("activerecord.attributes.answer.value")}</Form.Label>
              <Form.Control
                as="text"
                name="value"
                onChange={handleChange}
                value={values[index].value}
                isInvalid={touched.value && !!errors.value}>
              </Form.Control>
              <Form.Control.Feedback type="invalid">
                {errors.value}
              </Form.Control.Feedback>
            </Form.Group>
          </Form.Row>
        ) : null}
      </FadeIn>
    );
  }
}
