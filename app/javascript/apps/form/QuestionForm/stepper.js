import * as React from "react";

import Http from "../../diagram/engine/http";
import store from "../../diagram/engine/reducers/store";
import { closeModal } from "../../diagram/engine/reducers/creators.actions";
import { createNode } from "../../diagram/helpers/nodeHelpers";
import QuestionForm from "./questionForm";
import AnswerForm from "./answerForm";
import FormulationForm from "../DrugForm/stepper";

export default class StepperQuestionForm extends React.Component {

  constructor(props) {
    super(props);

    const {question} = props;

    this.state = {
      step: 1,
      question: {
        id: question?.id || "",
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
      }
    };
  }

  /**
   * Set value in context
   * @param prop
   * @param value
   */
  setFormData = (prop, value) => {
    this.setState({ question: {[prop]: value }});
  };

  /**
   * Set step to next
   */
  nextStep = () => {
    const {step} = this.state;
    this.setState({step: step + 1})
  };

  /**
   * Set step to previous
   */
  previousStep = () => {
    const {step} = this.state;
    this.setState({step: step - 1})
  };

  render() {
    const {step, question} = this.state;
    const {method} = this.props;

    switch (step) {
      case 1:
        return (
          <QuestionForm
            formData={question}
            setFormData={this.setFormData}
            nextStep={this.nextStep}
            method={method}
          />
        );
      case 2:
        return (
          <AnswerForm
            formData={question}
            setFormData={this.setFormData}
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
