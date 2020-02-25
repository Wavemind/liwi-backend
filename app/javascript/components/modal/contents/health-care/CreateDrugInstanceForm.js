import React from "react";
import {
  Button,
  Modal,
  FormControl,
  Form, Col, InputGroup
} from "react-bootstrap";
import { withDiagram } from "../../../context/Diagram.context";

/**
 * @author Emmanuel Barchichat
 * Modal content to define the score in QS scored
 */
class CreateDrugInstanceForm extends React.Component {
  constructor(props) {
    super(props);
  }

  state = {
    duration: "",
    description: ""
  };

  componentDidMount() {
    const { currentDrug } = this.props;

    this.setState({description: currentDrug.description});
  }

  // Set the score props from input, so it triggers listener in Diagram.js and execute http request
  createLink = async () => {
    const { set, toggleModal } = this.props;
    const { score } = this.state;
    await set("currentScore", score);
    toggleModal();
  };

  // Close diagram and triggers listener in Diagram.js so it can delete the link (since the score has not been set)
  cancelLink = async () => {
    const { set, toggleModal } = this.props;
    await set("currentScore", null);
    toggleModal();
  };

  // Set state for the input changes
  updateState = (event) => {
    this.setState({ score: event.target.value });
  };

  render() {
    const {
      duration,
      description
    } = this.state;

    const {
      currentDrug,
      getReferencePrefix
    } = this.props;

    return (
      <Form onSubmit={this.create}>
        <Modal.Header>
          <Modal.Title>Create a treatment from drug {getReferencePrefix(currentDrug.node_type, currentDrug.type) + currentDrug.reference}</Modal.Title>
        </Modal.Header>
        <Modal.Body>
          <Form.Row>
            <Form.Group as={Col}>
              <Form.Label>Label</Form.Label>
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
      </Form>
    );
  }
}

export default withDiagram(CreateDrugInstanceForm);
