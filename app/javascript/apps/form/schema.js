import I18n from "i18n-js";
let yup = require("yup");

export const scoreSchema = yup.object().shape({
  score: yup.number().required(I18n.t("errors.messages.required"))
});

export const finalDiagnosticSchema = yup.object().shape({
  label_translations: yup.string().required(I18n.t("errors.messages.required")),
  description_translations: yup.string()
});

export const questionSchema = yup.object().shape({
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
