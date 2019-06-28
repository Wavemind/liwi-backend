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
class CreateAnswerForm extends React.Component {
  constructor(props) {
    super(props);

    this.handleLabel = this.handleLabel.bind(this);
    this.handleReference = this.handleReference.bind(this);
    this.handleOperator = this.handleOperator.bind(this);
    this.handleValue = this.handleValue.bind(this);
  }

  // Set state for the input changes
  handleOperator = async (event) => {
    await this.setState({ operator: event.target.value });
    this.pushAnswer();
  };

  // Set state for the input changes
  handleValue = async (event) => {
    await this.setState({ value: event.target.value });
    this.pushAnswer();
  };

  // Set state for the input changes
  handleLabel = async (event) => {
    await this.setState({ label: event.target.value });
    this.pushAnswer();
  };

  // Set state for the input changes
  handleReference = async (event) => {
    await this.setState({ reference: event.target.value });
    this.pushAnswer();
  };

  // Push the answer object to the container
  pushAnswer = () => {
    const {
      setAnswer,
      index
    } = this.props;
    const {
      reference,
      label,
      operator,
      value
    } = this.state;

    let answer = {
      reference: reference,
      label_en: label,
      operator: parseInt(operator),
      value: value,
      _destroy: false
    };

    setAnswer(index, answer);
  };

  state = {
    reference: this.props.answers[this.props.index].reference,
    label: this.props.answers[this.props.index].label_en,
    operator: this.props.answers[this.props.index].operator,
    value: this.props.answers[this.props.index].value,
    errors: {}
  };

  render() {
    const {
      questionCategories,
      answersOperators,
      currentQuestion,
      removeAnswer,
      index
    } = this.props;
    const {
      reference,
      label,
      operator,
      value,
      errors,
    } = this.state;

    let prefix = '';

    questionCategories.map((category) => {
      if (category.name === currentQuestion.question.type) {
        prefix = category.reference_prefix
      }
    });
    prefix += currentQuestion.question.reference + '_';

    return (
      <Form onSubmit={() => this.create()}>
        <Modal.Body>

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
            <Form.Group as={Col} controlId="formGridState">
              <Form.Label>Operator</Form.Label>
              <Form.Control as="select" onChange={this.handleOperator} defaultValue={operator}>
                <option value="">Select a category</option>
                {Object.keys(answersOperators).map(function(key) {
                  return <option value={answersOperators[key]}>{key}</option>;
                })}
              </Form.Control>
            </Form.Group>

            <Form.Group as={Col}>
              <Form.Label>Value</Form.Label>
              <InputGroup>
                <Form.Control
                  type="text"
                  rows="3"
                  name="description"
                  width="100%"
                  value={value}
                  onChange={this.handleValue}
                />
              </InputGroup>
            </Form.Group>

            <Form.Group as={Col}>
              <Button variant="danger" onClick={() => removeAnswer(index)}>
                Remove
              </Button>
            </Form.Group>
          </Form.Row>
        </Modal.Body>
      </Form>
    );
  }
}

export default withDiagram(CreateAnswerForm);
