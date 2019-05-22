import React from "react";
import {
  Button,
  Modal,
  FormControl
} from "react-bootstrap";
import {withDiagram} from "../../context/Diagram.context";
import Diagram from "../Diagram";

class InsertScoreForm extends React.Component {
  constructor(props) {
    super(props);

    this.handleScore = this.handleScore.bind(this);
  }

  state = {
    score: '',
    scoreInput: null
  };

  componentWillUpdate() {
    this.scoreInput.focus();
  }

  updateScore = async () => {
    const { set, toggleModal } = this.props;
    await set("currentScore", this.state.score);
    toggleModal();
  };

  handleScore = (event) => {
    this.setState({score: event.target.value});
  };

  render() {
    return (
      <React.Fragment>
        <Modal.Header closeButton>
          <Modal.Title>Insert a score</Modal.Title>
        </Modal.Header>
        <Modal.Body>
          <FormControl
            placeholder="Score"
            type="number"
            value={this.state.score}
            onChange={this.handleScore}
            ref={(input) => { this.scoreInput = input; }}
          />
        </Modal.Body>
        <Modal.Footer>
          <Button variant="primary" onClick={() => this.updateScore()}>
            Update
          </Button>
          <Button variant="secondary" onClick={() => this.cancelLink()()}>
            Close
          </Button>
        </Modal.Footer>
      </React.Fragment>
    );
  }
}

export default withDiagram(InsertScoreForm);
