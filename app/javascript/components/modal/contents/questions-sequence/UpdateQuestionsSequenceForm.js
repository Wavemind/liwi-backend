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
class UpdateQuestionsSequenceForm extends React.Component {
  constructor(props) {
    super(props);
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

  // Set value of inputs in state
  updateState = (event) => {
    const key = event.target.name;
    const value = event.target.value;
    this.setState({ [key]: value });
  };


  render() {
    const {
      toggleModal,
      questionsSequenceCategories,
      getReferencePrefix
    } = this.props;
    const {
      reference,
      label,
      description,
      errors,
      minScore,
      type,
      minScoreClass
    } = this.state;

    return (
      <Form onSubmit={() => this.update()}>
        <Modal.Header>
          <Modal.Title>Edit a questions sequence</Modal.Title>
        </Modal.Header>
        <Modal.Body>
          <Form.Row>
            <Form.Group as={Col} controlId="state">
              <Form.Label>State</Form.Label>
              <Form.Control as="select" defaultValue={type} disabled>
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
                  <InputGroup.Text id="inputGroupPrepend">{getReferencePrefix('QuestionsSequence', type)}</InputGroup.Text>
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
          <Button variant="primary" onClick={this.update}>
            Update
          </Button>
          <Button variant="secondary" onClick={toggleModal}>
            Close
          </Button>
        </Modal.Footer>
      </Form>
    );
  }
}

export default withDiagram(UpdateQuestionsSequenceForm);
