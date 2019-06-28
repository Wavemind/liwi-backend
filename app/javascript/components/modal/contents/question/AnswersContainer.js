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
    let { answerComponents, answers } = this.state;
    let lastIndex = parseInt(Object.keys(answers)[Object.keys(answers).length-1]) + 1;
    answers[lastIndex] = {};
    answerComponents[lastIndex] = <CreateAnswerForm setAnswer={this.setAnswer} removeAnswer={this.removeAnswer} answers={answers} index={lastIndex} />;
    this.setState({ answerComponents, answers });
  };

  setAnswer = (key, answer) => {
    let { answers } = this.state;
    answers[key] = answer;
    this.setState({ answers });
  };

  removeAnswer = async (key) => {
    let { answerComponents, answers } = this.state;
    answers[key] = null;
    answerComponents[key] = null;

    await this.setState({ answers, answerComponents });
  };

  create = async () => {
    const {
      toggleModal,
      http,
      addMessage,
      set,
      currentQuestion
    } = this.props;
    const { answers } = this.state;

    console.log(answers)
    Object.keys(answers).map(function(key) {
      if (answers[key] !== null){
        currentQuestion.question.answers_attributes[key] = answers[key];
      }
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
    answers: {0: {}},
    answerComponents: {0: <CreateAnswerForm setAnswer={this.setAnswer} answers={{0: {}}} removeAnswer={this.removeAnswer} index={0} />}
  };

  render() {
    const {
      toggleModal,
    } = this.props;

    const {
      answerComponents,
    } = this.state;

    return (
      <Form onSubmit={() => this.create()}>
        <Modal.Header>
          <Modal.Title>Create answers</Modal.Title>
        </Modal.Header>
        <Modal.Body>
          {Object.keys(answerComponents).map(function(key) {
            return <React.Fragment> { answerComponents[key] }</React.Fragment>
          })}
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
