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

export const DEFAULT_MEDIA_VALUE = JSON.stringify({
  id: "",
  label_en: "",
  url: "",
});

export const CATEGORIES_DISABLING_ANSWER_TYPE = [
  "Questions::ComplaintCategory",
  "Questions::BackgroundCalculation",
  "Questions::BasicMeasurement",
  "Questions::Vaccine",
  "Questions::VitalSignAnthropometric"
];

export const CATEGORIES_DISPLAYING_SYSTEM = [
  "Questions::ChronicCondition",
  "Questions::Exposure",
  "Questions::ObservedPhysicalSign",
  "Questions::PhysicalExam",
  "Questions::Symptom",
  "Questions::Vaccine",
  "Questions::VitalSignAnthropometric"
];

export const NO_ANSWERS_ATTACHED_TYPE = [
  "Questions::VitalSignAnthropometric",
  "Questions::BasicMeasurement",
  "Questions::BasicDemographic"
];

export const CATEGORIES_DISPLAYING_UNAVAILABLE_OPTION = [
  "Questions::VitalSignAnthropometric",
  "Questions::BasicMeasurement",
  "Questions::AssessmentTest"
];

export const MEASUREMENT_CATEGORIES = [
  "Questions::VitalSignAnthropometric",
  "Questions::BasicMeasurement",
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

export const NUMERIC_ANSWER_TYPES = [
  3,
  4
];

export const INJECTION_ADMINISTRATION_ROUTES = [
  4,
  5,
  6
];

export const MEDICAL_HISTORY_SYSTEMS = [
  'priority_sign',
  'general',
  'respiratory_circulation',
  'ear_nose_mouth_throat',
  'digestive',
  'feeding',
  'urinary_reproductive',
  'nervous',
  'visual',
  'muscular_skeletal',
  'integumentary',
  'exposures',
  'complementary_medical_history',
  'prevention',
  'follow_up_questions'

];

export const PHYSICAL_EXAM_SYSTEMS = [
  'vital_sign',
  'general',
  'respiratory_circulation',
  'ear_nose_mouth_throat',
  'digestive',
  'urinary_reproductive',
  'nervous',
  'visual',
  'muscular_skeletal',
  'integumentary',
  'complementary_medical_history'
];
