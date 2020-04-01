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
      isLoading: true
    };

    this.init();
  }

  init = async () => {
    let http = new Http();
    let httpRequest = {};

    httpRequest = await http.fetchAnswerOperators();
    let result = await httpRequest.json();

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
    await setFormData("answers_attributes", values.formulations_attributes);
    save();
  };

  addAnswer = (arrayHelpers) => {
    arrayHelpers.push(JSON.parse(DEFAULT_ANSWER_VALUE));
  };

  removeAnswer(arrayHelpers, key) {
    arrayHelpers.remove(key);
  }

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
                            onClick={() => this.removeAnswer(arrayHelpers, key)}
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
                        <Button type="button" variant="primary" onClick={() => previousStep()}>
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
