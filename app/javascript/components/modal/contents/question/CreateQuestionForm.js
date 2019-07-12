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
 * @author Emmanuel Barchichat
 * Modal to create a question
 */
class CreateQuestionForm extends React.Component {
  constructor(props) {
    super(props);
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
    const { set, http } = this.props;
    const question = this.generateQuestionBody();

    let result = await http.validateQuestion(question);
    if (result.ok === undefined || result.ok) {
      set(
        ['currentQuestion', 'modalToOpen', 'modalIsOpen'],
        [question, 'CreateAnswers', true]
      );
    } else {
      let newErrors = {};

      // TODO map answers to generate proper errors table
      if (result.errors.reference !== undefined) {
        newErrors.reference = result.errors.reference[0];
      }

      if (result.errors.label_en !== undefined) {
        newErrors.label_en = result.errors.label_en[0];
      }

      if (result.errors.priority !== undefined) {
        newErrors.priority = result.errors.priority[0];
      }

      if (result.errors.answer_type !== undefined) {
        newErrors.answerType = result.errors.answer_type[0];
      }

      if (result.errors.type !== undefined) {
        newErrors.category = result.errors.type[0];
      }
      this.setState({ errors: newErrors });
    }

  };

  // Generate the body of the question
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
  };

  // Handle change of inputs in the form
  handleFormChange = (event) => {
    const value = event.target.value;
    const name = event.target.name;

    if (name === "type") {
      const {questionCategories} = this.props;

      questionCategories.map((category) => {
        if (category.name === event.target.value) {
          this.setState({ prefix: category.reference_prefix });
        }
      });
    }
    this.setState({
      [name]: value
    });
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
              <Form.Control as="select" name="type" onChange={this.handleFormChange} defaultValue={type} isInvalid={!!errors.category}>
                <option value="">Select the category</option>
                {questionCategories.map((category) => (
                  <option value={category.name}>{category.label}</option>
                ))}
              </Form.Control>

              <Form.Control.Feedback type="invalid">
                {errors.category}
              </Form.Control.Feedback>
            </Form.Group>
          </Form.Row>

          <Form.Row>
            <Form.Group as={Col} controlId="formGridState">
              <Form.Label>Answer type</Form.Label>
              <Form.Control as="select" name="answerType" onChange={this.handleFormChange} defaultValue={answerType} isInvalid={!!errors.answerType }>
                <option value="">Select the type of answers expected</option>
                {questionAnswerTypes.map((answerType) => (
                  <option value={answerType.id}>{answerType.display_name}</option>
                ))}
              </Form.Control>

              <Form.Control.Feedback type="invalid">
                {errors.answerType}
              </Form.Control.Feedback>
            </Form.Group>
          </Form.Row>

          <Form.Row>
            <Form.Group as={Col} controlId="formGridState">
              <Form.Label>Stage</Form.Label>
              <Form.Control as="select" name="stage" onChange={this.handleFormChange} defaultValue={stage} isInvalid={!!errors.stage }>
                <option value="">Select the stage</option>
                {Object.keys(questionStages).map(function(key) {
                  return <option value={questionStages[key]}>{key.charAt(0).toUpperCase() + key.slice(1)}</option>;
                })}
              </Form.Control>
              <Form.Control.Feedback type="invalid">
                {errors.stage}
              </Form.Control.Feedback>
            </Form.Group>
          </Form.Row>

          <Form.Row>
            <Form.Group as={Col} controlId="formGridState">
              <Form.Label>Priority</Form.Label>
              <Form.Control as="select" name="priority" onChange={this.handleFormChange} defaultValue={priority} isInvalid={!!errors.priority }>
                <option value="">Select the priority</option>
                {Object.keys(questionPriorities).map(function(key) {
                  return <option value={questionPriorities[key]}>{key.charAt(0).toUpperCase() + key.slice(1)}</option>;
                })}
              </Form.Control>
              <Form.Control.Feedback type="invalid">
                {errors.priority}
              </Form.Control.Feedback>
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
                  onChange={this.handleFormChange}
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
                  onChange={this.handleFormChange}
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
                  onChange={this.handleFormChange}
                />
              </InputGroup>
            </Form.Group>
          </Form.Row>

        </Modal.Body>
        <Modal.Footer>
          {/*Save directly the question if it is a boolean*/}
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
