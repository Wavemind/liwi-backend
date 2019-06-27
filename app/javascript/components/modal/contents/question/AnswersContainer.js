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
import CreateAnswerForm from "./CreateAnswerForm";

/**
 * @author Quentin Girard
 * Modal content to create a predefined syndrome
 */
class AnswersContainer extends React.Component {
  constructor(props) {
    super(props);

  }

  newAnswer = async () => {
    let { answerComponents } = this.state;
    answerComponents.push(<CreateAnswerForm setAnswer={this.setAnswer} index={answerComponents.length} />);
    this.setState({ answerComponents });
  };

  setAnswer = (key, answer) => {
    let { answers } = this.state;
    answers[key] = answer;
    this.setState({ answers });
  };

  create = async () => {
    let { currentQuestion, http } = this.props;
    const { answers } = this.state;

    Object.keys(answers).map(function(key) {
      currentQuestion.question.answers_attributes[key] = answers[key];
    });

    let result = await http.createQuestion(currentQuestion);
    if (result.ok === undefined || result.ok) {
      toggleModal();
      await addMessage({ status: result.status, messages: result.messages });
      set("currentDbNode", result.node);
    } else {
      let newErrors = {};
      if (result.errors.reference !== undefined) {
        newErrors.reference = result.errors.reference[0];
      }

      if (result.errors.label !== undefined) {
        newErrors.label = result.errors.label[0];
      }
      this.setState({ errors: newErrors });
    }
  };

  state = {
    errors: {},
    answerComponents: [<CreateAnswerForm setAnswer={this.setAnswer} index={0} />],
    answers: []
  };

  render() {
    const {
      toggleModal,
    } = this.props;

    const {
      answerComponents
    } = this.state;

    return (
      <Form onSubmit={() => this.create()}>
        <Modal.Header>
          <Modal.Title>Create answers</Modal.Title>
        </Modal.Header>
        <Modal.Body>
          {answerComponents.map((component, index) => (
            <React.Fragment key={index}>
              { component }
            </React.Fragment>
          ))}
        </Modal.Body>
        <Modal.Footer>
          <Button variant="primary" onClick={() => this.newAnswer()}>
            New answer
          </Button>
          <Button variant="success" onClick={() => this.create()}>
            Validate
          </Button>
          <Button variant="secondary" onClick={() => toggleModal()}>
            Close
          </Button>
        </Modal.Footer>
      </Form>
    );
  }
}

export default withDiagram(AnswersContainer);
