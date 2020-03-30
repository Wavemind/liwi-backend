import * as React from "react";
import I18n from "i18n-js";
import FadeIn from "react-fade-in";
import { Form, Button, Card, Col, Badge } from "react-bootstrap";
import { FieldArray, Formik } from "formik";

import FormulationFields from "./formulationFields";
import Http from "../../diagram/engine/http";
import Loader from "../components/Loader";

import { DEFAULT_FORMULATION_VALUE } from "../constants/constants";
import { formulationSchema } from "../constants/schema";

const humanizeString = require("humanize-string");

export default class FormulationForm extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      breakables: [],
      administrationRoutes: [],
      medicationForms: [],
      selectedMedicationForm: "",
      isLoading: true
    };

    this.init();
  }

  init = async () => {
    const { method } = this.props;
    let http = new Http();
    let httpRequest = {};

    httpRequest = await http.fetchDrugMedicationForms();
    let result = await httpRequest.json();

    if (httpRequest.status === 200) {
      this.setState({
        breakables: result.breakables,
        administrationRoutes: result.administration_routes,
        medicationForms: result.medication_forms,
        isLoading: false
      });
    }

    if (method === "update") {
      this.buildFormulations();
    }
  };

  handleOnSubmit = async (values) => {
    const { setFormData, save } = this.props;
    await setFormData('formulations_attributes', values.formulations_attributes);
    save();
  };

  handleMedicationFormChange = (event) => {
    this.setState({ selectedMedicationForm: event.target.value });
  };

  addFormulation = (arrayHelpers) => {
    const {
      selectedMedicationForm,
      medicationForms
    } = this.state;

    arrayHelpers.push({
        medication_form: selectedMedicationForm,
        ...JSON.parse(DEFAULT_FORMULATION_VALUE)
      }
    );

    let newMedicationFroms = [...medicationForms];
    let index = newMedicationFroms.indexOf(selectedMedicationForm);

    newMedicationFroms.splice(index, 1);

    this.setState({
      medicationForms: newMedicationFroms,
      selectedMedicationForm: ""
    });
  };

  removeFormulation(key, arrayHelpers) {
    const { medicationForms } = this.state;
    let selectedMedicationForm = arrayHelpers.form.values.formulations_attributes[key].medication_form;
    let newMedicationFroms = [...medicationForms];

    arrayHelpers.remove(key);

    newMedicationFroms.push(selectedMedicationForm);
    this.setState({ medicationForms: newMedicationFroms });
  }

  displayLabel = (name, errors, key) => {
    return (
      <>
        {humanizeString(name)} <Badge variant="danger">
        {errors?.formulations_attributes !== undefined && errors?.formulations_attributes[key] !== undefined && Object.keys(errors?.formulations_attributes[key]).length}
      </Badge>
      </>
    );
  };

  render() {
    const { formData, previousStep } = this.props;
    const {
      selectedMedicationForm,
      medicationForms,
      isLoading,
      breakables,
      administrationRoutes
    } = this.state;

    return (
      isLoading ? <Loader/> :
        <FadeIn>
          <Formik
            validationSchema={formulationSchema}
            initialValues={formData}
            validateOnChange={false}
            onSubmit={(values, actions) => this.handleOnSubmit(values, actions)}
          >
            {({
                handleSubmit,
                isSubmitting,
                values
              }) => (
              <Form noValidate onSubmit={handleSubmit}>
                <FieldArray
                  name="formulations_attributes"
                  render={arrayHelpers => (
                    <>
                      <div id="accordion">
                        {values.formulations_attributes.map((formulation, key) => (
                          <Form.Row key={key}>
                            <Col lg="10">
                              <Card key={`card-${key}`}>
                                <div className="card-header px-0 py-0" id={`heading-${key}`}>
                                  <h5 className="mb-0">
                                    <button
                                      type="button"
                                      className="btn btn-block px-2 py-3"
                                      data-toggle="collapse"
                                      data-target={`#collapse-${key}`}
                                      aria-expanded={key === values.formulations_attributes - 1}
                                      aria-controls={`collapse-${key}`}
                                    >
                                      {this.displayLabel(formulation.medication_form, arrayHelpers.form.errors, key)}
                                    </button>
                                  </h5>
                                </div>
                                <div
                                  id={`collapse-${key}`}
                                  className={`collapse ${key === values.formulations_attributes.length - 1 ? "show" : null}`}
                                  aria-labelledby={`heading-${key}`}
                                  data-parent="#accordion">
                                  <div className="card-body">
                                    <FormulationFields
                                      breakables={breakables}
                                      administrationRoutes={administrationRoutes}
                                      arrayHelpers={arrayHelpers}
                                      index={key}
                                    />
                                  </div>
                                </div>
                              </Card>
                            </Col>
                            <Col>
                              <Button
                                className="float-right"
                                type="button"
                                variant="danger"
                                onClick={() => this.removeFormulation(key, arrayHelpers)}>{I18n.t("remove")}</Button>
                            </Col>
                          </Form.Row>
                        ))}
                      </div>

                      {values.formulations_attributes.length > 0 ? <hr/> : null}

                      <Form.Row>
                        <Col lg="11">
                          <Form.Control
                            as="select"
                            name="medicationForm"
                            onChange={this.handleMedicationFormChange}
                          >
                            <option value="">{I18n.t("drugs.medication_forms.select")}</option>
                            {medicationForms.map(medicationForm => (
                              <option
                                key={medicationForm}
                                value={medicationForm}>{humanizeString(medicationForm)}</option>
                            ))}
                          </Form.Control>
                        </Col>

                        <Col>
                          <Button
                            className="float-right"
                            type="button"
                            variant="primary"
                            onClick={() => this.addFormulation(arrayHelpers)}
                            disabled={selectedMedicationForm === ""}
                          >
                            {I18n.t("add")}
                          </Button>
                        </Col>
                      </Form.Row>

                      <Form.Row className="mt-5">
                        <Col>
                          <Button type="button" variant="default" onClick={() => previousStep()}>
                            {I18n.t("back")}
                          </Button>
                        </Col>
                        <Col>
                          <Button className="float-right" type="submit" variant="success" disabled={isSubmitting}>
                            {I18n.t("save")}
                          </Button>
                        </Col>
                      </Form.Row>
                    </>
                  )}
                />
              </Form>
            )}
          </Formik>
        </FadeIn>
    );
  }
}
