import I18n from "i18n-js";
let yup = require("yup");

export const updateScoreSchema = yup.object().shape({
  score: yup.number().required(I18n.t("errors.messages.required"))
});
