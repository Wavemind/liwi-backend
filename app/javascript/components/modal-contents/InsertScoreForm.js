import React from "react";
import {
  Button,
  Modal,
  FormControl,
  Form
} from "react-bootstrap";
import {withDiagram} from "../../context/Diagram.context";

/**
 * @author Emmanuel Barchichat
 * Modal content to define the score in PS scored
 */
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

  // Set the score props from input, so it triggers listener in Diagram.js and execute http request
  createLink = async () => {
    const { set, toggleModal } = this.props;
    await set("currentScore", this.state.score);
    toggleModal();
  };

  // Close diagram and triggers listener in Diagram.js so it can delete the link (since the score has not been set)
  cancelLink = async () => {
    const { set, toggleModal } = this.props;
    await set("currentScore", null);
    toggleModal();
  };


  // Set state for the input changes
  handleScore = (event) => {
    this.setState({score: event.target.value});
  };

  render() {
    return (
      <Form onSubmit={() => this.createLink()}>
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
          <Button variant="primary" onClick={() => this.createLink()}>
            Save
          </Button>
          <Button variant="secondary" onClick={() => this.cancelLink()()}>
            Close
          </Button>
        </Modal.Footer>
      </Form>
    );
  }
}

export default withDiagram(InsertScoreForm);
