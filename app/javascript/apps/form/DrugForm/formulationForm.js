import * as React from "react";
import I18n from "i18n-js";
import FadeIn from "react-fade-in";
import { Form, Button, Card, Col } from "react-bootstrap";
import { FieldArray, Formik } from "formik";

import FormulationFields from "./formulationFields";
import Http from "../../diagram/engine/http";
import Loader from "../components/Loader";
import { DEFAULT_FORMULATION_VALUE } from "../constants/constants";
import { formulationSchema } from "../constants/schema";
import { createNode } from "../../diagram/helpers/nodeHelpers";
import store from "../../diagram/engine/reducers/store";
import { closeModal } from "../../diagram/engine/reducers/creators.actions";


export default class FormulationForm extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      breakables: [],
      administrationRoutes: [],
      medicationForms: [],
      formulations: [],
      formulationComponentAttributes: [],
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

  handleOnSubmit = async (values, actions) => {
    await actions.validateForm();
    console.log(values)
  };

  // Build the drug formulations hashes, empty if this is a create form or with its answers if it is an update
  buildFormulations = () => {
    const {
      formData
    } = this.props;

    let {
      availableMedicationForms
    } = this.state;
    let formulations = {};
    let formulationComponents = {};
    let drugFormulations = formData.formulations;

    // build formulations
    drugFormulations.map((formulation, index) => {
      availableMedicationForms.splice(availableMedicationForms.indexOf(formulation.medication_form), 1);

      formulations[index] = {
        id: formulation.id,
        administration_route_id: parseInt(formulation.administration_route_id),
        minimal_dose_per_kg: parseInt(formulation.minimal_dose_per_kg),
        maximal_dose_per_kg: parseInt(formulation.maximal_dose_per_kg),
        maximal_dose: parseInt(formulation.maximal_dose),
        medication_form: formulation.medication_form,
        dose_form: parseInt(formulation.dose_form),
        liquid_concentration: parseInt(formulation.liquid_concentration),
        doses_per_day: parseInt(formulation.doses_per_day),
        unique_dose: parseInt(formulation.unique_dose),
        breakable: formulation.breakable,
        by_age: formulation.by_age,
        _destroy: false
      };
    });

    for (let i = 0; i < drugFormulations.length; i++) {
      formulationComponents[i] = <CreateFormulationForm medicationForm={formulations[i].medication_form}
                                                        setActiveAccordion={this.setActiveAccordion}
                                                        setFormulation={this.setFormulation}
                                                        removeFormulation={this.removeFormulation}
                                                        formulations={formulations}
                                                        index={i}
                                                        update={true}/>;
    }

    this.setState({
      formulations,
      formulationComponents
    });
  };

  handleMedicationFormChange = (event) => {
    this.setState({ selectedMedicationForm: event.target.value });
  };

  addFormulation = () => {
    const { setFormData, formData } = this.props;
    const {
      selectedMedicationForm,
      medicationForms
    } = this.state;

    let newMedicationFroms = [...medicationForms];
    let index = newMedicationFroms.indexOf(selectedMedicationForm);

    formData.formulations.push({
      medication_form: selectedMedicationForm,
      administration_route_id: "",
      minimal_dose_per_kg: "",
      maximal_dose_per_kg: "",
      maximal_dose: "",
      doses_per_day: "",
      dose_form: "",
      breakable: "",
      unique_dose: "",
      liquid_concentration: "",
      by_age: ""
    });

    newMedicationFroms.splice(index, 1);

    setFormData("formulations", formData.formulations);
    this.setState({
      medicationForms: newMedicationFroms,
      selectedMedicationForm: ""
    });
  };

  removeFormulation(key) {
    const { formData, setFormData } = this.props;
    const { medicationForms } = this.state;

    let selectedMedicationForm = formData.formulations[key].medication_form;
    let newMedicationFroms = [...medicationForms];

    newMedicationFroms.push(selectedMedicationForm);
    this.setState({ medicationForms: newMedicationFroms });

    formData.formulations.splice(key, 1);
    setFormData("formulations", formData.formulations);
  }

  save() {

  }

  render() {
    const { formData, nextStep, setFormData } = this.props;
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
            initialValues={formData.formulations}
            onSubmit={(values, actions) => this.handleOnSubmit(values, actions)}
          >
            {({
                handleSubmit,
                handleChange,
                isSubmitting,
                values,
                touched,
                errors,
                status
              }) => (
              <Form noValidate onSubmit={handleSubmit}>
                <div id="accordion">
                  {values.map((formulation, key) => (
                    <Form.Row key={key}>
                      <Col lg="10">
                        <Card key={key}>
                          <div className="card-header" id={`heading-${key}`}>
                            <h5 className="mb-0">
                              <button
                                className="btn btn-link"
                                data-toggle="collapse"
                                data-target={`#collapse-${key}`}
                                aria-expanded={key === values - 1}
                                aria-controls={`collapse-${key}`}
                              >
                                {formulation.medication_form}
                              </button>
                            </h5>
                          </div>
                          <div
                            id={`collapse-${key}`}
                            className={`collapse ${key === values.length - 1 ? "show" : null}`}
                            aria-labelledby={`heading-${key}`}
                            data-parent="#accordion">
                            <div className="card-body">
                              <FieldArray
                                name="formulations"
                                render={arrayHelpers => (
                                <FormulationFields
                                  breakables={breakables}
                                  administrationRoutes={administrationRoutes}
                                  handleChange={handleChange}
                                  touched={touched}
                                  errors={errors}
                                  values={values}
                                  index={key}
                                  arrayHelpers={arrayHelpers}
                                />
                                )}
                              />
                            </div>
                          </div>
                        </Card>
                      </Col>
                      <Col>
                        <Button type="button" variant="danger" onClick={() => this.removeFormulation(key)}>{I18n.t("remove")}</Button>
                      </Col>
                    </Form.Row>
                  ))}
                </div>

                {formData.formulations.length > 0 ? <hr/> : null}

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
                          value={medicationForm}>{medicationForm}</option>
                      ))}
                    </Form.Control>
                  </Col>

                  <Col>
                    <Button type="button" variant="primary" onClick={() => this.addFormulation()}
                            disabled={selectedMedicationForm === ""}>
                      {I18n.t("add")}
                    </Button>
                  </Col>
                </Form.Row>

                <Button type="submit" variant="success" disabled={isSubmitting}>
                  {I18n.t("save")}
                </Button>
              </Form>
            )}
          </Formik>
        </FadeIn>
    );
  }
}
