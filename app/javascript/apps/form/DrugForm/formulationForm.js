import * as React from "react";
import I18n from "i18n-js";
import FadeIn from "react-fade-in";
import {Form, Button, Accordion} from "react-bootstrap";
import FormulationFields from "./formulationFields"

import Http from "../../diagram/engine/http";
import Loader from "../Loader";

export default class FormulationForm extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      errors: {},
      formulations: {0: {}},
      formulationComponentAttributes: {},
      availableMedicationForms: [],
      selectedForms: [],
      medicationForm: null,
      medicationFormError: null,
      isLoading: true,
      accordionIndex: 0,
    };
    this.init();
  }

  init = async () => {
    const {method} = this.props
    let http = new Http();
    let httpRequest = {};

    httpRequest = await http.fetchDrugMedicationForms();
    let result = await httpRequest.json();

    if (httpRequest.status === 200) {
      this.setState({
        availableMedicationForms: result,
        isLoading: false
      });
    }

    if (method === "update") {
      this.buildFormulations();
    }
  };


  // Build the drug formulations hashes, empty if this is a create form or with its answers if it is an update
  buildFormulations = () => {
    const {
      formData,
      medicationForms
    } = this.props;

    let {
      availableMedicationForms,
      selectedForms
    } = this.state;
    let formulations = {};
    let formulationComponents = {};
    let drugFormulations = formData.formulations;

    // build formulations
    drugFormulations.map((formulation, index) => {
      availableMedicationForms.splice( availableMedicationForms.indexOf(formulation.medication_form), 1 );
      selectedForms.push(formulation.medication_form);

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
      }
    });

    for (let i = 0; i < drugFormulations.length; i++) {
      formulationComponents[i] = <CreateFormulationForm medicationForm={formulations[i].medication_form} setActiveAccordion={this.setActiveAccordion} setFormulation={this.setFormulation} removeFormulation={this.removeFormulation} formulations={formulations} index={i} errors={{}} update={true} />
    }

    this.setState({
      formulations,
      formulationComponents
    });
  };


  setActiveAccordion = (index) => {
    this.setState({accordionIndex: index});
  };

  handleMedicationFormChange = (event) => {
    this.setState({ medicationForm: event.target.value });
  };

  newFormulation = () => {
    let {
      formulationComponentAttributes,
      formulations,
      medicationForm,
      availableMedicationForms,
      selectedForms
    } = this.state;

    if (medicationForm === null) {
      this.setState({ medicationFormError: I18n.t('drugs.medication_forms.required') });
    } else {
      let lastIndex = parseInt(Object.keys(formulations)[Object.keys(formulations).length-1]) + 1;
      formulations[lastIndex] = {medication_form: medicationForm};
      formulationComponentAttributes[lastIndex] = {formulations, index:lastIndex} ;

      delete availableMedicationForms[medicationForm];
      // TODO Check if necessary, remove if not
      selectedForms.push(medicationForm);

      this.setState({
        availableMedicationForms: availableMedicationForms,
        selectedForms: selectedForms,
        accordionIndex: lastIndex,
        formulationComponentAttributes,
        formulations,
        medicationForm: "",
        medicationFormError: ""
      });
    }
  }

  save() {

  }

  labelMedicationForm(medicationForm) {
    return medicationForm.charAt(0).toUpperCase() + medicationForm.slice(1)
  }


  render() {
    const {formData, setFormData, nextStep} = this.props;
    const {
      availableMedicationForms,
      medicationFormError,
      accordionIndex,
      formulationComponentAttributes,
      isLoading
    } = this.state;

    return (
      isLoading ? <Loader/> :
        <FadeIn>
          <Accordion activeKey={accordionIndex} defaultActiveKey={Object.keys(formulationComponentAttributes).length - 1}>
            {Object.keys(formulationComponentAttributes).map((key) => {
              <FormulationFields
                setActiveAccordion={this.setActiveAccordion}
                setFormulation={this.setFormulation}
                removeFormulation={this.removeFormulation}
                formulations={formulationComponentAttributes[key].formulations}
                index={formulationComponentAttributes[key].index}
                errors={{}} />;
            })}
          </Accordion>

          <Form.Row>
            <Form.Group controlId="validationMedicationForm">
              <Form.Control
                as="select"
                name="medicationForm"
                onChange={this.handleMedicationFormChange}
                isInvalid={!!medicationFormError}
              >
                <option value="">{I18n.t('drugs.medication_forms.select')}</option>
                {Object.keys(availableMedicationForms).map(medicationForm => (
                  <option key={medicationForm}
                          value={medicationForm}>{this.labelMedicationForm(medicationForm)}</option>
                ))}

              </Form.Control>
              <Form.Control.Feedback type="invalid">
                {medicationFormError}
              </Form.Control.Feedback>
            </Form.Group>

            <Button variant="primary" onClick={() => this.newFormulation()}>
              New formulation
            </Button>

            <Button variant="success" onClick={() => this.save()}>
              Validate
            </Button>
          </Form.Row>

        </FadeIn>
    );
  }
}
