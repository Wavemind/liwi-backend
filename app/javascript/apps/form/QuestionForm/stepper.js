import * as React from "react";

import Http from "../../diagram/engine/http";
import store from "../../diagram/engine/reducers/store";
import { closeModal } from "../../diagram/engine/reducers/creators.actions";
import { createNode } from "../../diagram/helpers/nodeHelpers";
import QuestionForm from "./questionForm";
import AnswerForm from "./answerForm";

export default class StepperQuestionForm extends React.Component {

  constructor(props) {
    super(props);

    const { question, method } = props;

    this.state = {
      errors: null,
      step: 1,
      question: this.questionBody(question, method),
    };
  }

  /**
   * Define state body for question. State change if we're in create or update method
   * @params [Object] drug
   * @params [String] method
   * @return [Object] question object for state
   */
  questionBody = (question, method) => {
    let body = {
      type: question?.type || "",
      system: question?.system || "",
      answer_type: question?.answer_type_id || "",
      stage: question?.stage || "",
      is_mandatory: question?.is_mandatory || "",
      label_translations: question?.label_translations?.en || "",
      snomed: question?.snomed_label || "",
      description_translations: question?.description_translations?.en || "",
      unavailable: question?.unavailable || "",
      formula: question?.formula || "",
      answers: question?.answers || []
    };

    if (method === "update") {
      body['id'] = question.id
    }
    return body;
  };

  /**
   * Set value in context for formulations
   * @param prop
   * @param value
   */
  setAnswerData = (prop, value) => {
    this.setState({ question: { ...this.state.question, [prop]: value } });
  };

  /**
   * Set value in context for meta data
   * @param values
   */
  setMetaData = (values) => {
    this.setState({ question: values });
  };

  /**
   * Set step to next
   */
  nextStep = () => {
    const { step } = this.state;
    this.setState({ step: step + 1 });
  };

  /**
   * Set step to previous
   */
  previousStep = () => {
    const { step } = this.state;
    this.setState({ step: step - 1 });
  };

  render() {
    const { step, question } = this.state;
    const { method } = this.props;

    switch (step) {
      case 1:
        return (
          <QuestionForm
            formData={question}
            setFormData={this.setMetaData}
            nextStep={this.nextStep}
            method={method}
          />
        );
      case 2:
        return (
          <AnswerForm
            formData={question}
            setFormData={this.setAnswerData}
            nextStep={this.nextStep}
            previousStep={this.previousStep}
            method={method}
          />
        );
      default:
        return "boom boom";
    }
  }
}
