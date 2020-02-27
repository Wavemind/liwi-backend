import React from "react";
import {
  Button,
  Modal,
  Form,
  InputGroup,
  Col
} from "react-bootstrap";
import { withDiagram } from "../../../../context/Diagram.context";

/**
 * @author Emmanuel Barchichat
 * Modal content to create an health cares
 */
class CreateHealthCareForm extends React.Component {
  constructor(props) {
    super(props);
  }

  state = {
    label: "",
    description: "",
    isAntiBiotic: null,
    isAntiMalarial: null,
    errors: {}
  };

  // Update the score in DB then set score props in order to trigger listener in Diagram.js that will update diagram dynamically
  create = async () => {
    const {
      toggleModal,
      http,
      addMessage,
      set,
    } = this.props;

    const {
      label,
      description,
    } = this.state;

    let result = await http.createManagement(label, description);
    if (result.ok === undefined || result.ok) {
      toggleModal();
      await addMessage({ status: result.status, messages: result.messages });
      set("currentDbNode", result.node);
    } else {
      let newErrors = {};
      if (result.errors.label_en !== undefined) {
        newErrors.label_en = result.errors.label_en[0];
      }
      this.setState({ errors: newErrors });
    }
  };

  // Validate first the drug data. If it is valid, open the formulations form, if not display the errors
  createFormulations = async () => {
    const {
      set,
      http,
    } = this.props;

    const {
      label,
      isAntiBiotic,
      isAntiMalarial,
      description
    } = this.state;

    let drug = {
      label_en: label,
      is_antibiotic: isAntiBiotic,
      is_anti_malarial: isAntiMalarial,
      description_en: description,
      formulations_attributes: {}
    };

    let result = await http.validateDrug(drug);
    if (result.ok === undefined || result.ok) {
      set(
        ['currentDrug', 'modalToOpen', 'modalIsOpen'],
        [drug, 'CreateFormulations', true]
      );
    } else {
      this.handleErrors(result);
    }
  };

  // Set value of inputs in state
  updateState = (event) => {
    const key = event.target.name;
    const value = ["isAntibiotic", "isAntiMalarial"].includes(key) ? event.target.checked : event.target.value;
    this.setState({ [key]: value });
  };

  // Display errors from response of the drug validation from rails if there is any
  handleErrors = (result) => {
    let newErrors = {};

    if (result.errors.label_en !== undefined) {
      newErrors.label_en = result.errors.label_en[0];
    }

    this.setState({ errors: newErrors });
  };

  render() {
    const {
      toggleModal,
      currentHealthCareType,
    } = this.props;
    const {
      label,
      isAntiBiotic,
      isAntiMalarial,
      description,
      errors
    } = this.state;

    return (
      <Form onSubmit={this.create}>
        <Modal.Header>
          <Modal.Title>Create an health cares</Modal.Title>
        </Modal.Header>
        <Modal.Body>
          <Form.Row>
            <Form.Group as={Col}>
              <Form.Label>Label</Form.Label>
              <InputGroup>
                <Form.Control
                  type="text"
                  aria-describedby="inputGroupPrepend"
                  name="label"
                  value={label}
                  onChange={this.updateState}
                  isInvalid={!!errors.label_en}
                />
                <Form.Control.Feedback type="invalid">
                  {errors.label_en}
                </Form.Control.Feedback>
              </InputGroup>
            </Form.Group>
          </Form.Row>

          <Form.Row>
            <Form.Group as={Col}>
              <Form.Check
                type="checkbox"
                label="Antibiotic"
                name="isAntiBiotic"
                value={isAntiBiotic}
                onChange={this.handleFormChange}
              />
            </Form.Group>

            <Form.Group as={Col}>
              <Form.Check
                type="checkbox"
                label="Anti malarial"
                name="isAntiMalarial"
                value={isAntiMalarial}
                onChange={this.handleFormChange}
              />
            </Form.Group>
          </Form.Row>

          <Form.Row>
            <Form.Group as={Col}>
              <Form.Label>Description</Form.Label>
              <InputGroup>
                <Form.Control
                  type="text"
                  as="textarea"
                  rows="3"
                  name="description"
                  width="100%"
                  value={description}
                  onChange={this.updateState}
                />
              </InputGroup>
            </Form.Group>
          </Form.Row>

        </Modal.Body>
        <Modal.Footer>
          {/*Save directly the management but go to formulations for the drugs*/}
          {(currentHealthCareType === 'drugs') ? (
            <Button variant="primary" onClick={() => this.createFormulations()}>
              Save and create formulations
            </Button>
          ) : (
            <Button variant="success" onClick={() => this.create()}>
            Save
            </Button>
          )}
          <Button variant="secondary" onClick={() => toggleModal()}>
            Close
          </Button>
        </Modal.Footer>
      </Form>
    );
  }
}

export default withDiagram(CreateHealthCareForm);
