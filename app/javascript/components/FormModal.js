import React from "react";
import {
  Button,
  Modal,
} from "react-bootstrap";
import { withDiagram } from "../context/Diagram.context";

class FormModal extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      instance: {
        conditions: null
      },
      available_conditions: [],
      operators: []
    };
  }

  toggleModal = async () => {
    const { set, modalIsOpen } = this.props;
    await set("modalIsOpen", !modalIsOpen);
  };

  render() {
    const { modalIsOpen } = this.props;

    return (
      modalIsOpen ? (
        <Modal show={modalIsOpen} onHide={() => this.toggleModal()} size="lg">
          <Modal.Header closeButton>
            <Modal.Title>Modal title</Modal.Title>
          </Modal.Header>
          <Modal.Body>

          </Modal.Body>
          <Modal.Footer>
            <Button variant="secondary" onClick={() => this.toggleModal()}>
              Close
            </Button>
          </Modal.Footer>
        </Modal>
      ) : null
    );
  }
}

export default withDiagram(FormModal);
