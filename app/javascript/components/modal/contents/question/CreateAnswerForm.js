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
 * Form of an answer
 */
class CreateAnswerForm extends React.Component {
  constructor(props) {
    super(props);
  }

  // Push the answer object to the container
  handleFormChange = () => {
    const value = event.target.value;
    const name = event.target.name;

    const {
      setAnswer,
      answers,
      index
    } = this.props;

    let answer = answers[index];
    answer[name] = name === "operator" ? parseInt(value) : value;

    setAnswer(index, answer);
  };

  render() {
    const {
      questionCategories,
      answersOperators,
      currentQuestion,
      removeAnswer,
      index,
      answers,
      update,
      errors
    } = this.props;
    const {
      reference,
      label_en,
      operator,
      value,
    } = answers[index];

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
              {(update === true) ? (
                <InputGroup>
                  <Form.Control
                    type="text"
                    aria-describedby="inputGroupPrepend"
                    name="reference"
                    value={reference}
                    onChange={this.handleFormChange}
                    isInvalid={!!errors.reference}
                    disabled
                  />
                  <Form.Control.Feedback type="invalid">
                    {errors.reference}
                  </Form.Control.Feedback>
                </InputGroup>
              ) : (
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
              )}

            </Form.Group>

            <Form.Group as={Col}>
              <Form.Label>Label</Form.Label>
              <InputGroup>
                <Form.Control
                  type="text"
                  aria-describedby="inputGroupPrepend"
                  name="label_en"
                  value={label_en}
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
            <Form.Group as={Col} controlId="formGridState">
              <Form.Label>Operator</Form.Label>
              <Form.Control as="select" name="operator" onChange={this.handleFormChange} defaultValue={operator} isInvalid={!!errors.operator}>
                <option value="">Select a category</option>
                {Object.keys(answersOperators).map(function(key) {
                  return <option value={answersOperators[key]}>{key}</option>;
                })}
              </Form.Control>
              <Form.Control.Feedback type="invalid">
                {errors.operator}
              </Form.Control.Feedback>
            </Form.Group>

            <Form.Group as={Col}>
              <Form.Label>Value</Form.Label>
              <InputGroup>
                <Form.Control
                  type="text"
                  rows="3"
                  name="value"
                  width="100%"
                  value={value}
                  onChange={this.handleFormChange}
                  isInvalid={!!errors.value}
                />
                <Form.Control.Feedback type="invalid">
                  {errors.value}
                </Form.Control.Feedback>
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
