import * as React from "react";
import * as _ from "lodash";
import I18n from "i18n-js";

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
      http: new Http(),
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
      is_emergency: question?.is_emergency || false,
      is_neonat: question?.is_neonat || false,
      label_en: question?.label_translations?.en || "",
      snomed: question?.snomed_label || "",
      description_en: question?.description_translations?.en || "",
      unavailable: question?.unavailable || false,
      formula: question?.formula || "",
      is_triage: question?.is_triage || false,
      is_identifiable: question?.is_identifiable || false,
      is_filterable: question?.is_filterable || false,
      is_danger_sign: question?.is_danger_sign || false,
      estimable: question?.estimable || false,
      is_default: question?.is_default || false,
      min_value_warning: question?.min_value_warning || "",
      max_value_warning: question?.max_value_warning || "",
      min_value_error: question?.min_value_error || "",
      max_value_error: question?.max_value_error || "",
      min_message_warning: question?.min_message_warning || "",
      max_message_warning: question?.max_message_warning || "",
      min_message_error: question?.min_message_error || "",
      max_message_error: question?.max_message_error || "",
      complaint_categories_attributes: question?.complaint_categories || [],
      answers_attributes: question?.answers || [],
      // Don't touch this shit. Due to carrierwave give us to much info and json parsing create 2 element instead of one
      // OK I won't.
      medias_attributes: _.filter(question?.medias, (media) => {
        // return media.fileable_id !== undefined
      }) || []
    };

    if (method === "update") {
      body["id"] = question.id;
      body["answers_attributes"] = [];

      // Generate hash cause of label_translation
      question.answers.map(answer => {
        body["answers_attributes"].push({
          id: answer.id,
          label_en: answer.label_translations.en,
          operator: answer.operator,
          value: answer.value,
          _destroy: false
        });
      });

      // Generate hash cause of label_translation
      question.medias.map(media => {
        body["medias_attributes"].push({
          id: media.id,
          url: media.url,
          label_en: media.label_translations.en,
          _destroy: false
        });
      });
    } else {
      body["answers_attributes"] = [];
    }
    return body;
  };

  /**
   * Send value to server
   */
  save = async (toDeleteAnswers, toDeleteMedias) => {
    const { method, from, engine, diagramObject, addAvailableNode } = this.props;
    let { question, http } = this.state;
    let httpRequest = {};
    let complaint_category_ids = [];

    toDeleteAnswers.map(answer_id => {
      question.answers_attributes.push({id: answer_id, _destroy: true});
    });

    toDeleteMedias.map(media_id => {
      question.medias_attributes.push({id: media_id, _destroy: true});
    });

    question.complaint_categories_attributes.map(cc => (complaint_category_ids.push(cc.id)));
    _.set(question, "complaint_category_ids", complaint_category_ids);

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
   * Validate question body before answers
   */
  validate = async () => {
    const { question, http } = this.state;

    let httpRequest = await http.validateQuestion(question);
    let result = await httpRequest.json();

    if (httpRequest.status !== 200) {
      this.setState({ errors: result });
      return false;
    }

    return true;
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
    this.setState({
      step: step + 1,
      errors: null
    });
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
    const { method, is_used, is_deployed } = this.props;
    switch (step) {
      case 1:
        return (
          <>
          <h1>{method === 'create' ? I18n.t("questions.new.title") : I18n.t("questions.edit.title")}</h1>
          <QuestionForm
            formData={question}
            setFormData={this.setMetaData}
            nextStep={this.nextStep}
            save={this.save}
            validate={this.validate}
            railsErrors={errors}
            method={method}
            is_used={is_used}
            is_deployed={is_deployed}
          />
          </>
        );
      case 2:
        return (
          <>
            <h1>{method === 'create' ? I18n.t("answers.new.title") : I18n.t("answers.edit.title")}</h1>
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
        return <h1>{I18n.t("something_went_wrong")}</h1>;
    }
  }
}
