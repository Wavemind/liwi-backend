import * as React from "react";
import I18n from "i18n-js";
import FadeIn from "react-fade-in";
import { Form, Col } from "react-bootstrap";

export default class AnswerFields extends React.Component {

  constructor(props) {
    super(props);
  }

  /**
   * Display label error
   * @params [String] input
   * @return [String] label
   */
  displayErrors(input) {
    const {
      index, arrayHelpers: { form: { errors } }
    } = this.props;

    return errors?.answers_attributes !== undefined && errors?.answers_attributes[index]?.[input];
  }

  /**
   * Test if input has an error
   * @params [String] input
   * @return [Boolean] error ?
   */
  isInvalid(input) {
    const {
      index, arrayHelpers: { form: { errors } }
    } = this.props;

    return errors?.answers_attributes !== undefined && !!errors?.answers_attributes[index]?.[input];
  }

  render() {
    const {
      arrayHelpers: {
        form: {
          handleChange,
          values
        }
      },
      index,
      operators
    } = this.props;

    let answer = values.answers_attributes[index];

    return (
      <FadeIn>
        <Form.Row>
          <Form.Group as={Col} controlId="validationLabelTranslations">
            <Form.Label>{I18n.t("activerecord.attributes.node.label_translations")}</Form.Label>
            <Form.Control
              name={`answers_attributes.${index}.label_en`}
              value={answer.label_en}
              onChange={handleChange}
              isInvalid={this.isInvalid("label_en")}>
            </Form.Control>
            <Form.Control.Feedback type="invalid">
              {this.displayErrors("label_en")}
            </Form.Control.Feedback>
          </Form.Group>

          {/*Do not ask for value and operator if it is an array*/}
          {values.answer_type !== 2 ? (
            <>
              <Form.Group as={Col} controlId="validationOperator">
                <Form.Label>{I18n.t("activerecord.attributes.answer.operator")}</Form.Label>
                <Form.Control
                  as="select"
                  name={`answers_attributes.${index}.operator`}
                  onChange={handleChange}
                  value={answer.operator}
                  isInvalid={this.isInvalid("operator")}>
                  <option value="">{I18n.t("select")}</option>
                  {operators.map(operator => (
                    <option key={`operator-${operator[1]}`} value={operator[1]}>{operator[0]}</option>
                  ))}
                </Form.Control>
                <Form.Control.Feedback type="invalid">
                  {this.displayErrors("operator")}
                </Form.Control.Feedback>
              </Form.Group>

              <Form.Group as={Col} controlId="validationValue">
                <Form.Label>{I18n.t("activerecord.attributes.answer.value")}</Form.Label>
                <Form.Control
                  name={`answers_attributes.${index}.value`}
                  onChange={handleChange}
                  value={answer.value}
                  isInvalid={this.isInvalid("value")}>
                </Form.Control>
                <Form.Control.Feedback type="invalid">
                  {this.displayErrors("value")}
                </Form.Control.Feedback>
              </Form.Group>
            </>
          ) : null}
        </Form.Row>
      </FadeIn>
    );
  }
}
