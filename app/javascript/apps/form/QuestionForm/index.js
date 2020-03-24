import * as React from "react";
import I18n from "i18n-js";
import {Form, Button} from "react-bootstrap";
import {Formik} from "formik";

import DisplayErrors from "../DisplayErrors";
import Http from "../../diagram/engine/http";
import store from "../../diagram/engine/reducers/store";
import {questionSchema} from "../schema";
import {closeModal} from "../../diagram/engine/reducers/creators.actions";
import {createNode} from "../../diagram/helpers/nodeHelpers";

export default class FinalDiagnosticForm extends React.Component {
  constructor() {
    super();

    this.state = {
      lists: {},
      snomedResults: [],
      isLoading: true
    };

    this.initForm();
  }

  initForm = async () => {
    let http = new Http();
    let httpRequest = {};

    httpRequest = await http.fetchQuestionsLists();
    let result = await httpRequest.json();

    console.log(result)
    console.log(httpRequest.status);

    if (httpRequest.status === 200) {
      this.setState({
        lists: result,
        isLoading: false
      });
    }
  };

  handleOnSubmit = async (values, actions) => {
    const {method, from, engine, diagramObject, addAvailableNode} = this.props;
    let http = new Http();
    let httpRequest = {};

    if (method === "create") {
      httpRequest = await http.createQuestion(values.label_translations, values.description_translations, from);
    } else {
      httpRequest = await http.updateQuestion(values.id, values.label_translations, values.description_translations, from);
    }

    let result = await httpRequest.json();

    if (httpRequest.status === 200) {
      if (from === 'rails') {
        window.location.replace(result.url);
      } else {
        if (method === "create") {
          let diagramInstance = createNode(result, addAvailableNode, false, "Diagnostic", engine);
          engine.getModel().addNode(diagramInstance);
        } else {
          diagramObject.options.dbInstance.node = result;
        }

        engine.repaintCanvas();

        store.dispatch(
          closeModal()
        );
      }
    } else {
      actions.setStatus({result});
    }
  };

  /**
   * Search in snomed api to get results
   *
   * @param {Object} event
   */
  searchSnomed = async (event) => {
    const { http } = this.props;

    let response = await http.searchSnomed(event.target.value);
    this.setState({ snomedResults: response.items });
  };

  /**
   * Save id and value of snomed selected
   *
   * @param {Object} event
   */
  snomedChange = async (event, value) => {
    this.setState({
      snomedId: value.id,
      snomedLabel: value.fsn.term
    });
  };

  render() {
    const {question} = this.props;
    const {lists, snomedResults} = this.state;

    console.log(lists);
    // console.log(answer_types);
    // console.log(categories);
    // console.log(stages);
    // console.log(systems);

    return (
      <Formik
        validationSchema={questionSchema}
        initialValues={{
          id: question?.id || "",
          type: question?.type || "",
          system: question?.system || "",
          answer_type: question?.answer_type || "",
          stage: question?.stage || "",
          is_mandatory: question?.is_mandatory || "",
          label_translations: question?.label_translations?.en || "",
          snomed: question?.snomed_label || "",
          description_translations: question?.description_translations?.en || "",
          unavailable: question?.unavailable || "",
          formula: question?.formula || ""
        }}
        onSubmit={(values, actions) => this.handleOnSubmit(values, actions)}
      >
        {({
            handleSubmit,
            handleChange,
            isSubmitting,
            values,
            errors,
            status
          }) => (
          <Form noValidate onSubmit={handleSubmit}>
            {status ? <DisplayErrors errors={status}/> : null}

            <Form.Row>
              <Form.Group controlId="validationCategory">
                <Form.Label>{I18n.t("activerecord.attributes.node.type")}</Form.Label>
                <Form.Control
                  as="select"
                  name="type"
                  value={values.type}
                  onChange={handleChange}
                  isInvalid={!!errors.type}
                >
                  <option value="">Select the category</option>
                  {categories.map((category) => (
                    <option value={category.name}>{category.label}</option>
                  ))}
                </Form.Control>
                <Form.Control.Feedback type="invalid">
                  {errors.type}
                </Form.Control.Feedback>
              </Form.Group>
            </Form.Row>

            {CATEGORIES_DISPLAYING_SYSTEM.includes(value.type) ?
              <Form.Row>
                <Form.Group controlId="validationSystem">
                  <Form.Label>{I18n.t("activerecord.attributes.question.system")}</Form.Label>
                  <Form.Control
                    as="select"
                    name="system"
                    value={values.system}
                    onChange={handleChange}
                    isInvalid={!!errors.system}
                  >
                    <option value="">Select the system</option>
                    {systems.map((system) => (
                      <option value={system[1]}>{system[0]}</option>
                    ))}
                  </Form.Control>
                  <Form.Control.Feedback type="invalid">
                    {errors.system}
                  </Form.Control.Feedback>
                </Form.Group>
              </Form.Row>
              : null}

            <Form.Row>
              <Form.Group controlId="validationAnswerType">
                <Form.Label>{I18n.t("activerecord.attributes.question.answer_type")}</Form.Label>
                <Form.Control
                  as="select"
                  name="answerType"
                  value={values.answer_type}
                  onChange={handleChange}
                  disabled={CATEGORIES_DISABLING_ANSWER_TYPE.includes(values.type)}
                  isInvalid={!!errors.answer_type}
                >
                  <option value="">Select the type of answers expected</option>
                  {answer_types.map((answerType) => (
                    <option value={answerType.id}>{answerType.display_name}</option>
                  ))}
                </Form.Control>
                <Form.Control.Feedback type="invalid">
                  {errors.answer_type}
                </Form.Control.Feedback>
              </Form.Group>
            </Form.Row>

            {values.type === "Questions::BackgroundCalculation" ?
              <Form.Row>
                <Form.Group controlId="validationStage">
                  <Form.Label>{I18n.t("activerecord.attributes.question.stage")}</Form.Label>
                  <Form.Control
                    as="select"
                    name="stage"
                    value={values.stage}
                    onChange={handleChange}
                    disabled={values.type !== ""}
                    isInvalid={!!errors.stage}
                  >
                    <option value="">Select the stage</option>
                    {Object.keys(stages).map(function (key) {
                      return <option value={stages[key]}>{key.charAt(0).toUpperCase() + key.slice(1)}</option>;
                    })}
                  </Form.Control>
                  <Form.Control.Feedback type="invalid">
                    {errors.stage}
                  </Form.Control.Feedback>
                </Form.Group>
              </Form.Row>
              : null}

            <Form.Row>
              <Form.Group controlId="validationIsMandatory">
                <Form.Label>{I18n.t("activerecord.attributes.question.is_mandatory")}</Form.Label>
                <Form.Control
                  type="checkbox"
                  name="is_mandatory"
                  value={values.is_mandatory}
                  onChange={handleChange}
                  isInvalid={!!errors.is_mandatory}
                />
                <Form.Control.Feedback type="invalid">
                  {errors.is_mandatory}
                </Form.Control.Feedback>
              </Form.Group>
            </Form.Row>

            <Form.Row>
              <Form.Group controlId="validationLabel">
                <Form.Label>{I18n.t("activerecord.attributes.node.label_translations")}</Form.Label>
                <Form.Control
                  name="label_translations"
                  value={values.label_translations}
                  onChange={handleChange}
                  isInvalid={!!errors.label_translations}
                />
                <Form.Control.Feedback type="invalid">
                  {errors.label_translations}
                </Form.Control.Feedback>
              </Form.Group>
            </Form.Row>

            <Form.Row>
              <Form.Group controlId="validationLabel">
                <Form.Label>{I18n.t("activerecord.attributes.question.snomed")}</Form.Label>
                <InputGroup>
                  <Autocomplete
                    options={snomedResults}
                    getOptionLabel={option => option.fsn.term}
                    autoComplete
                    includeInputInList
                    freeSolo
                    disableOpenOnFocus
                    onChange={this.snomedChange}
                    renderInput={params => (
                      <TextField {...params} label="Search a snomed label" variant="outlined"
                                 onChange={this.searchSnomed} fullWidth/>
                    )}
                  />
                </InputGroup>
              </Form.Group>
            </Form.Row>

            <Form.Row>
              <Form.Group controlId="validationDescription">
                <Form.Label>{I18n.t("activerecord.attributes.node.description_translations")}</Form.Label>
                <Form.Control
                  name="description_translations"
                  as="textarea"
                  value={values.description_translations}
                  onChange={handleChange}
                  isInvalid={!!errors.description_translations}
                />
                <Form.Control.Feedback type="invalid">
                  {errors.description_translations}
                </Form.Control.Feedback>
              </Form.Group>
            </Form.Row>

            {values.type === "Questions::AssessmentTest" ?
              <Form.Row>
                <Form.Group controlId="validationDescription">
                  <Form.Label>{I18n.t("activerecord.attributes.question.unavailable")}</Form.Label>
                  <Form.Control
                    name="unavailable"
                    as="textarea"
                    value={values.unavailable}
                    onChange={handleChange}
                    isInvalid={!!errors.unavailable}
                  />
                  <Form.Control.Feedback type="invalid">
                    {errors.unavailable}
                  </Form.Control.Feedback>
                </Form.Group>
              </Form.Row>
            : null}

            {values.answer_type === "5" ?
              <Form.Row>
                <Form.Group controlId="validationFormula">
                  <Form.Label>{I18n.t("activerecord.attributes.question.formula")}</Form.Label>
                  <Form.Control
                    name="formula"
                    as="textarea"
                    value={values.formula}
                    onChange={handleChange}
                    isInvalid={!!errors.formula}
                  />
                  <Form.Control.Feedback type="invalid">
                    {errors.formula}
                  </Form.Control.Feedback>
                </Form.Group>
              </Form.Row>
              : null}

            <Button type="submit" disabled={isSubmitting}>
              {I18n.t("save")}
            </Button>
          </Form>
        )}
      </Formik>
    );
  }
}
