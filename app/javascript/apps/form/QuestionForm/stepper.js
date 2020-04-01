import * as React from "react";

import Http from "../../diagram/engine/http";
import store from "../../diagram/engine/reducers/store";
import { closeModal } from "../../diagram/engine/reducers/creators.actions";
import { createNode } from "../../diagram/helpers/nodeHelpers";
import QuestionForm from "./questionForm";
import AnswerForm from "./answerForm";
import DisplayErrors from "../components/DisplayErrors";

export default class StepperQuestionForm extends React.Component {

  constructor(props) {
    super(props);

    const { question, method } = props;

    this.state = {
      errors: null,
      step: 2,
      question: this.questionBody(question, method)
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
      answers_attributes: question?.answers || []
    };

    if (method === "update") {
      body["id"] = question.id;
    }
    return body;
  };

  /**
   * Send value to server
   */
  save = async () => {
    const { method, from, engine, diagramObject, addAvailableNode } = this.props;
    let http = new Http();
    let httpRequest = {};

    if (method === "create") {
      // httpRequest = await http.createFinalDiagnostic(values.label_translations, values.description_translations, from);
    } else {
      // httpRequest = await http.updateFinalDiagnostic(values.id, values.label_translations, values.description_translations, from);
    }

    let result = await httpRequest.json();

    if (httpRequest.status === 200) {
      if (from === "rails") {
        window.location.replace(result.url);
      } else {
        if (method === "create") {
          let diagramInstance = createNode(result, addAvailableNode, false, "Diagnostic", engine);
          engine.getModel().addNode(diagramInstance);
        } else {
          diagramObject.options.dbInstance.node = result;
        }

        engine.repaintCanvas();

        store.dispatch(
          closeModal()
        );
      }
    } else {
      this.setState({ errors: result });
    }
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
    const { errors, step, question } = this.state;
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
          <>
            {errors ? <DisplayErrors errors={errors}/> : null}
            <AnswerForm
              formData={question}
              save={this.save}
              setFormData={this.setAnswerData}
              previousStep={this.previousStep}
              method={method}
            />
          </>
        );
      default:
        return <h1>{I18n.t('something_went_wrong')}</h1>;
    }
  }
}
