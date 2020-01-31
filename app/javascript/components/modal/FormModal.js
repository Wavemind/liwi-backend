import React from "react";
import { Modal } from "react-bootstrap";
import { withDiagram } from "../../context/Diagram.context";
import InsertScoreForm from "./contents/InsertScoreForm";
import UpdateScoreForm from "./contents/UpdateScoreForm";
import CreateFinalDiagnosticForm from "./contents/final-diagnostic/CreateFinalDiagnosticForm";
import UpdateFinalDiagnosticForm from "./contents/final-diagnostic/UpdateFinalDiagnosticForm";
import CreateQuestionsSequenceForm from './contents/questions-sequence/CreateQuestionsSequenceForm';
import UpdateQuestionsSequenceForm from './contents/questions-sequence/UpdateQuestionsSequenceForm';
import CreateQuestionForm from './contents/question/CreateQuestionForm';
import UpdateQuestionForm from './contents/question/UpdateQuestionForm';
import CreateHealthCareForm from './contents/health-care/CreateHealthCareForm';
import UpdateHealthCareForm from './contents/health-care/UpdateHealthCareForm';
import AnswersContainer from "./contents/question/AnswersContainer";

class FormModal extends React.Component {
  constructor(props) {
    super(props);
  }

  static defaultProps = {
    modalIsOpen: false
  };

  state = {
    instance: {
      conditions: null
    },
    availableConditions: [],
    operators: []
  };

  async shouldComponentUpdate(nextProps, nextState) {
    return nextProps.modalIsOpen;
  }

  toggleModal = async () => {
    const { set, modalIsOpen } = this.props;
    await set("modalIsOpen", !modalIsOpen);
  };

  render() {
    const { modalIsOpen, modalToOpen } = this.props;
    return (
      modalIsOpen ? (
        <Modal show={true} size="lg" onHide={() => {return false;}}>
          {(() => {
            switch(modalToOpen) {
              case 'InsertScore':
                return <InsertScoreForm toggleModal={this.toggleModal} />;
              case 'UpdateScore':
                return <UpdateScoreForm toggleModal={this.toggleModal} />;
              case 'CreateFinalDiagnostic':
                return <CreateFinalDiagnosticForm toggleModal={this.toggleModal} />;
              case 'UpdateFinalDiagnostic':
                return <UpdateFinalDiagnosticForm toggleModal={this.toggleModal} />;
              case 'CreateQuestionsSequence':
                return <CreateQuestionsSequenceForm toggleModal={this.toggleModal} />;
              case 'UpdateQuestionsSequence':
                return <UpdateQuestionsSequenceForm toggleModal={this.toggleModal} />;
              case 'CreateHealthCare':
                return <CreateHealthCareForm toggleModal={this.toggleModal} />;
              case 'UpdateHealthCare':
                return <UpdateHealthCareForm toggleModal={this.toggleModal} />;
              case 'CreateQuestion':
                return <CreateQuestionForm toggleModal={this.toggleModal} />;
              case 'UpdateQuestion':
                return <UpdateQuestionForm toggleModal={this.toggleModal} />;
              case 'CreateAnswers': case 'UpdateAnswers':
                return <AnswersContainer toggleModal={this.toggleModal} />;
              default:
                return null;
            }
          })()}
        </Modal>
      ) : null
    );
  }
}

export default withDiagram(FormModal);
