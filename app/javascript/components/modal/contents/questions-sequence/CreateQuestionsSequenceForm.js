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
 * @author Quentin Girard
 * Modal content to create a question sequence
 */
class CreateQuestionsSequenceForm extends React.Component {
  constructor(props) {
    super(props);
  }

  state = {
    reference: "",
    label: "",
    description: "",
    type: "",
    prefix: "",
    minScore: "",
    minScoreClass: "form-row d-none",
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
      description,
      type,
      minScore
    } = this.state;

    let result = await http.createQuestionsSequence(reference, label, description, type, minScore);
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

  // Add score input if type is QuestionsSequences::Scored
  handleType = (event) => {
    const { questionsSequenceCategories } = this.props;
    let prefix = "";
    let minScoreClass = "";
    let minScore = "";

    questionsSequenceCategories.map((category) => {
      if (category.name === event.target.value) {
        prefix = category.reference_prefix;
      }
    });

    if (event.target.value === "QuestionsSequences::Scored") {
      minScoreClass = "form-row";
    } else {
      minScoreClass = "form-row d-none";
      minScore = 0;
    }

    this.setState({
      type: event.target.value,
      prefix,
      minScoreClass,
      minScore,
    });
  };

  // Set value of inputs in state
  updateState = (event) => {
    const key = event.target.name;
    const value = event.target.value;
    this.setState({ [key]: value });
  };


  render() {
    const {
      toggleModal,
      questionsSequenceCategories
    } = this.props;
    const {
      reference,
      label,
      description,
      errors,
      minScore,
      minScoreClass,
      prefix
    } = this.state;


    return (
      <Form onSubmit={this.create}>
        <Modal.Header>
          <Modal.Title>Create a questions sequence</Modal.Title>
        </Modal.Header>
        <Modal.Body>
          <Form.Row>
            <Form.Group as={Col} controlId="formGridState">
              <Form.Label>State</Form.Label>
              <Form.Control
                as="select"
                onChange={this.handleType}>
                <option value="">Select a category</option>
                {questionsSequenceCategories.map((category) => (
                  <option value={category.name}>{category.label}</option>
                ))}
              </Form.Control>
            </Form.Group>
          </Form.Row>

          <Form.Row>
            <Form.Group as={Col}>
              <Form.Label>Reference</Form.Label>
              <InputGroup>
                <InputGroup.Prepend>
                  <InputGroup.Text id="inputGroupPrepend">{prefix}</InputGroup.Text>
                </InputGroup.Prepend>
                <Form.Control
                  type="text"
                  aria-describedby="inputGroupPrepend"
                  name="reference"
                  value={reference}
                  onChange={this.updateState}
                  isInvalid={!!errors.reference}
                />
                <Form.Control.Feedback type="invalid">
                  {errors.reference}
                </Form.Control.Feedback>
              </InputGroup>
            </Form.Group>
          </Form.Row>

          <Form.Row className={minScoreClass}>
            <Form.Group as={Col}>
              <Form.Label>Minimal score</Form.Label>
              <InputGroup>
                <Form.Control
                  type="number"
                  rows="3"
                  name="minScore"
                  width="100%"
                  value={minScore}
                  onChange={this.updateState}
                />
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

export default withDiagram(CreateQuestionsSequenceForm);
