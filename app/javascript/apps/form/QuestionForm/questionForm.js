import * as React from "react";
import I18n from "i18n-js";
import FadeIn from "react-fade-in";
import Autocomplete, { createFilterOptions } from "@material-ui/lab/Autocomplete";
import TextField from "@material-ui/core/TextField";
import { Form, Button } from "react-bootstrap";
import { Formik } from "formik";

import DisplayErrors from "../components/DisplayErrors";
import Http from "../../diagram/engine/http";
import Loader from "../QuestionsSequenceForm";
import { questionSchema } from "../constants/schema";
import { CATEGORIES_DISPLAYING_SYSTEM, CATEGORIES_DISABLING_ANSWER_TYPE, NO_ANSWERS_ATTACHED_TYPE, NO_ANSWERS_ATTACHED_ANSWER_TYPE } from "../constants/constants";
import Chip from "@material-ui/core/Chip";

const humanizeString = require("humanize-string");
const filterOptions = createFilterOptions({
  stringify: option => option.label_translations.en
});

export default class FinalDiagnosticForm extends React.Component {
  constructor() {
    super();

    this.state = {
      snomedResults: [],
      snomedError: null,
      isLoading: true
    };

    this.init();
  }

  /**
   * Create question or go throw next step (answerForm)
   * @params [Object] values
   * @params [Object] actions
   */
  handleOnSubmit = async (values) => {
    const { setFormData, save, nextStep } = this.props;
    setFormData(values);
    if (NO_ANSWERS_ATTACHED_ANSWER_TYPE.includes(values.answer_type_id) || NO_ANSWERS_ATTACHED_TYPE.includes(values.type)) {
      save();
    } else {
      nextStep();
    }
  };

  /**
   * Fetch questions parameters for form
   */
  init = async () => {
    let http = new Http();
    let httpRequest = {};

    httpRequest = await http.fetchQuestionsLists();
    let result = await httpRequest.json();

    if (httpRequest.status === 200) {
      this.setState({
        answerTypes: result.answer_types,
        categories: result.categories,
        stages: result.stages,
        systems: result.systems,
        complaintCategories: result.complaint_categories,
        isLoading: false
      });
    }
  };

  /**
   * Search in snomed api to get results
   * @param [Object] event
   */
  searchSnomed = async (event) => {
    const http = new Http();
    let httpRequest = {};

    httpRequest = await http.searchSnomed(event.target.value);
    if (httpRequest?.status === 200) {
      let result = await httpRequest.json();

      this.setState({
        snomedResults: result.items,
        snomedError: null
      });
    } else {
      this.setState({ snomedError: { message: I18n.t("questions.errors.snomed_fetch_failed") } });
    }
  };

  /**
   * Save id and value of snomed selected
   * @param [Object] event
   */
  snomedChange = async (event, value) => {
    this.setState({
      snomedId: value.id,
      snomedLabel: value.fsn.term
    });
  };

  /**
   * Set value of answer type and stage depending on what category was chosen
   */
  categoryChanges = (event) => {
    let fieldsToSet = [];
    const category = event.target.value;

    // Set stage
    switch (category) {
      case "Questions::ConsultationRelated":
      case "Questions::Demographic":
        fieldsToSet.push(["stage", "registration"]);
        break;
      case "Questions::BasicMeasurement":
      case "Questions::ComplaintCategory":
      case "Questions::UniqueTriagePhysicalSign":
      case "Questions::UniqueTriageQuestion":
        fieldsToSet.push(["stage", "triage"]);
        break;
      case "Questions::AssessmentTest":
        fieldsToSet.push(["stage", "test"]);
        break;
      case "Questions::ChronicCondition":
      case "Questions::Exposure":
      case "Questions::ObservedPhysicalSign":
      case "Questions::PhysicalExam":
      case "Questions::Symptom":
      case "Questions::Vaccine":
      case "Questions::VitalSignAnthropometric":
        fieldsToSet.push(["stage", "consultation"]);
        break;
      case "Questions::TreatmentQuestion":
        fieldsToSet.push(["stage", "diagnosis_management"]);
        break;
      default:
        fieldsToSet.push(["stage", ""]);
    }

    // Set answer type
    if (["Questions::ComplaintCategory", "Questions::Vaccine"].includes(category)) {
      fieldsToSet.push(["answer_type_id", 1]);
    } else if (["Questions::BasicMeasurement", "Questions::VitalSignAnthropometric"].includes(category)) {
      fieldsToSet.push(["answer_type_id", 4]);
    } else if (category === "Questions::BackgroundCalculation") {
      fieldsToSet.push(["answer_type_id", 5]);
    }
    return fieldsToSet;
  };

  render() {
    const { formData } = this.props;

    const {
      answerTypes,
      categories,
      stages,
      systems,
      snomedResults,
      isLoading,
      snomedError,
      complaintCategories
    } = this.state;

    return (
      isLoading ? <Loader/> :
        <FadeIn>
          <Formik
            validationSchema={questionSchema}
            initialValues={formData}
            onSubmit={(values) => (this.handleOnSubmit(values))}
          >
            {({
                handleSubmit,
                handleChange,
                isSubmitting,
                setFieldValue,
                touched,
                values,
                errors,
                status
              }) => (
              <Form noValidate onSubmit={handleSubmit}>
                {status ? <DisplayErrors errors={status}/> : null}
                {snomedError ? <DisplayErrors errors={snomedError}/> : null}

                <Form.Group controlId="validationCategory">
                  <Form.Label>{I18n.t("activerecord.attributes.node.type")}</Form.Label>
                  <Form.Control
                    as="select"
                    name="type"
                    value={values.type}
                    onChange={e => {
                      handleChange(e);
                      this.categoryChanges(e).forEach(element => setFieldValue(element[0], element[1]));
                    }}
                    isInvalid={touched.type && !!errors.type}
                  >
                    <option value="">{I18n.t("select")}</option>
                    {categories.map(category => (
                      <option key={`category-${category.label}`} value={category.name}>{category.label}</option>
                    ))}
                  </Form.Control>
                  <Form.Control.Feedback type="invalid">
                    {errors.type}
                  </Form.Control.Feedback>
                </Form.Group>

                {CATEGORIES_DISPLAYING_SYSTEM.includes(values.type) ?
                  <Form.Group controlId="validationSystem">
                    <Form.Label>{I18n.t("activerecord.attributes.question.system")}</Form.Label>
                    <Form.Control
                      as="select"
                      name="system"
                      value={values.system}
                      onChange={handleChange}
                      isInvalid={touched.system && !!errors.system}
                    >
                      <option value="">{I18n.t("select")}</option>
                      {systems.map(system => (
                        <option key={`system-${system[1]}`} value={system[1]}>{system[0]}</option>
                      ))}
                    </Form.Control>
                    <Form.Control.Feedback type="invalid">
                      {errors.system}
                    </Form.Control.Feedback>
                  </Form.Group>
                  : null}

                <Form.Group controlId="validationAnswerType">
                  <Form.Label>{I18n.t("activerecord.attributes.question.answer_type")}</Form.Label>
                  <Form.Control
                    as="select"
                    name="answer_type_id"
                    value={values.answer_type_id}
                    onChange={e => {setFieldValue('answer_type_id', e.target.value !== "" ? parseInt(e.target.value) : e.target.value); }}
                    disabled={CATEGORIES_DISABLING_ANSWER_TYPE.includes(values.type)}
                    isInvalid={touched.answer_type_id && !!errors.answer_type_id}
                  >
                    <option value="">{I18n.t("select")}</option>
                    {answerTypes.map(answerType => (
                      <option key={`answerType-${answerType.id}`}
                              value={answerType.id}>{answerType.display_name}</option>
                    ))}
                  </Form.Control>
                  <Form.Control.Feedback type="invalid">
                    {errors.answer_type_id}
                  </Form.Control.Feedback>
                </Form.Group>

                {values.type !== "Questions::BackgroundCalculation" ?
                  <Form.Group controlId="validationStage">
                    <Form.Label>{I18n.t("activerecord.attributes.question.stage")}</Form.Label>
                    <Form.Control
                      as="select"
                      name="stage"
                      value={values.stage}
                      onChange={handleChange}
                      disabled={values.type !== ""}
                      isInvalid={touched.stage && !!errors.stage}
                    >
                      <option value="">{I18n.t("select")}</option>
                      {Object.keys(stages).map(key => (
                        <option key={`stages-${stages[key]}`} value={key}>{humanizeString(key)}</option>
                      ))}
                    </Form.Control>
                    <Form.Control.Feedback type="invalid">
                      {errors.stage}
                    </Form.Control.Feedback>
                  </Form.Group>
                  : null}

                <Form.Group controlId="validationIsMandatory">
                  <Form.Check
                    name="is_mandatory"
                    label={I18n.t("activerecord.attributes.question.is_mandatory")}
                    value={values.is_mandatory}
                    checked={values.is_mandatory}
                    onChange={handleChange}
                    isInvalid={touched.is_mandatory && !!errors.is_mandatory}
                  />
                  <Form.Control.Feedback type="invalid">
                    {errors.is_mandatory}
                  </Form.Control.Feedback>
                </Form.Group>

                <Form.Group controlId="validationLabel">
                  <Form.Label>{I18n.t("activerecord.attributes.node.label_translations")}</Form.Label>
                  <Form.Control
                    name="label_en"
                    value={values.label_en}
                    onChange={handleChange}
                    isInvalid={touched.label_en && !!errors.label_en}
                  />
                  <Form.Control.Feedback type="invalid">
                    {errors.label_en}
                  </Form.Control.Feedback>
                </Form.Group>

                <Form.Group controlId="validationSnomed">
                  <Form.Label>{I18n.t("activerecord.attributes.question.snomed")}</Form.Label>
                  <Autocomplete
                    name="snomed"
                    options={snomedResults}
                    getOptionLabel={option => option.fsn.term}
                    autoComplete
                    includeInputInList
                    freeSolo
                    disableOpenOnFocus
                    onChange={this.snomedChange}
                    renderInput={params => (
                      <TextField
                        {...params}
                        variant="outlined"
                        onChange={this.searchSnomed} fullWidth/>
                    )}
                  />
                </Form.Group>

                <Form.Group controlId="validationComplaintCategories">
                  <Form.Label>{I18n.t("activerecord.attributes.node.node")}</Form.Label>
                  <Autocomplete
                    autoComplete
                    multiple
                    freeSolo
                    filterSelectedOptions
                    name="complaint_categories_attributes"
                    options={complaintCategories.map(option => option)}
                    defaultValue={formData?.complaint_categories_attributes}
                    filterOptions={filterOptions}
                    onChange={(_, value) => setFieldValue("complaint_categories_attributes", value)}
                    renderOption={(option) => option.label_translations.en}
                    renderTags={(value, getTagProps) => (
                      value.map((option, index) => (
                        <Chip variant="outlined" label={option.label_translations.en} {...getTagProps({ index })} />
                      ))
                    )}
                    renderInput={params => (
                      <TextField
                        {...params}
                        variant="outlined"
                        fullWidth/>
                    )}
                  />
                </Form.Group>

                <Form.Group controlId="validationDescription">
                  <Form.Label>{I18n.t("activerecord.attributes.node.description_translations")}</Form.Label>
                  <Form.Control
                    name="description_en"
                    as="textarea"
                    value={values.description_en}
                    onChange={handleChange}
                    isInvalid={touched.description_en && !!errors.description_en}
                  />
                  <Form.Control.Feedback type="invalid">
                    {errors.description_en}
                  </Form.Control.Feedback>
                </Form.Group>

                {values.type === "Questions::AssessmentTest" ?
                  <Form.Group controlId="validationUnavailable">
                    <Form.Check
                      name="unavailable"
                      label={I18n.t("activerecord.attributes.question.unavailable")}
                      value={values.unavailable}
                      checked={values.unavailable}
                      onChange={handleChange}
                      isInvalid={touched.unavailable && !!errors.unavailable}
                    />
                    <Form.Control.Feedback type="invalid">
                      {errors.unavailable}
                    </Form.Control.Feedback>
                  </Form.Group>
                  : null}

                <Form.Group controlId="validationIsTriage">
                  <Form.Check
                    name="is_triage"
                    label={I18n.t("activerecord.attributes.question.is_triage")}
                    value={values.is_triage}
                    checked={values.is_triage}
                    onChange={handleChange}
                    isInvalid={touched.is_triage && !!errors.is_triage}
                  />
                  <Form.Control.Feedback type="invalid">
                    {errors.is_triage}
                  </Form.Control.Feedback>
                </Form.Group>

                <Form.Group controlId="validationIsIdnetifiable">
                  <Form.Check
                    name="is_identifiable"
                    label={I18n.t("activerecord.attributes.question.is_identifiable")}
                    value={values.is_identifiable}
                    checked={values.is_identifiable}
                    onChange={handleChange}
                    isInvalid={touched.is_identifiable && !!errors.is_identifiable}
                  />
                  <Form.Control.Feedback type="invalid">
                    {errors.is_identifiable}
                  </Form.Control.Feedback>
                </Form.Group>

                {values.answer_type_id === 5 ?
                  <Form.Group controlId="validationFormula">
                    <Form.Label>{I18n.t("activerecord.attributes.question.formula")}</Form.Label>
                    <Form.Control
                      name="formula"
                      as="textarea"
                      value={values.formula}
                      onChange={handleChange}
                      isInvalid={touched.formula && !!errors.formula}
                    />
                    <Form.Control.Feedback type="invalid">
                      {errors.formula}
                    </Form.Control.Feedback>
                  </Form.Group>
                  : null}

                <Button className="float-right" type="submit" disabled={isSubmitting}>
                  {I18n.t("next")}
                </Button>
              </Form>
            )}
          </Formik>
        </FadeIn>
    );
  }
};
