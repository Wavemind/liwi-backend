import * as React from "react";
import I18n from "i18n-js";
import FadeIn from "react-fade-in";
import {Form, Col} from "react-bootstrap";
import {MEASUREMENT_CATEGORIES} from "../constants/constants";
import { getStudyLanguage } from "../../utils";

export default class AnswerFields extends React.Component {

  constructor(props) {
    super(props);

    this.state = {
      language: getStudyLanguage()
    };
  }

  /**
   * Display label error
   * @params [String] input
   * @return [String] label
   */
  displayErrors(input) {
    const {
      index, arrayHelpers: {form: {errors}}
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
      index, arrayHelpers: {form: {errors}}
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

    const { language } = this.state;
    const answer = values.answers_attributes[index];

    return (
      <FadeIn>
        <Form.Row>
          <Form.Group as={Col} controlId="validationLabelTranslations">
            <Form.Label>{I18n.t("activerecord.attributes.node.label_translations")}</Form.Label>
            <Form.Control
              name={`answers_attributes.${index}.label_${language}`}
              value={answer[`label_${language}`]}
              onChange={handleChange}
              isInvalid={this.isInvalid(`label_${language}`)}>
            </Form.Control>
            <Form.Control.Feedback type="invalid">
              {this.displayErrors(`label_${language}`)}
            </Form.Control.Feedback>
          </Form.Group>

          {/*Do not ask for value and operator if it is an array*/}
          {parseInt(values.answer_type_id) !== 2 ? (
            <>
              {!MEASUREMENT_CATEGORIES.includes(values.type) ?
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
              : null}

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
