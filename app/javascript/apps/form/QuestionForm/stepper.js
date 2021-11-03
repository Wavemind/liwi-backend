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
import { getTranslatedText, getStudyLanguage } from "../../utils";


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
    const language = getStudyLanguage();

    const body = {
      type: question?.type || "",
      system: question?.system || "",
      answer_type_id: question?.answer_type_id || "",
      stage: question?.stage || "",
      is_mandatory: question?.is_mandatory || false,
      is_neonat: question?.is_neonat || false,
      snomed: question?.snomed_label || "",
      unavailable: question?.unavailable || false,
      formula: question?.formula || "",
      is_triage: question?.is_triage || false,
      is_identifiable: question?.is_identifiable || false,
      is_pre_fill: question?.is_pre_fill || false,
      is_danger_sign: question?.is_danger_sign || false,
      emergency_status: question?.emergency_status || "",
      estimable: question?.estimable || false,
      is_default: question?.is_default || false,
      min_value_warning: question?.min_value_warning || "",
      max_value_warning: question?.max_value_warning || "",
      min_value_error: question?.min_value_error || "",
      max_value_error: question?.max_value_error || "",
      round: question?.round || "",
      complaint_categories_attributes: question?.complaint_categories || [],
      answers_attributes: question?.answers || [],
      // Don't touch this shit. Due to carrierwave give us to much info and json parsing create 2 element instead of one
      // OK I won't.
      medias_attributes: _.filter(question?.medias, (media) => {
        // return media.fileable_id !== undefined
      }) || []
    };

    body[`label_${language}`] = getTranslatedText(question?.label_translations, language);
    body[`description_${language}`] = getTranslatedText(question?.description_translations, language);
    body[`placeholder_${language}`] = getTranslatedText(question?.placeholder_translations, language);
    body[`min_message_warning_${language}`] = getTranslatedText(question?.min_message_warning_translations, language);
    body[`max_message_warning_${language}`] = getTranslatedText(question?.max_message_warning_translations, language);
    body[`min_message_error_${language}`] = getTranslatedText(question?.min_message_error_translations, language);
    body[`max_message_error_${language}`] = getTranslatedText(question?.max_message_error_translations, language);

    if (method === "update") {
      body["id"] = question.id;
      body["answers_attributes"] = [];

      // Generate hash cause of label_translation
      question.answers.forEach(answer => {
        const answerBody = {
          id: answer.id,
          operator: answer.operator,
          value: answer.value,
          _destroy: false
        };
        answerBody[`label_${language}`] = getTranslatedText(answer?.label_translations, language);
        body["answers_attributes"].push(answerBody);
      });

      // Generate hash cause of label_translation
      question.medias.forEach(media => {
        const mediaBody = {
          id: media.id,
          url: media.url,
          _destroy: false
        };
        mediaBody[`label_${language}`] = getTranslatedText(media?.label_translations, language);
        body["medias_attributes"].push(mediaBody);
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
    const { question, http } = this.state;
    const complaint_category_ids = [];
    let httpRequest = {};

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

    const result = await httpRequest.json();

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

    const httpRequest = await http.validateQuestion(question);
    const result = await httpRequest.json();

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
