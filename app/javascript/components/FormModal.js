import React from "react";
import {
  Button,
  Modal,
} from "react-bootstrap";
import { withDiagram } from "../context/Diagram.context";
import ScoreForm from "./modal-contents/ScoreForm";

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

  componentWillReceiveProps(nextProps) {
    const { http } = this.props;
  }

  toggleModal = async () => {
    const { set, modalIsOpen } = this.props;
    await set("modalIsOpen", !modalIsOpen);
  };

  render() {
    const { modalIsOpen } = this.props;

    return (
      modalIsOpen ? (
        <Modal show={true} onHide={() => this.toggleModal()} size="sm">
          <ScoreForm toggleModal={this.toggleModal} />
        </Modal>
      ) : null
    );
  }
}

export default withDiagram(FormModal);
