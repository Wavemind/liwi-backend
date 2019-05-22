import React from "react";
import {
  Button,
  Modal,
  FormControl
} from "react-bootstrap";
import {withDiagram} from "../../context/Diagram.context";
import Diagram from "../Diagram";

class UpdateScoreForm extends React.Component {
  constructor(props) {
    super(props);

    this.handleScore = this.handleScore.bind(this);
  }

  state = {
    score: this.props.updatingScore,
    scoreInput: null
  };

  componentWillUpdate() {
    this.scoreInput.focus();
  }

  updateScore = async () => {
    const {
      set,
      toggleModal,
      http,
      currentAnswerId,
      currentNodeId,
      addMessage
    } = this.props;

    const {score} = this.state;
    toggleModal();
    let result = await http.updateConditionScore(currentAnswerId, currentNodeId, score);

    if (result.ok === undefined || result.ok) {
      await set("currentScore", score);
    } else {
      let message = {
        status: 'danger',
        message: [`An error occured: ${result.status} - ${result.statusText}`],
      };
      await addMessage(message);
    }
  }

  handleScore = (event) => {
    this.setState({score: event.target.value});
  };

  render() {
    const {toggleModal} = this.props;
    return (
      <React.Fragment>
        <Modal.Header closeButton>
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
          <Button variant="primary" onClick={() => this.updateScore()}>
            Update
          </Button>
          <Button variant="secondary" onClick={() => toggleModal()}>
            Close
          </Button>
        </Modal.Footer>
      </React.Fragment>
    );
  }
}

export default withDiagram(UpdateScoreForm);
