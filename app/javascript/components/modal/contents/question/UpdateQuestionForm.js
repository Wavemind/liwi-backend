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
 * Modal to update a question
 */
class UpdateQuestionForm extends React.Component {
  constructor(props) {
    super(props);
  }

  state = {
    id: "",
    reference: "",
    label: "",
    description: "",
    type: "",
    stage: "",
    priority: "",
    answerType: "",
    errors: {}
  };

  componentWillMount() {
    const {
      currentNode,
      questionStages,
      questionPriorities
    } = this.props;
    const newCurrentNode = _.cloneDeep(currentNode);

    this.setState({
      id: newCurrentNode.id,
      reference: newCurrentNode.reference,
      label: newCurrentNode.label_translations["en"],
      type: newCurrentNode.type,
      description: newCurrentNode.description_translations === null ? "" : newCurrentNode.description_translations["en"],
      priority: questionPriorities[newCurrentNode.priority],
      stage: questionStages[newCurrentNode.stage],
      answerType: newCurrentNode.answer_type_id
    });
  }

  updateAnswers = async () => {
    const { set } = this.props;
    const question = this.generateQuestionBody();

    set(
      ['currentQuestion', 'modalToOpen', 'modalIsOpen'],
      [question, 'UpdateAnswers', true]
    );
  };

  // Update the score in DB then set score props in order to trigger listener in Diagram.js that will update diagram dynamically
  update = async () => {
    const {
      toggleModal,
      http,
      addMessage,
      set,
      currentNode
    } = this.props;

    const { id } = this.state;
    let question = this.generateQuestionBody();

    let result = await http.updateQuestion(question);
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

  // Generate the body of the question
  generateQuestionBody = () => {
    const {
      id,
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
        id: id,
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
    } = this.state;

    return (
      <Form onSubmit={() => this.create()}>
        <Modal.Header>
          <Modal.Title>Update this question</Modal.Title>
        </Modal.Header>
        <Modal.Body>
          <Form.Row>
            <Form.Group as={Col} controlId="formGridState">
              <Form.Label>Category</Form.Label>
              <Form.Control as="select" defaultValue={type} disabled>
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
              <Form.Control as="select" defaultValue={answerType} disabled>
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
              <Form.Control as="select" name="stage" onChange={this.handleFormChange} defaultValue={stage}>
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
              <Form.Control as="select" name="priority" onChange={this.handleFormChange} defaultValue={priority}>
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
                  onChange={this.handleFormChange}
                />
              </InputGroup>
            </Form.Group>
          </Form.Row>

        </Modal.Body>
        <Modal.Footer>
          {/*Save directly the question if it is a boolean*/}
          {(answerType === 1) ? (
            <Button variant="success" onClick={() => this.update()}>
              Save
            </Button>
          ) : (
            <Button variant="primary" onClick={() => this.updateAnswers()}>
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

export default withDiagram(UpdateQuestionForm);