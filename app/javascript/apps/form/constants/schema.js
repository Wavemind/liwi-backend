import I18n from "i18n-js";
import {CATEGORIES_DISPLAYING_SYSTEM} from "../../diagram/engine/constants/default";
let yup = require("yup");

export const scoreSchema = yup.object().shape({
  score: yup.number().required(I18n.t("errors.messages.required"))
});

export const drugSchema = yup.object().shape({
  label_translations: yup.string().required(I18n.t("errors.messages.required")),
  description_translations: yup.string()
});

export const finalDiagnosticSchema = yup.object().shape({
  label_translations: yup.string().required(I18n.t("errors.messages.required")),
  description_translations: yup.string()
});

export const questionSchema = yup.object().shape({
  type: yup.string().required(I18n.t("errors.messages.required")),
  system: yup.string().when('type', {
    is: (type) => CATEGORIES_DISPLAYING_SYSTEM.includes(type),
    then: yup.string().required(I18n.t("errors.messages.required"))
  }),
  answer_type: yup.string().required(I18n.t("errors.messages.required")),
  stage: yup.string().required(I18n.t("errors.messages.required")),
  label_translations: yup.string().required(I18n.t("errors.messages.required")),
  description_translations: yup.string(),
  snomed: yup.string(),
  formula: yup.number()
    .when('answer_type', {
      is: (answer_type) => answer_type === '5',
      then: yup.number().required(I18n.t("errors.messages.required"))
    })
});

export const managementSchema = yup.object().shape({
  label_translations: yup.string().required(I18n.t("errors.messages.required")),
  description_translations: yup.string()
});

export const questionSequencesSchema = yup.object().shape({
  type : yup.string().required(I18n.t("errors.messages.required")),
  label_translations: yup.string().required(I18n.t("errors.messages.required")),
  description_translations: yup.string(),
  min_score: yup.number()
    .when('type', {
      is: (type) => type === 'QuestionsSequences::Scored',
      then: yup.number().required(I18n.t("errors.messages.required"))
    })
});

export const formulationSchema = yup.object().shape({

});
