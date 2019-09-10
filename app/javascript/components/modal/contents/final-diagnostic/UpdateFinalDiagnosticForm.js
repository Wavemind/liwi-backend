import React from "react";
import {
  Button,
  Modal,
  Form,
  InputGroup,
  Col, FormControl
} from "react-bootstrap";
import * as _ from 'lodash';
import { withDiagram } from "../../../../context/Diagram.context";

/**
 * @author Quentin Girard
 * Modal content to update a final diagnostic
 */
class UpdateFinalDiagnosticForm extends React.Component {
  constructor(props) {
    super(props);
  }

  state = {
    id: null,
    reference: null,
    label: null,
    description: null,
    final_diagnostic_id: null,
    errors: {},
  };

  componentWillMount() {
    const { currentNode } = this.props;
    const newCurrentNode = _.cloneDeep(currentNode);

    this.setState({
      id: newCurrentNode.id,
      reference: newCurrentNode.reference,
      label: newCurrentNode.label_translations["en"],
      description: newCurrentNode.description_translations === null ? '' : newCurrentNode.description_translations["en"],
      final_diagnostic_id: newCurrentNode.final_diagnostic_id
    });
  }

  // Update the score in DB then set score props in order to trigger listener in Diagram.js that will update diagram dynamically
  update = async () => {
    const {
      toggleModal,
      http,
      addMessage,
      set
    } = this.props;

    const {
      id,
      reference,
      label,
      description,
      final_diagnostic_id
    } = this.state;

    let result = await http.updateFinalDiagnostic(id, reference, label, description, final_diagnostic_id);
    if (result.ok === undefined || result.ok) {
      toggleModal();
      await addMessage({ status: result.status, messages: result.messages });
      set("currentDbNode", result.node);
    } else {
      let newErrors = {};
      if (result.errors.reference !== undefined) {
        newErrors.reference = result.errors.reference[0];
      }

      if (result.errors.label_en !== undefined) {
        newErrors.label_en = result.errors.label_en[0];
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
    const { toggleModal } = this.props;
    const {
      reference,
      label,
      description,
      errors
    } = this.state;

    return (
      <Form onSubmit={this.create}>
        <Modal.Header>
          <Modal.Title>Update a final diagnostic</Modal.Title>
        </Modal.Header>
        <Modal.Body>
          <Form.Row>
            <Form.Group as={Col}>
              <Form.Label>Reference</Form.Label>
              <InputGroup>
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
                  onChange={this.updateState}
                />
              </InputGroup>
            </Form.Group>
          </Form.Row>

        </Modal.Body>
        <Modal.Footer>
          <Button variant="primary" onClick={this.update}>
            Save
          </Button>
          <Button variant="secondary" onClick={toggleModal}>
            Close
          </Button>
        </Modal.Footer>
      </Form>
    );
  }
}

export default withDiagram(UpdateFinalDiagnosticForm);
