import I18n from "i18n-js";
import { CATEGORIES_DISPLAYING_SYSTEM } from "../../diagram/engine/constants/default";

let yup = require("yup");

export const scoreSchema = yup.object().shape({
  score: yup.number().required(I18n.t("errors.messages.required"))
});

export const answerSchema = yup.object().shape({
  label_translations: yup.string().required(I18n.t("errors.messages.required")),
  operator: yup.string().required(I18n.t("errors.messages.required")),
  value: yup.string().required(I18n.t("errors.messages.required"))
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
  system: yup.string().when("type", {
    is: (type) => CATEGORIES_DISPLAYING_SYSTEM.includes(type),
    then: yup.string().required(I18n.t("errors.messages.required"))
  }),
  answer_type: yup.string().required(I18n.t("errors.messages.required")),
  stage: yup.string().when("answer_type", {
    is: (type) => type !== "Questions::BackgroundCalculation",
    then: yup.string().required(I18n.t("errors.messages.required"))
  }),
  label_translations: yup.string().required(I18n.t("errors.messages.required")),
  description_translations: yup.string(),
  snomed: yup.string(),
  formula: yup.number()
    .when("answer_type", {
      is: (answer_type) => answer_type === "5",
      then: yup.number().required(I18n.t("errors.messages.required"))
    })
});

export const managementSchema = yup.object().shape({
  label_translations: yup.string().required(I18n.t("errors.messages.required")),
  description_translations: yup.string()
});

export const questionSequencesSchema = yup.object().shape({
  type: yup.string().required(I18n.t("errors.messages.required")),
  label_translations: yup.string().required(I18n.t("errors.messages.required")),
  description_translations: yup.string(),
  min_score: yup.number()
    .when("type", {
      is: (type) => type === "QuestionsSequences::Scored",
      then: yup.number().required(I18n.t("errors.messages.required"))
    })
});

export const formulationSchema = yup.object().shape({
  formulations_attributes: yup.array().of(yup.object().shape({
    doses_per_day: yup.number().required(I18n.t("errors.messages.required")),
    administration_route_id: yup.number().required(I18n.t("errors.messages.required")),
    by_age: yup.boolean(),
    breakable: yup.string()
      .when("medication_form", {
        is: (medication_form) => medication_form === "tablet",
        then: yup.string().required(I18n.t("errors.messages.required"))
      }),
    unique_dose: yup.number()
      .when("medication_form", {
        is: (medication_form) => !["tablet", "capsule", "suspension", "syrup"].includes(medication_form),
        then: yup.number().required(I18n.t("errors.messages.required"))
      })
      .when("by_age", {
        is: true,
        then: yup.number().required(I18n.t("errors.messages.required"))
      }),
    liquid_concentration: yup.number()
      .when("medication_form", {
        is: (medication_form) => ["suspension", "syrup"].includes(medication_form),
        then: yup.number().required(I18n.t("errors.messages.required"))
      }),
    dose_form: yup.number()
      .when("medication_form", {
        is: (medication_form) => ["tablet", "capsule", "suspension", "syrup"].includes(medication_form),
        then: yup.number().required(I18n.t("errors.messages.required"))
      }),
    maximal_dose: yup.number()
      .when("medication_form", {
        is: (medication_form) => ["tablet", "capsule", "suspension", "syrup"].includes(medication_form),
        then: yup.number().required(I18n.t("errors.messages.required"))
      }),
    minimal_dose_per_kg: yup.number()
      .when("medication_form", {
        is: (medication_form) => ["tablet", "capsule", "suspension", "syrup"].includes(medication_form),
        then: yup.number().required(I18n.t("errors.messages.required"))
      }),
    maximal_dose_per_kg: yup.number()
      .when("medication_form", {
        is: (medication_form) => ["tablet", "capsule", "suspension", "syrup"].includes(medication_form),
        then: yup.number().required(I18n.t("errors.messages.required"))
      })
  })).required("Must have at least 1 formulation").min(1, "Must have at least 1 formulation")
});
