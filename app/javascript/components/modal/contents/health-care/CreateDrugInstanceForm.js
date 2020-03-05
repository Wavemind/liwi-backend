import React from "react";
import {
  Button,
  Modal,
  Form, Col, InputGroup
} from "react-bootstrap";
import { withDiagram } from "../../../../context/Diagram.context";

/**
 * @author Emmanuel Barchichat
 * Modal content to define the score in QS scored
 */
class CreateDrugInstanceForm extends React.Component {
  constructor(props) {
    super(props);

    const { currentDbNode } = this.props;

    this.state = {
      duration: null,
      description: currentDbNode.description_translations['en']
    };
  }

  // Set the score props from input, so it triggers listener in Diagram.js and execute http request
  save = async () => {
    const {
      http,
      toggleModal,
      currentDbNode,
      set,
      setDrugInstance
    } = this.props;

    const {
      duration,
      description
    } = this.state;

    let result = await http.createHealthCareInstance(currentDbNode.id, duration, description);
    if (result.ok === undefined || result.ok) {
      setDrugInstance(result);
      set('modalToOpen', 'CreateDrugInstanceCompleted');
      toggleModal();
    } else {

      let newErrors = {};
      if (result.errors.duration !== undefined) {
        newErrors.duration = result.errors.duration[0];
      }
      this.setState({ errors: newErrors });
    }
  };

  // Set state for the input changes
  updateState = (event) => {
    this.setState({ [event.target.name]: event.target.value });
  };

  render() {
    const {
      duration,
      description
    } = this.state;

    const {
      currentDbNode,
      getReferencePrefix,
      toggleModal
    } = this.props;

    return (
      <Form onSubmit={this.save}>
        <Modal.Header>
          <Modal.Title>Create a treatment for drug : {getReferencePrefix(currentDbNode.node_type, currentDbNode.type) + currentDbNode.reference} - {currentDbNode.label_translations['en']}</Modal.Title>
        </Modal.Header>
        <Modal.Body>
          <Form.Row>
            <Form.Group as={Col}>
              <Form.Label>Treatment duration (in days)</Form.Label>
              <InputGroup>
                <Form.Control
                  type="number"
                  name="duration"
                  value={duration}
                  onChange={this.updateState}
                />
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
          <Button variant="primary" onClick={this.save}>
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

export default withDiagram(CreateDrugInstanceForm);
