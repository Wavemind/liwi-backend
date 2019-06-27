import React from "react";
import {
  Button,
  Modal,
  Form,
  InputGroup,
  Col
} from "react-bootstrap";
import { withDiagram } from "../../../../context/Diagram.context";
import NodeListItem from "../../../lists/NodeList";

/**
 * @author Quentin Girard
 * Modal content to create a predefined syndrome
 */
class CreateQuestionForm extends React.Component {
  constructor(props) {
    super(props);

    this.handleReference = this.handleReference.bind(this);
    this.handleLabel = this.handleLabel.bind(this);
    this.handleDescription = this.handleDescription.bind(this);
    this.handleType = this.handleType.bind(this);
    this.handleStage = this.handleStage.bind(this);
    this.handlePriority = this.handlePriority.bind(this);
    this.handleAnswerType = this.handleAnswerType.bind(this);
  }

  state = {
    reference: "",
    label: "",
    description: "",
    type: "",
    stage: "",
    priority: "",
    answerType: "",
    prefix: "",
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

    let question = this.generateQuestionBody();

    let result = await http.createQuestion(question);
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

  createAnswers = async () => {
    const { set } = this.props;
    const question = this.generateQuestionBody();

    set('currentQuestion', question);
    set('modalToOpen', 'CreateAnswers');
    set('modalIsOpen', true);
  };

  generateQuestionBody = () => {
    const {
      reference,
      label,
      description,
      type,
      stage,
      priority,
      answerType
    } = this.state;

    return {
      question: {
        reference: reference,
        label_en: label,
        description_en: description,
        type: type,
        stage: parseInt(stage),
        priority: parseInt(priority),
        answer_type_id: parseInt(answerType),
        answers_attributes: {}
      }
    };
  }


  // Set state for the input changes
  handleType = (event) => {
    const {questionCategories} = this.props;

    questionCategories.map((category) => {
      if (category.name === event.target.value) {
        this.setState({ prefix: category.reference_prefix });
      }
    });

    this.setState({ type: event.target.value });
  };

  // Set state for the input changes
  handleStage = (event) => {
    this.setState({ stage: event.target.value });
  };

  // Set state for the input changes
  handlePriority = (event) => {
    this.setState({ priority: event.target.value });
  };

  // Set state for the input changes
  handleAnswerType = (event) => {
    this.setState({ answerType: event.target.value });
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
    const {
      toggleModal,
      questionCategories,
      questionAnswerTypes,
      questionStages,
      questionPriorities,
    } = this.props;
    const {
      reference,
      label,
      description,
      errors,
      type,
      stage,
      priority,
      answerType,
      prefix
    } = this.state;

    return (
      <Form onSubmit={() => this.create()}>
        <Modal.Header>
          <Modal.Title>Create a question</Modal.Title>
        </Modal.Header>
        <Modal.Body>
          <Form.Row>
            <Form.Group as={Col} controlId="formGridState">
              <Form.Label>Category</Form.Label>
              <Form.Control as="select" onChange={this.handleType} defaultValue={type}>
                <option value="">Select a category</option>
                {questionCategories.map((category) => (
                  <option value={category.name}>{category.label}</option>
                ))}
              </Form.Control>
            </Form.Group>
          </Form.Row>

          <Form.Row>
            <Form.Group as={Col} controlId="formGridState">
              <Form.Label>Answer type</Form.Label>
              <Form.Control as="select" onChange={this.handleAnswerType} defaultValue={answerType}>
                <option value="">Select a category</option>
                {questionAnswerTypes.map((answerType) => (
                  <option value={answerType.id}>{answerType.display_name}</option>
                ))}
              </Form.Control>
            </Form.Group>
          </Form.Row>

          <Form.Row>
            <Form.Group as={Col} controlId="formGridState">
              <Form.Label>Stage</Form.Label>
              <Form.Control as="select" onChange={this.handleStage} defaultValue={stage}>
                <option value="">Select a category</option>
                {Object.keys(questionStages).map(function(key) {
                  return <option value={questionStages[key]}>{key.charAt(0).toUpperCase() + key.slice(1)}</option>;
                })}
              </Form.Control>
            </Form.Group>
          </Form.Row>

          <Form.Row>
            <Form.Group as={Col} controlId="formGridState">
              <Form.Label>Priority</Form.Label>
              <Form.Control as="select" onChange={this.handlePriority} defaultValue={priority}>
                <option value="">Select a category</option>
                {Object.keys(questionPriorities).map(function(key) {
                  return <option value={questionPriorities[key]}>{key.charAt(0).toUpperCase() + key.slice(1)}</option>;
                })}
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
          {(answerType === '1') ? (
            <Button variant="success" onClick={() => this.create()}>
              Save
            </Button>
          ) : (
            <Button variant="primary" onClick={() => this.createAnswers()}>
              Save and create answers
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

export default withDiagram(CreateQuestionForm);
