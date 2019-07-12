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
 * Modal content to create a final diagnostic
 */
class CreateFinalDiagnosticForm extends React.Component {
  constructor(props) {
    super(props);
  }

  state = {
    reference: "",
    label: "",
    description: "",
    errors: {}
  };

  // Update the score in DB then set score props in order to trigger listener in Diagram.js that will update diagram dynamically
  create = async () => {
    const {
      toggleModal,
      http,
      addMessage,
      set
    } = this.props;

    const {
      reference,
      label,
      description
    } = this.state;

    let result = await http.createFinalDiagnostic(reference, label, description);
    if (result.ok === undefined || result.ok) {
      toggleModal();
      await addMessage({ status: result.status, messages: result.messages });
      set("currentDbNode", result.node);
    } else {
      let newErrors = {};
      if (result.errors.reference !== undefined) {
        newErrors.reference = result.errors.reference[0];
      }

      if (result.errors.label_en !== undefined) {
        newErrors.label_en = result.errors.label_en[0];
      }
      this.setState({ errors: newErrors });
    }
  };

  // Set value of inputs in state
  updateState = (event) => {
    const key = event.target.name;
    const value = event.target.value;
    this.setState({ [key]: value });
  };

  render() {
    const { toggleModal } = this.props;
    const {
      reference,
      label,
      description,
      errors
    } = this.state;

    return (
      <Form onSubmit={this.create}>
        <Modal.Header>
          <Modal.Title>Create a final diagnostic</Modal.Title>
        </Modal.Header>
        <Modal.Body>
          <Form.Row>
            <Form.Group as={Col}>
              <Form.Label>Reference</Form.Label>
              <InputGroup>
                <InputGroup.Prepend>
                  <InputGroup.Text id="inputGroupPrepend">DF</InputGroup.Text>
                </InputGroup.Prepend>
                <Form.Control
                  type="text"
                  aria-describedby="inputGroupPrepend"
                  name="reference"
                  value={reference}
                  index={"label"}
                  onChange={this.updateState}
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
          <Button variant="primary" onClick={this.create}>
            Create
          </Button>
          <Button variant="secondary" onClick={toggleModal}>
            Close
          </Button>
        </Modal.Footer>
      </Form>
    );
  }
}

export default withDiagram(CreateFinalDiagnosticForm);
