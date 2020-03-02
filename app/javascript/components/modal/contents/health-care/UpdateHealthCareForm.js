import React from "react";
import {
  Button,
  Modal,
  Form,
  InputGroup,
  Col
} from "react-bootstrap";
import { withDiagram } from "../../../../context/Diagram.context";
import * as _ from "lodash";

/**
 * @author Emmanuel Barchichat
 * Modal content to create an health cares
 */
class UpdateHealthCareForm extends React.Component {
  constructor(props) {
    super(props);
  }

  state = {
    id: null,
    label: "",
    description: "",
    isAntibiotic: false,
    isAntiMalarial: false,
    type: "",
    errors: {}
  };

  componentWillMount() {
    const { currentNode } = this.props;
    const newCurrentNode = _.cloneDeep(currentNode);

    this.setState({
      id: newCurrentNode.id,
      label: newCurrentNode.label_translations["en"],
      description: newCurrentNode.description_translations === null ? "" : newCurrentNode.description_translations["en"],
      isAntibiotic: newCurrentNode.is_antibiotic,
      isAntiMalarial: newCurrentNode.is_anti_malarial,
      type: newCurrentNode.type === "HealthCares::Management" ? "managements" : "drugs"
    });
  }

  update = async () => {
    const {
      toggleModal,
      http,
      addMessage,
      set
    } = this.props;

    const {
      id,
      label,
      description,
    } = this.state;

    let result = await http.updateManagement(id, label, description);
    if (result.ok === undefined || result.ok) {
      toggleModal();
      await addMessage({ status: result.status, messages: result.messages });
      set("currentDbNode", result.node);
    } else {
      let newErrors = {};
      if (result.errors.label !== undefined) {
        newErrors.label = result.errors.label[0];
      }
      this.setState({ errors: newErrors });
    }
  };

  updateFormulations = async () => {
    const { set, http } = this.props;

    const {
      id,
      label,
      description,
      isAntibiotic,
      isAntiMalarial
    } = this.state;

    let drug = {
      id: id,
      label_en: label,
      is_antibiotic: isAntibiotic,
      is_anti_malarial: isAntiMalarial,
      description_en: description,
      formulations_attributes: {}
    };

    let result = await http.validateDrug(drug);
    if (result.ok === undefined || result.ok) {
      set(
        ['currentDrug', 'modalToOpen', 'modalIsOpen'],
        [drug, 'UpdateFormulations', true]
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
      description,
      isAntibiotic,
      isAntiMalarial,
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

          {(currentHealthCareType === 'drugs') ? (
            <Form.Row>
              <Form.Group as={Col}>
                <Form.Check
                  type="checkbox"
                  label="Antibiotic"
                  name="isAntibiotic"
                  defaultChecked={isAntibiotic}
                  onChange={this.updateState}
                />
              </Form.Group>

              <Form.Group as={Col}>
                <Form.Check
                  type="checkbox"
                  label="Anti malarial"
                  name="isAntiMalarial"
                  defaultChecked={isAntiMalarial}
                  onChange={this.updateState}
                />
              </Form.Group>
            </Form.Row>
          ) : (
            null
          )}

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
          {/*Save directly the managements but go to formulations for the drugs*/}
          {(currentHealthCareType === 'drugs') ? (
            <Button variant="primary" onClick={() => this.updateFormulations()}>
              Save and edit formulations
            </Button>
          ) : (
            <Button variant="success" onClick={() => this.update()}>
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

export default withDiagram(UpdateHealthCareForm);
