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
 * @author Quentin Girard
 * Modal content to create a predefined syndrome
 */
class UpdatePredefinedSyndromeForm extends React.Component {
  constructor(props) {
    super(props);

    this.handleReference = this.handleReference.bind(this);
    this.handleLabel = this.handleLabel.bind(this);
    this.handleDescription = this.handleDescription.bind(this);
  }

  state = {
    reference: "",
    label: "",
    description: "",
    errors: {}
  };

  componentWillMount() {
    const { currentNode } = this.props;
    const newCurrentNode = _.cloneDeep(currentNode);

    this.setState({
      id: newCurrentNode.id,
      reference: newCurrentNode.reference,
      label: newCurrentNode.label_translations["en"],
      description: newCurrentNode.description_translations === null ? '' : newCurrentNode.description_translations["en"],
    });
  }

  // Update the score in DB then set score props in order to trigger listener in Diagram.js that will update diagram dynamically
  update = async () => {
    console.log('fesse')
    const {
      toggleModal,
      http,
      addMessage,
      set,
      currentNode
    } = this.props;

    const {
      reference,
      label,
      description
    } = this.state;

    let result = await http.updatePredefinedSyndrome(currentNode.id, reference, label, description);
    if (result.ok === undefined || result.ok) {
      toggleModal();
      await addMessage({ status: result.status, messages: result.messages });
      set("currentDbNode", result.node);
    } else {
      let newErrors = {};
      if (result.errors.reference !== undefined) {
        newErrors.reference = result.errors.reference[0];
      }

      if (result.errors.label !== undefined) {
        newErrors.label = result.errors.label[0];
      }
      this.setState({ errors: newErrors });
    }
  };

  // Set state for the input changes
  handleReference = (event) => {
    this.setState({ reference: event.target.value });
  };

  // Set state for the input changes
  handleLabel = (event) => {
    this.setState({ label: event.target.value });
  };

  // Set state for the input changes
  handleDescription = (event) => {
    this.setState({ description: event.target.value });
  };


  render() {
    const { toggleModal } = this.props;
    const {
      reference,
      label,
      description,
      errors,
    } = this.state;

    return (
      <Form onSubmit={() => this.update()}>
        <Modal.Header closeButton>
          <Modal.Title>Create a predefined syndrome</Modal.Title>
        </Modal.Header>
        <Modal.Body>
          <Form.Row>
            <Form.Group as={Col}>
              <Form.Label>Reference</Form.Label>
              <InputGroup>
                <Form.Control
                  type="text"
                  aria-describedby="inputGroupPrepend"
                  name="reference"
                  value={reference}
                  onChange={this.handleReference}
                  isInvalid={!!errors.reference}
                />
                <Form.Control.Feedback type="invalid">
                  {errors.reference}
                </Form.Control.Feedback>
              </InputGroup>
            </Form.Group>
          </Form.Row>

          <Form.Row>
            <Form.Group as={Col}>
              <Form.Label>Label</Form.Label>
              <InputGroup>
                <Form.Control
                  type="text"
                  aria-describedby="inputGroupPrepend"
                  name="label"
                  value={label}
                  onChange={this.handleLabel}
                  isInvalid={!!errors.label}
                />
                <Form.Control.Feedback type="invalid">
                  {errors.label}
                </Form.Control.Feedback>
              </InputGroup>
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
                  onChange={this.handleDescription}
                />
              </InputGroup>
            </Form.Group>
          </Form.Row>

        </Modal.Body>
        <Modal.Footer>
          <Button variant="primary" onClick={() => this.update()}>
            Update
          </Button>
          <Button variant="secondary" onClick={() => toggleModal()}>
            Close
          </Button>
        </Modal.Footer>
      </Form>
    );
  }
}

export default withDiagram(UpdatePredefinedSyndromeForm);
