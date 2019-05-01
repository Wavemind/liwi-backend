import React from 'react';
import {
  Button,
  Modal,
} from 'react-bootstrap';
import { withDiagram } from '../context/Diagram.context';
import Http from '../http';

class FormModal extends React.Component {
  constructor(props) {
    super(props);
    this.state = {instance: {}};
  }

  async shouldComponentUpdate(nextProps, nextState) {
    if (nextProps.currentNodeId !== this.props.currentNodeId && nextProps.modalIsOpen) {
      const { currentNodeId } = nextProps;
      const http = new Http();
      let instance = await http.getInstanceConditions(currentNodeId);
      this.setState({instance});
      return true;
    }
    return false;
  }

  toggleModal = () => {
    const { set, modalIsOpen } = this.props;
    set('modalIsOpen', !modalIsOpen)
  };

  render() {
    const { modalIsOpen, currentNodeId } = this.props;

console.log(this.state)

    return (
      <Modal show={modalIsOpen} onHide={() => this.toggleModal()}>
        <Modal.Header closeButton>
          <Modal.Title>{currentNodeId}</Modal.Title>
        </Modal.Header>
        <Modal.Body>Woohoo, you're reading this text in a modal!</Modal.Body>
        <Modal.Footer>
          <Button variant="secondary" onClick={() => this.toggleModal()}>
            Close
          </Button>
          <Button variant="primary" onClick={() => this.toggleModal()}>
            Save Changes
          </Button>
        </Modal.Footer>
      </Modal>
    );
  }
}

export default withDiagram(FormModal);
