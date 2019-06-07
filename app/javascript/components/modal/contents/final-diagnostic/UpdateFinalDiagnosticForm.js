import React from "react";
import {
  Button,
  Modal,
  Form,
  InputGroup,
  Col
} from "react-bootstrap";
import {withDiagram} from "../../../../context/Diagram.context";

/**
 * @author Quentin Girard
 * Modal content to update a final diagnostic
 */
class UpdateFinalDiagnosticForm extends React.Component {
  constructor(props) {
    super(props);

    this.handleReference = this.handleReference.bind(this);
    this.handleLabel = this.handleLabel.bind(this);
    this.handleDescription = this.handleDescription.bind(this);
  }

  state = {
    reference: this.props.reference,
    label: this.props.label,
    description: this.props.description,
    errors: {},
  };

  // Update the score in DB then set score props in order to trigger listener in Diagram.js that will update diagram dynamically
  update = async () => {
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
      await addMessage({status: result.status, messages: result.messages});
      set('currentDbNode', result.node)
    } else {
      let newErrors = {};
      if (result.errors.reference !== undefined) {
        newErrors.reference = result.errors.reference[0];
      }

      if (result.errors.label !== undefined) {
        newErrors.label = result.errors.label[0];
      }
      this.setState({errors: newErrors});
    }
  };

  // Set state for the input changes
  handleReference = (event) => {
    this.setState({reference: event.target.value});
  };

  // Set state for the input changes
  handleLabel = (event) => {
    this.setState({label: event.target.value});
  };

  // Set state for the input changes
  handleDescription = (event) => {
    this.setState({description: event.target.value});
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
      <Form onSubmit={() => this.create()}>
        <Modal.Header closeButton>
          <Modal.Title>Create a Final diagnostic</Modal.Title>
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
            Save
          </Button>
          <Button variant="secondary" onClick={() => toggleModal()}>
            Close
          </Button>
        </Modal.Footer>
      </Form>
    );
  }
}

export default withDiagram(UpdateFinalDiagnosticForm);
