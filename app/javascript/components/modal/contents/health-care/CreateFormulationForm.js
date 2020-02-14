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
class CreateFormulationForm extends React.Component {
  constructor(props) {
    super(props);
  }

  // Push the answer object to the container
  handleFormChange = () => {
    const value = event.target.value;
    const name = event.target.name;

    const {
      index
    } = this.props;

    this.forceUpdate(); // Since there is no more state component does not rerender itself. I force it to make the form work. TODO better way to do so
  };

  render() {
    const {
      index,
      minimal_dose_per_kg,
      update,
      errors
    } = this.props;

    let prefix = '';

    return (
      <Form onSubmit={() => this.create()}>
        <Modal.Body>

          <Form.Row>
            <Form.Group as={Col}>
              <Form.Label>Label</Form.Label>
              <InputGroup>
                <Form.Control
                  type="text"
                  aria-describedby="inputGroupPrepend"
                  name="label_en"
                  value={minimal_dose_per_kg}
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

export default withDiagram(CreateFormulationForm);
