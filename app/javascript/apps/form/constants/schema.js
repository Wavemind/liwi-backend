import I18n from "i18n-js";
import { CATEGORIES_DISPLAYING_SYSTEM } from "./constants";

let yup = require("yup");

export const scoreSchema = yup.object().shape({
  score: yup.number().required(I18n.t("errors.messages.required"))
});

export const answerSchema = yup.object().shape({
  answers_attributes: yup.array().of(yup.object().shape({
    label_en: yup.string().required(I18n.t("errors.messages.required")),
    operator: yup.string(),
    value: yup.string()
  }))
});

export const drugSchema = yup.object().shape({
  label_en: yup.string().required(I18n.t("errors.messages.required")),
  description_en: yup.string()
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
  answer_type_id: yup.string().required(I18n.t("errors.messages.required")),
  stage: yup.string().when("answer_type", {
    is: (type) => type !== "Questions::BackgroundCalculation",
    then: yup.string().required(I18n.t("errors.messages.required"))
  }),
  label_en: yup.string().required(I18n.t("errors.messages.required")),
  description_en: yup.string(),
  snomed: yup.string(),
  formula: yup.string()
    .when("answer_type_id", {
      is: (answer_type_id) => answer_type_id === 5,
      then: yup.string().required(I18n.t("errors.messages.required"))
    })
});

export const managementSchema = yup.object().shape({
  label_translations: yup.string().required(I18n.t("errors.messages.required")),
  description_translations: yup.string()
});

export const drugInstanceSchema = yup.object().shape({
  duration: yup.string().required(I18n.t("errors.messages.required")),
  description: yup.string()
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
    breakable: yup.string().nullable()
      .when(['medication_form', 'by_age'], {
        is: (medication_form, by_age) => medication_form === "tablet" && by_age === false,
        then: yup.string().required(I18n.t("errors.messages.required"))
      }),
    unique_dose: yup.number().nullable()
      .when("medication_form", {
        is: (medication_form) => !["tablet", "capsule", "suspension", "syrup"].includes(medication_form),
        then: yup.number().required(I18n.t("errors.messages.required"))
      })
      .when("by_age", {
        is: true,
        then: yup.number().required(I18n.t("errors.messages.required"))
      }),
    liquid_concentration: yup.number().nullable()
      .when(['medication_form', 'by_age'], {
        is: (medication_form, by_age) => ["suspension", "syrup"].includes(medication_form) && by_age === false,
        then: yup.number().required(I18n.t("errors.messages.required"))
      }),
    dose_form: yup.number().nullable()
      .when(['medication_form', 'by_age'], {
        is: (medication_form, by_age) => ["tablet", "capsule", "suspension", "syrup"].includes(medication_form) && by_age === false,
        then: yup.number().required(I18n.t("errors.messages.required"))
      }),
    maximal_dose: yup.number().nullable()
      .when(['medication_form', 'by_age'], {
        is: (medication_form, by_age) => ["tablet", "capsule", "suspension", "syrup"].includes(medication_form) && by_age === false,
        then: yup.number().required(I18n.t("errors.messages.required"))
      }),
    minimal_dose_per_kg: yup.number().nullable()
      .when(['medication_form', 'by_age'], {
        is: (medication_form, by_age) => ["tablet", "capsule", "suspension", "syrup"].includes(medication_form) && by_age === false,
        then: yup.number().required(I18n.t("errors.messages.required"))
      }),
    maximal_dose_per_kg: yup.number().nullable()
      .when(['medication_form', 'by_age'], {
        is: (medication_form, by_age) => ["tablet", "capsule", "suspension", "syrup"].includes(medication_form) && by_age === false,
        then: yup.number().required(I18n.t("errors.messages.required"))
      })
  }))
});
