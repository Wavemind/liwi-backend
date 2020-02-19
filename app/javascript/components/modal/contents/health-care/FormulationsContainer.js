import React from "react";
import {
  Button,
  Modal,
  Form,
  InputGroup,
  Col,
  Accordion,
} from "react-bootstrap";

import { withDiagram } from "../../../../context/Diagram.context";
import NodeListItem from "../../../lists/NodeList";
import CreateFormulationForm from "./CreateFormulationForm";

/**
 * @author Emmanuel Barchichat
 * Container for the several forms of a drug
 */
class FormulationsContainer extends React.Component {
  constructor(props) {
    super(props);

    this.buildFormulations = this.buildFormulations.bind(this);
  }

  state = {
    errors: {},
    formulations: {},
    formulationComponents: {},
    availableMedicationForms: JSON.parse(JSON.stringify(this.props.medicationForms)),
    selectedForms: [],
    medicationForm: null,
    medicationFormError: null,
    accordionIndex: 1,
  };

  componentWillMount() {
    this.buildFormulations();
  }

  // Add a new drug formulation to the form
  newFormulation = async () => {
    let {
      formulationComponents,
      formulations,
      medicationForm,
      availableMedicationForms,
      selectedForms
    } = this.state;

    if (medicationForm === null) {
      this.setState({ medicationFormError: "Medication form has to be filled" });
    } else {
      let lastIndex = parseInt(Object.keys(formulations)[Object.keys(formulations).length-1]) + 1;
      formulations[lastIndex] = {};
      formulationComponents[lastIndex] = <CreateFormulationForm medicationForm={medicationForm} setActiveAccordion={this.setActiveAccordion} setFormulation={this.setFormulation} removeFormulation={this.removeFormulation} formulations={formulations} index={lastIndex} errors={{}} />;

      availableMedicationForms.splice( availableMedicationForms.indexOf(medicationForm), 1 );
      selectedForms.push(medicationForm);
      this.setState({
        availableMedicationForms: availableMedicationForms,
        selectedForms: selectedForms,
        accordionIndex: lastIndex,
        formulationComponents,
        formulations,
        medicationForm: null,
      });
    }
  };

  // Set general state of drug formulations so the container can access to all of then
  setFormulation = (key, formulation) => {
    let { formulations } = this.state;
    formulations[key] = formulation;
    this.setState({ formulations });
  };

  // Remove the selected formulation
  removeFormulation = async (key) => {
    let {
      formulationComponents,
      formulations,
      availableMedicationForms,
      selectedForms
    } = this.state;

    if (formulations[key].id !== undefined){
      formulations[key]._destroy = true;
    } else {
      formulations[key] = null;
    }

    formulationComponents[key] = null;
    availableMedicationForms.push(selectedForms[key-1]);
    selectedForms.splice(key-1, 1)

    await this.setState({ formulations, formulationComponents, availableMedicationForms, selectedForms });
  };

  // Get question hash and add drug formulations to it to finally create the whole question
  save = async () => {
    const {
      toggleModal,
      http,
      addMessage,
      set,
      currentDrug,
      currentHealthCareType
    } = this.props;
    let {
      formulations,
      formulationComponents
    } = this.state;

    Object.keys(formulations).map(function(key) {
      if (formulations[key] !== null && Object.keys(formulations[key]).length > 0){
        currentDrug.formulations_attributes[key] = formulations[key];
      }
    });

    let result = currentDrug.id === undefined ? await http.createDrug(currentDrug, currentHealthCareType) : await http.updateHealthCare(currentDrug, currentHealthCareType);
    if (result.ok === undefined || result.ok) {
      toggleModal();
      this.resetFormulationLists();
      await addMessage({ status: result.status, messages: result.messages });
      set("currentDbNode", result.node);
    } else {

      let i = 0;
      Object.keys(formulationComponents).map(function(key) {
        formulationComponents[key] = React.cloneElement(formulationComponents[key], {
          errors: result.errors[i]
        });
        i++;
      });

      let newErrors = {};

      if (result.errors.label !== undefined) {
        newErrors.label = result.errors.label[0];
      }
      this.setState({ errors: newErrors, formulationComponents });
    }
  };

  // Build the drug formulations hashes, empty if this is a create form or with its answers if it is an update
  buildFormulations = () => {
    const {
      currentDrug,
      medicationForms
    } = this.props;

    // If this is a question creation, set an empty hash of drug formulations and a new form for a new formulation
    if (currentDrug.id === undefined) {
      this.setState({
        formulations: {0: {}},
        formulationComponents: {},
      });
    } else { // If this is a question updating, set drug formulations form and drug formulations hash
      const { currentNode } = this.props;
      const { selectedForms } = this.state;
      let formulations = {};
      let formulationComponents = {};
      let drugFormulations = currentNode.formulations;
      // build formulations
      drugFormulations.map((formulation, index) => {
        formulations[index] = {
          id: formulation.id,
          administration_route_id: parseInt(formulation.administration_route_id),
          minimal_dose_per_kg: parseInt(formulation.minimal_dose_per_kg),
          maximal_dose_per_kg: parseInt(formulation.maximal_dose_per_kg),
          maximal_dose: parseInt(formulation.maximal_dose),
          medication_form: selectedForms[index],
          dose_form: parseInt(formulation.dose_form),
          liquid_concentration: parseInt(formulation.liquid_concentration),
          doses_per_day: parseInt(formulation.doses_per_day),
          unique_dose: parseInt(formulation.unique_dose),
          by_age: formulation.by_age,
          _destroy: false
        }
      });

      for (let i = 0; i < drugFormulations.length; i++) {
        formulationComponents[i] = <CreateFormulationForm setFormulation={this.setFormulation} formulations={formulations} removeFormulation={this.removeFormulation} index={i} errors={{}} update={true} />
      }

      this.setState({
        formulations,
        formulationComponents
      });
    }
  };

  handleMedicationFormChange = () => {
    this.setState({ medicationForm: event.target.value });
  };

  setActiveAccordion = (index) => {
    this.setState({accordionIndex: index});
  };

  closeModal = () => {
    const { toggleModal } = this.props;
    this.resetFormulationLists();
    toggleModal();
  };

  resetFormulationLists = () => {
    const {medicationForms} = this.props;

    this.setState({
      availableMedicationForms: medicationForms,
      selectedForms: []
    })
  };

  render() {
    const {
      formulationComponents,
      medicationFormError,
      availableMedicationForms,
      accordionIndex
    } = this.state;

    return (
      <Form onSubmit={() => this.create()}>
        <Modal.Header>
          <Modal.Title>Create drug formulations</Modal.Title>
        </Modal.Header>
        <Modal.Body>
          <Accordion activeKey={accordionIndex}>
            {Object.keys(formulationComponents).map((key) => {
              return formulationComponents[key];
            })}
          </Accordion>
        </Modal.Body>
        <Modal.Footer>
          <Form.Control as="select" name="medicationForm" onChange={this.handleMedicationFormChange} isInvalid={!!medicationFormError } >
            <option value="">Select a medication form</option>
            {availableMedicationForms.map((medicationForm) => (
              <option value={medicationForm}>{medicationForm.charAt(0).toUpperCase() + medicationForm.slice(1)}</option>
            ))}
          </Form.Control>
          <Form.Control.Feedback type="invalid">
            {medicationFormError}
          </Form.Control.Feedback>

          <Button variant="primary" onClick={() => this.newFormulation()}>
            New formulation
          </Button>

          <Button variant="success" onClick={() => this.save()}>
            Validate
          </Button>
          <Button variant="secondary" onClick={() => this.closeModal()}>
            Close
          </Button>

        </Modal.Footer>
      </Form>
    );
  }
}

export default withDiagram(FormulationsContainer);
