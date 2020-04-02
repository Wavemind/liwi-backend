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
      step: 1,
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
      answer_type_id: question?.answer_type_id || "",
      stage: question?.stage || "",
      is_mandatory: question?.is_mandatory || false,
      label_en: question?.label_translations?.en || "",
      snomed: question?.snomed_label || "",
      description_en: question?.description_translations?.en || "",
      unavailable: question?.unavailable || false,
      formula: question?.formula || "",
      is_triage: question?.is_triage || false,
      is_identifiable: question?.is_identifiable || false,
      answers_attributes: question?.answers || []
    };

    if (method === "update") {
      body["id"] = question.id;
      body['answers_attributes'] = [];

      // Generate hash cause of label_translation
      question.answers.map(answer => {
        body['answers_attributes'].push({
          id: answer.id,
          label_en: answer.label_translations.en,
          operator: answer.operator,
          value: answer.value,
        })
      })
    } else {
      body["answers_attributes"] = []
    }
    return body;
  };

  /**
   * Send value to server
   */
  save = async () => {
    const { method, from, engine, diagramObject, addAvailableNode } = this.props;
    const {question} = this.state;
    let http = new Http();
    let httpRequest = {};

    if (method === "create") {
      httpRequest = await http.createQuestion(question, from);
    } else {
      httpRequest = await http.updateQuestion(question, from);
    }

    let result = await httpRequest.json();

    if (httpRequest.status === 200) {
      if (from === "rails") {
        window.location.replace(result.url);
      } else {
        if (method === "create") {
          let diagramInstance = createNode(result, addAvailableNode, false, result.node.category_name, engine);
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
   * Set value in context for answers
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
            save={this.save}
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
