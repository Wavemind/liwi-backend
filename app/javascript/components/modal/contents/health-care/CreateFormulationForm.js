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
    this.forceUpdate(); // Since there is no more state component does not rerender itself. I force it to make the form work. TODO better way to do so
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

          <div>
            <Form.Row>
              <Form.Group as={Col}>
                <Form.Label>Minimal dose per kg</Form.Label>
                <InputGroup>
                  <Form.Control
                    type="number"
                    name="minimalDosePerKg"
                    value={minimalDosePerKg}
                    onChange={this.updateState}
                  />
                </InputGroup>
              </Form.Group>
            </Form.Row>

            <Form.Row>
              <Form.Group as={Col}>
                <Form.Label>Maximal dose per kg</Form.Label>
                <InputGroup>
                  <Form.Control
                    type="number"
                    name="maximalDosePerKg"
                    value={maximalDosePerKg}
                    onChange={this.updateState}
                  />
                </InputGroup>
              </Form.Group>
            </Form.Row>

            <Form.Row>
              <Form.Group as={Col}>
                <Form.Label>Maximal dose</Form.Label>
                <InputGroup>
                  <Form.Control
                    type="number"
                    name="maximalDose"
                    value={maximalDose}
                    onChange={this.updateState}
                  />
                </InputGroup>
              </Form.Group>
            </Form.Row>

            <Form.Row>
              <Form.Group as={Col}>
                <Form.Label>Doses per day</Form.Label>
                <InputGroup>
                  <Form.Control
                    type="number"
                    name="dosesPerDay"
                    value={dosesPerDay}
                    onChange={this.updateState}
                  />
                </InputGroup>
              </Form.Group>
            </Form.Row>

            <Form.Row>
              <Form.Group as={Col} controlId="stage">
                <Form.Label>Drug form</Form.Label>
                <Form.Control as="select" name="medicationForm" onChange={this.updateState} value={medicationForm}>
                  <option value="">Select the stage</option>
                  {Object.keys(medicationForms).map(function(key) {
                    return <option value={medicationForms[key]}>{key.charAt(0).toUpperCase() + key.slice(1)}</option>;
                  })}
                </Form.Control>
                <Form.Control.Feedback type="invalid">
                  {errors.medication_form}
                </Form.Control.Feedback>
              </Form.Group>
            </Form.Row>

            <Form.Row>
              <Form.Group as={Col}>
                <Form.Label>Pill size</Form.Label>
                <InputGroup>
                  <Form.Control
                    type="number"
                    name="pillSize"
                    value={pillSize}
                    onChange={this.updateState}
                  />
                </InputGroup>
              </Form.Group>
            </Form.Row>
          </div>

          <Form.Row>


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
