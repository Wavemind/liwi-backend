import I18n from "i18n-js";
let yup = require("yup");

export const scoreSchema = yup.object().shape({
  score: yup.number().required(I18n.t("errors.messages.required"))
});

export const finalDiagnosticSchema = yup.object().shape({
  label_translations: yup.string().required(I18n.t("errors.messages.required")),
  description_translations: yup.string().required(I18n.t("errors.messages.required"))
});
