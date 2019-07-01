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
 * Modal content to create a questions sequence
 */
class UpdateQuestionForm extends React.Component {
  constructor(props) {
    super(props);

    this.handleReference = this.handleReference.bind(this);
    this.handleLabel = this.handleLabel.bind(this);
    this.handleDescription = this.handleDescription.bind(this);
    this.handleMinScore = this.handleMinScore.bind(this);
  }

  state = {
    reference: "",
    label: "",
    description: "",
    type: "",
    minScore: "",
    minScoreClass: "",
    errors: {}
  };

  componentWillMount() {
    const { currentNode } = this.props;
    const newCurrentNode = _.cloneDeep(currentNode);

    this.setState({
      id: newCurrentNode.id,
      reference: newCurrentNode.reference,
      label: newCurrentNode.label_translations["en"],
      type: newCurrentNode.type,
      description: newCurrentNode.description_translations === null ? "" : newCurrentNode.description_translations["en"],
      minScore: newCurrentNode.min_score,
      minScoreClass: newCurrentNode.category_name === "scored" ? "form-row" : "form-row d-none",
    });
  }

  // Update the score in DB then set score props in order to trigger listener in Diagram.js that will update diagram dynamically
  update = async () => {
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
      description,
      minScore
    } = this.state;

    let result = await http.updateQuestionsSequence(currentNode.id, reference, label, description, minScore);
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

  // Set state for the input changes
  handleMinScore = (event) => {
    this.setState({ minScore: event.target.value });
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
              <Form.Control as="select" onChange={this.handleType} defaultValue={type} disabled>
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
              <Form.Control as="select" onChange={this.handleAnswerType} defaultValue={answerType} disabled>
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
              <Form.Label>Description</Form.Label>a
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

export default withDiagram(UpdateQuestionForm);
