import React from "react";
import {
  Button,
  Modal,
  FormControl,
  Form
} from "react-bootstrap";
import { withDiagram } from "../../../../context/Diagram.context";

/**
 * @author Emmanuel Barchichat
 * Modal content to define the score in QS scored
 */
class UpdateDrugInstanceForm extends React.Component {
  constructor(props) {
    super(props);
  }

  state = {
    score: this.props.updatingScore,
    scoreInput: null
  };

  componentWillUpdate() {
    this.scoreInput.focus();
  }

  // Update the score in DB then set score props in order to trigger listener in Diagram.js that will update diagram dynamically
  updateScore = async () => {
    const {
      set,
      toggleModal,
      http,
      currentAnswerId,
      currentNode,
      addMessage
    } = this.props;

    const { score } = this.state;
    toggleModal();
    let result = await http.updateConditionScore(currentAnswerId, currentNode.id, score);

    if (result.ok === undefined || result.ok) {
      await set("currentScore", score);
    } else {
      let message = {
        status: "danger",
        messages: [`An error occured: ${result.status} - ${result.statusText}`]
      };
      await addMessage(message);
    }
  };

  // Set state for the input changes
  handleScore = (event) => {
    this.setState({ score: event.target.value });
  };

  render() {
    const { toggleModal } = this.props;
    return (
      <Form onSubmit={this.updateScore}>
        <Modal.Header>
          <Modal.Title>Update the score</Modal.Title>
        </Modal.Header>
        <Modal.Body>
          <FormControl
            placeholder="Score"
            type="number"
            value={this.state.score}
            onChange={this.handleScore}
            ref={(input) => {
              this.scoreInput = input;
            }}
          />
        </Modal.Body>
        <Modal.Footer>
          <Button variant="primary" onClick={this.updateScore}>
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

export default withDiagram(UpdateDrugInstanceForm);
