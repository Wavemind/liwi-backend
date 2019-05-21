import React from "react";
import {
  Button,
  Modal,
  FormControl
} from "react-bootstrap";
import {withDiagram} from "../../context/Diagram.context";
import Diagram from "../Diagram";

class ScoreForm extends React.Component {
  constructor(props) {
    super(props);

    this.handleScore = this.handleScore.bind(this);
  }

  state = {
    score: ''
  };

  createLink = async () => {
    const { set, toggleModal } = this.props;
    await set("currentScore", this.state.score);
    toggleModal();
  };

  cancelLink = async () => {
    const { set, toggleModal } = this.props;
    await set("currentScore", null);
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
          />
        </Modal.Body>
        <Modal.Footer>
          <Button variant="primary" onClick={() => this.createLink()}>
            Save
          </Button>
          <Button variant="secondary" onClick={() => this.cancelLink()()}>
            Close
          </Button>
        </Modal.Footer>
      </React.Fragment>
    );
  }
}

export default withDiagram(ScoreForm);
