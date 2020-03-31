import * as React from "react";
import I18n from "i18n-js";
import { Form, Button } from "react-bootstrap";
import FadeIn from "react-fade-in";
import InputGroup from "react-bootstrap/InputGroup";
import Autocomplete from "@material-ui/lab/Autocomplete";
import TextField from "@material-ui/core/TextField";
import { Formik } from "formik";

import DisplayErrors from "../components/DisplayErrors";
import Http from "../../diagram/engine/http";
import store from "../../diagram/engine/reducers/store";
import { questionSchema } from "../constants/schema";
import { closeModal } from "../../diagram/engine/reducers/creators.actions";
import { createNode } from "../../diagram/helpers/nodeHelpers";
import Loader from "../QuestionsSequenceForm";
import { CATEGORIES_DISPLAYING_SYSTEM, CATEGORIES_DISABLING_ANSWER_TYPE } from "../../diagram/engine/constants/default";

const humanizeString = require("humanize-string");

export default class FinalDiagnosticForm extends React.Component {
  constructor() {
    super();

    this.state = {
      snomedResults: [],
      snomedError: null,
      isLoading: true,
      isFetchingSnomed: false
    };

    this.init();
  }

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
        isLoading: false
      });
    }
  };

  /**
   * Search in snomed api to get results
   * @param {Object} event
   */
  searchSnomed = async (event) => {
    const http = new Http();
    this.setState({ isFetchingSnomed: true });
    let httpRequest = {};

    httpRequest = await http.searchSnomed(event.target.value);
    if (httpRequest?.status === 200) {
      let result = await httpRequest.json();

      this.setState({
        snomedResults: result.items,
        snomedError: null,
        isFetchingSnomed: false
      });
    } else {
      this.setState({ snomedError: { message: I18n.t("questions.errors.snomed_fetch_failed") } });
    }
  };

  /**
   * Save id and value of snomed selected
   * @param {Object} event
   */
  snomedChange = async (event, value) => {
    this.setState({
      snomedId: value.id,
      snomedLabel: value.fsn.term
    });
  };

  // Set value of answer type and stage depending on what category was chosen
  categoryChanges = (event) => {
    let fieldsToSet = [];
    const category = event.target.value;

    // Set stage
    switch (category) {
      case "Questions::ConsultationRelated":
      case "Questions::Demographic":
        fieldsToSet.push(["stage", "0"]);
        break;
      case "Questions::BasicMeasurement":
      case "Questions::ComplaintCategory":
      case "Questions::UniqueTriagePhysicalSign":
      case "Questions::UniqueTriageQuestion":
        fieldsToSet.push(["stage", "1"]);
        break;
      case "Questions::AssessmentTest":
        fieldsToSet.push(["stage", "2"]);
        break;
      case "Questions::ChronicCondition":
      case "Questions::Exposure":
      case "Questions::ObservedPhysicalSign":
      case "Questions::PhysicalExam":
      case "Questions::Symptom":
      case "Questions::Vaccine":
      case "Questions::VitalSignAnthropometric":
        fieldsToSet.push(["stage", "3"]);
        break;
      case "Questions::TreatmentQuestion":
        fieldsToSet.push(["stage", "4"]);
        break;
      default:
        fieldsToSet.push(["stage", ""]);
    }

    // Set answer type
    if (["Questions::ComplaintCategory", "Questions::Vaccine"].includes(category)) {
      fieldsToSet.push(["answer_type", "1"]);
    } else if (["Questions::BasicMeasurement", "Questions::VitalSignAnthropometric"].includes(category)) {
      fieldsToSet.push(["answer_type", "4"]);
    } else if (category === "Questions::BackgroundCalculation") {
      fieldsToSet.push(["answer_type", "5"]);
    }
    return fieldsToSet;
  };

  render() {
    const { formData, setFormData, nextStep } = this.props;

    const {
      answerTypes,
      categories,
      stages,
      systems,
      snomedResults,
      isLoading,
      snomedError,
      isFetchingSnomed
    } = this.state;

    return (
      isLoading ? <Loader/> :
        <FadeIn>
          <Formik
            validationSchema={questionSchema}
            initialValues={formData}
            onSubmit={values => {
              setFormData(values);
              nextStep();
            }}
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
                    isInvalid={touched.category && !!errors.category}
                  >
                    <option value="">{I18n.t("select")}</option>
                    {categories.map(category => (
                      <option value={category.name}>{category.label}</option>
                    ))}
                  </Form.Control>
                  <Form.Control.Feedback type="invalid">
                    {errors.category}
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
                        <option value={system[1]}>{system[0]}</option>
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
                    name="answer_type"
                    value={values.answer_type}
                    onChange={handleChange}
                    disabled={CATEGORIES_DISABLING_ANSWER_TYPE.includes(values.type)}
                    isInvalid={touched.answer_type && !!errors.answer_type}
                  >
                    <option value="">{I18n.t("select")}</option>
                    {answerTypes.map(answerType => (
                      <option value={answerType.id}>{answerType.display_name}</option>
                    ))}
                  </Form.Control>
                  <Form.Control.Feedback type="invalid">
                    {errors.answer_type}
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
                        <option value={stages[key]}>{humanizeString(key)}</option>
                      ))}
                    </Form.Control>
                    <Form.Control.Feedback type="invalid">
                      {errors.stage}
                    </Form.Control.Feedback>
                  </Form.Group>
                  : null}

                <Form.Group controlId="validationIsMandatory">
                  <Form.Label>{I18n.t("activerecord.attributes.question.is_mandatory")}</Form.Label>
                  <Form.Check
                    type="checkbox"
                    name="is_mandatory"
                    value={values.is_mandatory}
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
                    name="label_translations"
                    value={values.label_translations}
                    onChange={handleChange}
                    isInvalid={touched.label_translations && !!errors.label_translations}
                  />
                  <Form.Control.Feedback type="invalid">
                    {errors.label_translations}
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

                <Form.Group controlId="validationDescription">
                  <Form.Label>{I18n.t("activerecord.attributes.node.description_translations")}</Form.Label>
                  <Form.Control
                    name="description_translations"
                    as="textarea"
                    value={values.description_translations}
                    onChange={handleChange}
                    isInvalid={touched.description_translations && !!errors.description_translations}
                  />
                  <Form.Control.Feedback type="invalid">
                    {errors.description_translations}
                  </Form.Control.Feedback>
                </Form.Group>

                {values.type === "Questions::AssessmentTest" ?
                  <Form.Group controlId="validationUnavailable">
                    <Form.Label>{I18n.t("activerecord.attributes.question.unavailable")}</Form.Label>
                    <Form.Control
                      name="unavailable"
                      as="checkbox"
                      value={values.unavailable}
                      onChange={handleChange}
                      isInvalid={touched.unavailable && !!errors.unavailable}
                    />
                    <Form.Control.Feedback type="invalid">
                      {errors.unavailable}
                    </Form.Control.Feedback>
                  </Form.Group>
                  : null}

                {values.answer_type === "5" ?
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

                <Button type="submit" disabled={isSubmitting}>
                  {I18n.t("save")}
                </Button>
              </Form>
            )}
          </Formik>
        </FadeIn>
    );
  }
};
