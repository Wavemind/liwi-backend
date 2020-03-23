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
    accordionIndex: 0,
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
      formulations[lastIndex] = {medication_form: medicationForm};
      formulationComponents[lastIndex] = <CreateFormulationForm medicationForm={medicationForm} setActiveAccordion={this.setActiveAccordion} setFormulation={this.setFormulation} removeFormulation={this.removeFormulation} formulations={formulations} index={lastIndex} errors={{}} />;

      availableMedicationForms.splice( availableMedicationForms.indexOf(medicationForm), 1 );
      selectedForms.push(medicationForm);
      this.setState({
        availableMedicationForms: availableMedicationForms,
        selectedForms: selectedForms,
        accordionIndex: lastIndex,
        formulationComponents,
        formulations,
        medicationForm: "",
        medicationFormError: ""
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
    availableMedicationForms.push(selectedForms[key]);
    selectedForms.splice(key, 1);

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

    if (Object.keys(currentDrug.formulations_attributes).length < 1) {
      this.setState({ medicationFormError: "At least one formulation must be entered" });
    } else {

      let result = currentDrug.id === undefined ? await http.createDrug(currentDrug, currentHealthCareType) : await http.updateDrug(currentDrug);
      if (result.ok === undefined || result.ok) {
        toggleModal();
        this.resetFormulationLists(); // Reset medication forms list so the next drug will have all possibilities
        await addMessage({ status: result.status, messages: result.messages });

        // If it is a drug creation, open the instance pop up
        if (currentDrug.id === undefined) {
          set(["currentDbNode", "modalToOpen", "modalIsOpen"], [result.node, "CreateDrugInstance", true]);
        } else {
          set("currentDbNode", result.node);

        }
      } else {
        let i = 0;
        Object.keys(formulationComponents).map(function(key) {
          formulationComponents[key] = React.cloneElement(formulationComponents[key], {
            errors: result.errors[i]
          });
          i++;
        });
        this.setState({ formulationComponents });
      }
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
      let {
        availableMedicationForms,
        selectedForms
      } = this.state;
      let formulations = {};
      let formulationComponents = {};
      let drugFormulations = currentNode.formulations;

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
      availableMedicationForms: JSON.parse(JSON.stringify(medicationForms)),
      selectedForms: []
    })
  };

  render() {
    const {
      formulationComponents,
      medicationFormError,
      availableMedicationForms,
      accordionIndex,
      medicationForm
    } = this.state;

    return (
      <Form onSubmit={() => this.create()}>
        <Modal.Header>
          <Modal.Title>Create drug formulations</Modal.Title>
        </Modal.Header>
        <Modal.Body>
          <Accordion activeKey={accordionIndex} defaultActiveKey={Object.keys(formulationComponents).length -1}>
            {Object.keys(formulationComponents).map((key) => {
              return formulationComponents[key];
            })}
          </Accordion>
        </Modal.Body>
        <Modal.Footer>
          <Form.Control as="select" name="medicationForm" value={medicationForm} onChange={this.handleMedicationFormChange} isInvalid={!!medicationFormError } >
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