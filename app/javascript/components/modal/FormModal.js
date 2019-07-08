import React from "react";
import { Modal } from "react-bootstrap";
import { withDiagram } from "../../context/Diagram.context";
import InsertScoreForm from "./contents/InsertScoreForm";
import UpdateScoreForm from "./contents/UpdateScoreForm";
import CreateFinalDiagnosticForm from "./contents/final-diagnostic/CreateFinalDiagnosticForm";
import UpdateFinalDiagnosticForm from "./contents/final-diagnostic/UpdateFinalDiagnosticForm";
import CreateQuestionsSequenceForm from './contents/questions-sequence/CreateQuestionsSequenceForm';
import UpdateQuestionsSequenceForm from './contents/questions-sequence/UpdateQuestionsSequenceForm';
import CreateHealthCareForm from './contents/health-care/CreateHealthCareForm';
import UpdateHealthCareForm from './contents/health-care/UpdateHealthCareForm';

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
        <Modal show={true} size="md" onHide={() => {return false;}}>
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
