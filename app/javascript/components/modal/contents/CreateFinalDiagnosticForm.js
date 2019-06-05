import React from "react";
import {
  Button,
  Modal,
  FormControl,
  Form
} from "react-bootstrap";
import {withDiagram} from "../../../context/Diagram.context";

/**
 * @author Emmanuel Barchichat
 * Modal content to create a final diagnostic
 */
class CreateFinalDiagnosticForm extends React.Component {
  constructor(props) {
    super(props);

    this.handleReference = this.handleReference.bind(this);
    this.handleLabel = this.handleLabel.bind(this);
    this.handleDescription = this.handleDescription.bind(this);
  }

  state = {
    reference: null,
    label: null,
    description: null,
  };

  // Update the score in DB then set score props in order to trigger listener in Diagram.js that will update diagram dynamically
  create = async () => {
    const {
      toggleModal,
      http,
      addMessage
    } = this.props;

    const {
      reference,
      label,
      description
    } = this.state;

    let result = await http.createFinalDiagnostic(reference, label, description);
    if (result.ok === undefined || result.ok) {
      toggleModal();
    }
    let message = {
        status: result.status,
        message: [result.statusText],
    };
    await addMessage(message);
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
    const {toggleModal} = this.props;
    return (
      <Form onSubmit={() => this.updateScore()}>
        <Modal.Header closeButton>
          <Modal.Title>Create a Final diagnostic</Modal.Title>
        </Modal.Header>
        <Modal.Body>
          <FormControl
            placeholder="Reference"
            value={this.state.reference}
            onChange={this.handleReference}
          />
          <FormControl
            placeholder="Label"
            type="text"
            value={this.state.label}
            onChange={this.handleLabel}
          />
          <FormControl
            placeholder="Description"
            type="text"
            value={this.state.description}
            onChange={this.handleDescription}
          />
        </Modal.Body>
        <Modal.Footer>
          <Button variant="primary" onClick={() => this.create()}>
            Create
          </Button>
          <Button variant="secondary" onClick={() => toggleModal()}>
            Close
          </Button>
        </Modal.Footer>
      </Form>
    );
  }
}

export default withDiagram(CreateFinalDiagnosticForm);
