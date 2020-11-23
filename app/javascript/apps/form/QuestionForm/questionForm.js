import * as React from "react";
import I18n from "i18n-js";
import FadeIn from "react-fade-in";
import Autocomplete, { createFilterOptions } from "@material-ui/lab/Autocomplete";
import TextField from "@material-ui/core/TextField";
import {Form, Button} from "react-bootstrap";
import {Formik} from "formik";

import DisplayErrors from "../components/DisplayErrors";
import Http from "../../diagram/engine/http";
import Loader from "../QuestionsSequenceForm";
import { questionSchema } from "../constants/schema";
import {
  CATEGORIES_DISPLAYING_SYSTEM,
  CATEGORIES_DISABLING_ANSWER_TYPE,
  NO_ANSWERS_ATTACHED_TYPE,
  NO_ANSWERS_ATTACHED_ANSWER_TYPE,
  NUMERIC_ANSWER_TYPES,
  SYMPTOM_SYSTEMS,
  OBSERVED_PHYSICAL_SIGN_SYSTEMS,
  CHRONIC_CONDITION_SYSTEMS,
  EXPOSURE_SYSTEMS,
  VACCINE_SYSTEMS,
  VITAL_SIGN_SYSTEMS,
  PHYSICAL_EXAM_SYSTEMS,
} from "../constants/constants";
import Chip from "@material-ui/core/Chip";
import Overlay from "react-bootstrap/Overlay";
import Popover from "react-bootstrap/Popover";
import AnswerFields from "./answerForm";
import MediaForm from "../MediaForm/mediaForm";

const humanizeString = require("humanize-string");
const filterOptions = createFilterOptions({
  stringify: option => option.label_translations.en
});

export default class QuestionForm extends React.Component {
  constructor(props) {
    super(props);

    const { formData } = this.props;

    this.state = {
      updateMode: props.method === "update",
      deployedMode: props.method === "update" && props.is_deployed,
      snomedResults: [],
      snomedError: null,
      isLoading: true,
      formulaTooltipShow: false,
      target: null,
      toDeleteMedias: [],
      systems: this.generateSystemList(formData.type)
    };

    this.init();
  }

  /**
   * Create question or go throw next step (answerForm)
   * @params [Object] values
   * @params [Object] actions
   */
  handleOnSubmit = async (values) => {
    const { setFormData, save, validate, nextStep, method, is_used, is_deployed } = this.props;
    const { updateMode, toDeleteMedias } = this.state;
    setFormData(values);
    // Skip answers form if the question type doesn't have any OR if the answers are automatically generated (boolean) or if it is edit mode and the question is already used
    if (NO_ANSWERS_ATTACHED_ANSWER_TYPE.includes(values.answer_type_id) || NO_ANSWERS_ATTACHED_TYPE.includes(values.type) || (updateMode && (is_used || is_deployed))) {
      save([], toDeleteMedias);
    } else {
      const validated = await validate();
      if (validated) {
        nextStep();
      }
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
        emergency_statuses: result.emergency_statuses,
        complaintCategories: result.complaint_categories,
        isLoading: false
      });
    }
  };

  /**
   * Suppress entry in media
   * @param id
   * @returns {Promise<void>}
   */
  setDeletedMedia = async (id) => {
    const { toDeleteMedias } = this.state;
    toDeleteMedias.push(id);
    this.setState({toDeleteMedias})
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

  generateSystemList = (category) => {
    // Set systems list depending on the category
    let systems = [];
    switch (category) {
      case "Questions::ChronicCondition":
        systems = CHRONIC_CONDITION_SYSTEMS;
        break;
      case "Questions::Exposure":
        systems = EXPOSURE_SYSTEMS;
        break;
      case "Questions::ObservedPhysicalSign":
        systems = OBSERVED_PHYSICAL_SIGN_SYSTEMS;
        break;
      case "Questions::PhysicalExam":
        systems = PHYSICAL_EXAM_SYSTEMS;
        break;
      case "Questions::Symptom":
        systems = SYMPTOM_SYSTEMS;
        break;
      case "Questions::Vaccine":
        systems = VACCINE_SYSTEMS;
        break;
      case "Questions::VitalSignAnthropometric":
        systems = VITAL_SIGN_SYSTEMS;
        break;
      default:
        break;
    }
    return systems;
  };

  /**
   * Set value of answer type and stage depending on what category was chosen
   */
  categoryChanges = (event) => {
    let fieldsToSet = [];
    const category = event.target.value;

    // Set systems list depending on category
    this.setState({systems: this.generateSystemList(category)});

    // Set stage
    switch (category) {
      case "Questions::BasicDemographic":
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

  // Set status of formula tooltip
  handleFormulaTooltip = (event) => {
    const { formulaTooltipShow } = this.state;

    this.setState({
      formulaTooltipShow : !formulaTooltipShow,
      target: event.target
    });
  };

  render() {
    const { formData, railsErrors } = this.props;

    const {
      answerTypes,
      categories,
      stages,
      systems,
      emergency_statuses,
      snomedResults,
      isLoading,
      snomedError,
      complaintCategories,
      updateMode,
      deployedMode,
      formulaTooltipShow,
      target
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
              }) => {
              return (<Form noValidate onSubmit={handleSubmit}>
                {railsErrors ? <DisplayErrors errors={railsErrors}/> : null}
                {status ? <DisplayErrors errors={status}/> : null}
                {snomedError ? <DisplayErrors errors={snomedError}/> : null}

                <Form.Group controlId="validationCategory">
                  <Form.Label>{I18n.t("activerecord.attributes.node.type")}</Form.Label>
                  <Form.Control
                    as="select"
                    name="type"
                    value={values.type}
                    disabled={updateMode}
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
                        <option key={`system-${system}`} value={system}>{I18n.t(`questions.systems.${system}`)}</option>
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
                    onChange={e => {
                      setFieldValue("answer_type_id", e.target.value !== "" ? parseInt(e.target.value) : e.target.value);
                    }}
                    disabled={updateMode || CATEGORIES_DISABLING_ANSWER_TYPE.includes(values.type)}
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

                <Form.Group controlId="validationEmergencyStatus">
                  <Form.Label>{I18n.t("activerecord.attributes.question.emergency_status")}</Form.Label>
                  <Form.Control
                    as="select"
                    name="emergency_status"
                    value={values.emergency_status}
                    onChange={handleChange}
                    disabled={deployedMode}
                    isInvalid={touched.emergency_status && !!errors.emergency_status}
                  >
                    <option value="">{I18n.t("select")}</option>
                    {Object.keys(emergency_statuses).map(key => (
                      <option key={`stages-${emergency_statuses[key]}`} value={key}>{humanizeString(key)}</option>
                    ))}
                  </Form.Control>
                  <Form.Control.Feedback type="invalid">
                    {errors.emergency_status}
                  </Form.Control.Feedback>
                </Form.Group>

                <Form.Group controlId="validationIsMandatory">
                  <Form.Check
                    name="is_mandatory"
                    label={I18n.t("activerecord.attributes.question.is_mandatory")}
                    value={values.is_mandatory}
                    checked={values.is_mandatory}
                    onChange={handleChange}
                    disabled={deployedMode}
                    isInvalid={touched.is_mandatory && !!errors.is_mandatory}
                  />
                  <Form.Control.Feedback type="invalid">
                    {errors.is_mandatory}
                  </Form.Control.Feedback>
                </Form.Group>

                {values.type === "Questions::ComplaintCategory" ?
                  <Form.Group controlId="validationIsNeonat">
                    <Form.Check
                      name="is_neonat"
                      label={I18n.t("activerecord.attributes.question.is_neonat")}
                      value={values.is_neonat}
                      checked={values.is_neonat}
                      onChange={handleChange}
                      disabled={deployedMode}
                      isInvalid={touched.is_neonat && !!errors.is_neonat}
                    />
                    <Form.Control.Feedback type="invalid">
                      {errors.is_neonat}
                    </Form.Control.Feedback>
                  </Form.Group>
                : null}

                {values.type === "Questions::AssessmentTest" ?
                  <Form.Group controlId="validationUnavailable">
                    <Form.Check
                      name="unavailable"
                      label={I18n.t("activerecord.attributes.question.unavailable")}
                      value={values.unavailable}
                      checked={values.unavailable}
                      onChange={handleChange}
                      disabled={updateMode}
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
                    disabled={deployedMode}
                    checked={values.is_triage}
                    onChange={handleChange}
                    isInvalid={touched.is_triage && !!errors.is_triage}
                  />
                  <Form.Control.Feedback type="invalid">
                    {errors.is_triage}
                  </Form.Control.Feedback>
                </Form.Group>

                <Form.Group controlId="validationIsIdentifiable">
                  <Form.Check
                    name="is_identifiable"
                    label={I18n.t("activerecord.attributes.question.is_identifiable")}
                    value={values.is_identifiable}
                    disabled={deployedMode}
                    checked={values.is_identifiable}
                    onChange={handleChange}
                    isInvalid={touched.is_identifiable && !!errors.is_identifiable}
                  />
                  <Form.Control.Feedback type="invalid">
                    {errors.is_identifiable}
                  </Form.Control.Feedback>
                </Form.Group>

                {"Questions::BasicMeasurement" === values.type ?
                  <Form.Group controlId="validationEstimable">
                    <Form.Check
                      name="estimable"
                      label={I18n.t("activerecord.attributes.question.estimable")}
                      value={values.estimable}
                      disabled={deployedMode}
                      checked={values.estimable}
                      onChange={handleChange}
                      isInvalid={touched.estimable && !!errors.estimable}
                    />
                    <Form.Control.Feedback type="invalid">
                      {errors.estimable}
                    </Form.Control.Feedback>
                  </Form.Group>
                : null}

                  <Form.Group controlId="validationIsDangerSign">
                    <Form.Check
                      name="is_danger_sign"
                      label={I18n.t("activerecord.attributes.question.is_danger_sign")}
                      value={values.is_danger_sign}
                      checked={values.is_danger_sign}
                      onChange={handleChange}
                      disabled={deployedMode}
                      isInvalid={touched.is_danger_sign && !!errors.is_danger_sign}
                    />
                    <Form.Control.Feedback type="invalid">
                      {errors.is_danger_sign}
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
                    onChange={this.snomedChange}
                    renderInput={params => (
                      <TextField
                        {...params}
                        variant="outlined"
                        onChange={this.searchSnomed} fullWidth/>
                    )}
                  />
                </Form.Group>

                {values.type !== "Questions::ComplaintCategory" ?
                  <Form.Group controlId="validationComplaintCategories">
                    <Form.Label>
                      <p dangerouslySetInnerHTML={{__html: I18n.t("activerecord.attributes.node.node")}}/>
                    </Form.Label>
                    <Autocomplete
                      autoComplete
                      multiple
                      freeSolo
                      filterSelectedOptions
                      name="complaint_categories_attributes"
                      options={complaintCategories.map(option => option)}
                      defaultValue={formData?.complaint_categories_attributes}
                      filterOptions={filterOptions}
                      disabled={deployedMode}
                      onChange={(_, value) => setFieldValue("complaint_categories_attributes", value)}
                      renderOption={(option) => option.label_translations.en}
                      renderTags={(value, getTagProps) => (
                        value.map((option, index) => (
                          <Chip variant="outlined" label={option.label_translations.en} {...getTagProps({index})} />
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
                  : null}

                {values.answer_type_id === 5 ?
                  <>
                    <Form.Group controlId="validationFormula">
                      <Form.Label>
                        {I18n.t("activerecord.attributes.question.formula")}
                        <button type="button" className="btn btn-sm btn-info help" onClick={this.handleFormulaTooltip}>
                          <i className="material-icons">
                            help_outline
                          </i>
                        </button>
                      </Form.Label>
                      <Form.Control
                        name="formula"
                        as="textarea"
                        disabled={deployedMode}
                        value={values.formula}
                        onChange={handleChange}
                        isInvalid={touched.formula && !!errors.formula}
                      />
                      <Form.Control.Feedback type="invalid">
                        {errors.formula}
                      </Form.Control.Feedback>
                    </Form.Group>

                    <Overlay
                      show={formulaTooltipShow}
                      target={target}
                      placement="right"
                      containerPadding={50}
                    >
                      <Popover id="popover-contained">
                        <Popover.Title as="h3">{I18n.t("helps.formula.formula-tooltip-title")}</Popover.Title>
                        <Popover.Content>
                          <h6>{I18n.t("helps.formula.formula-title")}</h6>
                          <p dangerouslySetInnerHTML={{__html: I18n.t("helps.formula.formula-content")}}/>

                          <h6>{I18n.t("helps.formula.reference-title")}</h6>
                          <p dangerouslySetInnerHTML={{__html: I18n.t("helps.formula.reference-content")}}/>

                          <h6>{I18n.t("helps.formula.date-title")}</h6>
                          <p dangerouslySetInnerHTML={{__html: I18n.t("helps.formula.date-content")}}/>
                        </Popover.Content>
                      </Popover>
                    </Overlay>
                  </>
                  : null}

                {NUMERIC_ANSWER_TYPES.includes(values.answer_type_id) ?
                  <>
                    <Form.Group controlId="validationMinValueWarning">
                      <Form.Label>{I18n.t("activerecord.attributes.question.min_value_warning")}</Form.Label>
                      <Form.Control
                        type="number"
                        name="min_value_warning"
                        disabled={deployedMode}
                        value={values.min_value_warning}
                        onChange={handleChange}
                        isInvalid={touched.min_value_warning && !!errors.min_value_warning}
                      />
                      <Form.Control.Feedback type="invalid">
                        {errors.min_value_warning}
                      </Form.Control.Feedback>
                    </Form.Group>

                    <Form.Group controlId="validationMaxValueWarning">
                      <Form.Label>{I18n.t("activerecord.attributes.question.max_value_warning")}</Form.Label>
                      <Form.Control
                        type="number"
                        name="max_value_warning"
                        disabled={deployedMode}
                        value={values.max_value_warning}
                        onChange={handleChange}
                        isInvalid={touched.max_value_warning && !!errors.max_value_warning}
                      />
                      <Form.Control.Feedback type="invalid">
                        {errors.max_value_warning}
                      </Form.Control.Feedback>
                    </Form.Group>

                    <Form.Group controlId="validationMinValueError">
                      <Form.Label>{I18n.t("activerecord.attributes.question.min_value_error")}</Form.Label>
                      <Form.Control
                        type="number"
                        name="min_value_error"
                        disabled={deployedMode}
                        value={values.min_value_error}
                        onChange={handleChange}
                        isInvalid={touched.min_value_error && !!errors.min_value_error}
                      />
                      <Form.Control.Feedback type="invalid">
                        {errors.min_value_error}
                      </Form.Control.Feedback>
                    </Form.Group>

                    <Form.Group controlId="validationMaxValueError">
                      <Form.Label>{I18n.t("activerecord.attributes.question.max_value_error")}</Form.Label>
                      <Form.Control
                        type="number"
                        name="max_value_error"
                        disabled={deployedMode}
                        value={values.max_value_error}
                        onChange={handleChange}
                        isInvalid={touched.max_value_error && !!errors.max_value_error}
                      />
                      <Form.Control.Feedback type="invalid">
                        {errors.max_value_error}
                      </Form.Control.Feedback>
                    </Form.Group>

                    <Form.Group controlId="validationMinMessageWarning">
                      <Form.Label>{I18n.t("activerecord.attributes.question.min_message_warning")}</Form.Label>
                      <Form.Control
                        as="textarea"
                        name="min_message_warning"
                        disabled={deployedMode}
                        value={values.min_message_warning}
                        onChange={handleChange}
                        isInvalid={touched.min_message_warning && !!errors.min_message_warning}
                      />
                      <Form.Control.Feedback type="invalid">
                        {errors.min_message_warning}
                      </Form.Control.Feedback>
                    </Form.Group>

                    <Form.Group controlId="validationMaxMessageError">
                      <Form.Label>{I18n.t("activerecord.attributes.question.max_message_warning")}</Form.Label>
                      <Form.Control
                        as="textarea"
                        name="max_message_warning"
                        disabled={deployedMode}
                        value={values.max_message_warning}
                        onChange={handleChange}
                        isInvalid={touched.max_message_warning && !!errors.max_message_warning}
                      />
                      <Form.Control.Feedback type="invalid">
                        {errors.max_message_warning}
                      </Form.Control.Feedback>
                    </Form.Group>

                    <Form.Group controlId="validationMinMessageError">
                      <Form.Label>{I18n.t("activerecord.attributes.question.min_message_error")}</Form.Label>
                      <Form.Control
                        as="textarea"
                        name="min_message_error"
                        disabled={deployedMode}
                        value={values.min_message_error}
                        onChange={handleChange}
                        isInvalid={touched.min_message_error && !!errors.min_message_error}
                      />
                      <Form.Control.Feedback type="invalid">
                        {errors.min_message_error}
                      </Form.Control.Feedback>
                    </Form.Group>

                    <Form.Group controlId="validationMaxMessageError">
                      <Form.Label>{I18n.t("activerecord.attributes.question.max_message_error")}</Form.Label>
                      <Form.Control
                        as="textarea"
                        name="max_message_error"
                        disabled={deployedMode}
                        value={values.max_message_error}
                        onChange={handleChange}
                        isInvalid={touched.max_message_error && !!errors.max_message_error}
                      />
                      <Form.Control.Feedback type="invalid">
                        {errors.max_message_error}
                      </Form.Control.Feedback>
                    </Form.Group>
                  </>
                : null}

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

                <Form.Group>
                  <MediaForm values={values} setFieldValue={setFieldValue} setDeletedMedia={this.setDeletedMedia}/>
                </Form.Group>

                <Button className="float-right" type="submit" disabled={isSubmitting}>
                  {I18n.t("next")}
                </Button>
              </Form>);
            }}
          </Formik>
        </FadeIn>
    );
  }
}
