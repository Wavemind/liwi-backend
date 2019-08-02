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
 * @author Emmanuel Barchichat
 * Container for the answers of a question
 */
class AnswersContainer extends React.Component {
  constructor(props) {
    super(props);

    this.buildAnswers = this.buildAnswers.bind(this);
  }

  state = {
    errors: {},
    answers: {},
    answerComponents: {}
  };

  componentWillMount() {
    this.buildAnswers();
  }

  // Add a new answer to the form
  newAnswer = async () => {
    let { answerComponents, answers } = this.state;
    let lastIndex = parseInt(Object.keys(answers)[Object.keys(answers).length-1]) + 1;
    answers[lastIndex] = {};
    answerComponents[lastIndex] = <CreateAnswerForm setAnswer={this.setAnswer} removeAnswer={this.removeAnswer} answers={answers} index={lastIndex} errors={{}} />;
    this.setState({ answerComponents, answers });
  };

  // Set general state of answers so the container can access to all of then
  setAnswer = (key, answer) => {
    let { answers } = this.state;
    answers[key] = answer;
    this.setState({ answers });
  };

  // Remove the selected answer
  removeAnswer = async (key) => {
    let { answerComponents, answers } = this.state;

    if (answers[key].id !== undefined){
      answers[key]._destroy = true;
    } else {
      answers[key] = null;
    }
    answerComponents[key] = null;

    await this.setState({ answers, answerComponents });
  };

  // Get question hash and add answers to it to finally create the whole question
  save = async () => {
    const {
      toggleModal,
      http,
      addMessage,
      set,
      currentQuestion
    } = this.props;
    let { answers, answerComponents } = this.state;

    Object.keys(answers).map(function(key) {
      if (answers[key] !== null){
        currentQuestion.question.answers_attributes[key] = answers[key];
      }
    });

    let result = currentQuestion.question.id === undefined ? await http.createQuestion(currentQuestion) : await http.updateQuestion(currentQuestion);
    if (result.ok === undefined || result.ok) {
      toggleModal();
      await addMessage({ status: result.status, messages: result.messages });
      set("currentDbNode", result.node);
    } else {

      let i = 0;
      Object.keys(answerComponents).map(function(key) {
        answerComponents[key] = React.cloneElement(answerComponents[key], {
          errors: result.errors[i]
        });
        i++;
      });

      let newErrors = {};
      if (result.errors.reference !== undefined) {
        newErrors.reference = result.errors.reference[0];
      }

      if (result.errors.label !== undefined) {
        newErrors.label = result.errors.label[0];
      }
      this.setState({ errors: newErrors, answerComponents });
    }
  };

  // Build the answers hashes, empty if this is a create form or with its answers if it is an update
  buildAnswers = () => {
    const { currentQuestion } = this.props;
    // If this is a question creation, set an empty hash of answers and a new form for answers
    if (currentQuestion.question.id === undefined) {
      this.setState({
        answers: {0: {}},
        answerComponents: {0: <CreateAnswerForm setAnswer={this.setAnswer} answers={{0: {}}} removeAnswer={this.removeAnswer} index={0} errors={{}} />}
      });
      // If this is a question updating, set answers form and answers hash
    } else {
      const { currentNode, answersOperators } = this.props;
      let answers = {};
      let answerComponents = {};
      let nodeAnswers = currentNode.answers === undefined ? currentNode.get_answers : currentNode.answers;
      // build answers
      nodeAnswers.map((answer, index) => {
        answers[index] = {
          id: answer.id,
          reference: answer.reference,
          label_en: answer.label_translations['en'],
          operator: answersOperators[answer.operator],
          value: answer.value,
          _destroy: false
        }
      });

      for (let i = 0; i < nodeAnswers.length; i++) {
        answerComponents[i] = <CreateAnswerForm setAnswer={this.setAnswer} answers={answers} removeAnswer={this.removeAnswer} index={i} errors={{}} update={true} />
      }

      this.setState({
        answers,
        answerComponents
      });
    }
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
          {Object.keys(answerComponents).map((key) => {
            return <React.Fragment> { answerComponents[key] }</React.Fragment>
          })}
        </Modal.Body>
        <Modal.Footer>
          <Button variant="primary" onClick={() => this.newAnswer()}>
            New answer
          </Button>
          <Button variant="success" onClick={() => this.save()}>
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
