export const DEFAULT_FORMULATION_VALUE = JSON.stringify({
  id: "",
  administration_route_id: "",
  minimal_dose_per_kg: "",
  maximal_dose_per_kg: "",
  maximal_dose: "",
  doses_per_day: "",
  dose_form: "",
  breakable: "",
  unique_dose: "",
  liquid_concentration: "",
  by_age: false
});

export const DEFAULT_ANSWER_VALUE = JSON.stringify({
  id: "",
  label_en: "",
  operator: "",
  value: "",
});

export const CATEGORIES_DISABLING_ANSWER_TYPE = [
  "Questions::ComplaintCategory",
  "Questions::BackgroundCalculation",
  "Questions::BasicMeasurement",
  "Questions::Vaccine",
  "Questions::VitalSignAnthropometric"
];

export const CATEGORIES_DISPLAYING_SYSTEM = [
  "Questions::ObservedPhysicalSign",
  "Questions::PhysicalExam",
  "Questions::Symptom"
];

export const NO_ANSWERS_ATTACHED_TYPE = [
  "Questions::VitalSignAnthropometric",
  "Questions::BasicMeasurement",
  "Questions::BasicDemographic"
];

export const CATEGORIES_DISPLAYING_FILTERABLE = [
  "Questions::BasicDemographic",
  "Questions::Demographic",
];

export const NO_ANSWERS_ATTACHED_ANSWER_TYPE = [
  1,
  6,
  7,
  8,
  9
];
