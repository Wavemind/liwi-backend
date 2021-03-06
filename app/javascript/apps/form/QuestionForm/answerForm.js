import * as React from "react";
import I18n from "i18n-js";
import FadeIn from "react-fade-in";
import { FieldArray, Formik } from "formik";
import { Form, Button, Col } from "react-bootstrap";

import AnswerFields from "./answerFields";
import { DEFAULT_ANSWER_VALUE } from "../constants/constants";
import { answerSchema } from "../constants/schema";
import Http from "../../diagram/engine/http";
import Loader from "../components/Loader";


export default class AnswerForm extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      operators: [],
      toDeleteAnswers: [],
      isLoading: true
    };

    this.init();
  }

  /**
   * Fetch answer operators
   */
  init = async () => {
    const http = new Http();

    const httpRequest = await http.fetchAnswerOperators();
    const result = await httpRequest.json();

    if (httpRequest.status === 200) {
      this.setState({
        operators: result,
        isLoading: false
      });
    }
  };

  /**
   * Set answers attributes in stepper.js state + launch save method in stepper.js
   * @params [Object] values
   */
  handleOnSubmit = async (values) => {
    const { setFormData, save } = this.props;
    const { toDeleteAnswers } = this.state;
    await setFormData("answers_attributes", values.answers_attributes);
    save(toDeleteAnswers, []);
  };

  /**
   * Add answer in answers array of formik "values" variable
   * @params [Object] arrayHelpers
   */
  addAnswer = (arrayHelpers) => {
    arrayHelpers.push(JSON.parse(DEFAULT_ANSWER_VALUE));
  };

  removeAnswer = (key, arrayHelpers, values) => {
    // Workaround to delete properly answers in rails TODO : Find a better solution to do it
    const { toDeleteAnswers } = this.state;
    if (values.answers_attributes[key].id !== undefined) {
      toDeleteAnswers.push(values.answers_attributes[key].id);
    }
    this.setState({toDeleteAnswers});
    arrayHelpers.remove(key);
  };

  render() {
    const { isLoading, operators } = this.state;
    const { formData, previousStep } = this.props;

    return (
      isLoading ? <Loader/> :
      <FadeIn>
        <Formik
          validationSchema={answerSchema}
          initialValues={formData}
          validateOnChange={false}
          onSubmit={(values, actions) => this.handleOnSubmit(values, actions)}
        >
          {({
              handleSubmit,
              isSubmitting,
              values
            }) => (
            <Form noValidate onSubmit={handleSubmit}>
              <FieldArray
                name="answers_attributes"
                render={arrayHelpers => (
                  <>
                    {values.answers_attributes.map((answer, key) => (
                      <Form.Row key={key}>
                        <Col lg="10">
                          <AnswerFields
                            operators={operators}
                            arrayHelpers={arrayHelpers}
                            index={key}
                          />
                        </Col>
                        <Col className="align-self-center">
                          <Button
                            className="float-right"
                            variant="danger"
                            onClick={(() => this.removeAnswer(key, arrayHelpers, values))}
                          >
                            {I18n.t("remove")}
                          </Button>

                      </Col>
                      </Form.Row>
                    ))}
                    <Form.Row className="mt-5">
                      <Button className="btn-block" type="button" variant="success" onClick={() => this.addAnswer(arrayHelpers)}>
                        {I18n.t("add")}
                      </Button>
                    </Form.Row>

                    <Form.Row className="mt-5">
                      <Col>
                        <Button type="button" variant="default" onClick={() => previousStep()}>
                          {I18n.t("back")}
                        </Button>
                      </Col>
                      <Col>
                        <Button
                          className="float-right"
                          type="submit"
                          variant="success"
                          disabled={isSubmitting || values.answers_attributes.length === 0}
                        >
                          {I18n.t("save")}
                        </Button>
                      </Col>
                    </Form.Row>
                  </>
                )}
              />
            </Form>
          )}
        </Formik>
      </FadeIn>
    );
  }
}
