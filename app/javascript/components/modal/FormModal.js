import React from "react";
import { Modal } from "react-bootstrap";
import { withDiagram } from "../../context/Diagram.context";
import InsertScoreForm from "./contents/InsertScoreForm";
import UpdateScoreForm from "./contents/UpdateScoreForm";
import CreateFinalDiagnosticForm from "./contents/CreateFinalDiagnosticForm";

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
        <Modal show={true} size="sm">
          {(() => {
            switch(modalToOpen) {
              case 'InsertScore':
                return <InsertScoreForm toggleModal={this.toggleModal} />;
              case 'UpdateScore':
                return <UpdateScoreForm toggleModal={this.toggleModal} />;
              case 'CreateFinalDiagnostic':
                return <CreateFinalDiagnosticForm toggleModal={this.toggleModal} />;
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
