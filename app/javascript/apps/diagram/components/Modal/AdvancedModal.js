import * as React from "react";
import { Modal, Button } from "react-bootstrap";

import store from "../../engine/reducers/store";
import { closeModal } from "../../engine/reducers/creators.actions";

export default class AdvancedModal extends React.Component {

  closeModal = () => {
    const state$ = store.getState();

    store.dispatch(
      closeModal()
    );
  };

  render() {
    const {
      state: {
        modal: {
          open,
          title,
          content
        }
      }
    } = this.props;

    return (
      <Modal show={open} onHide={() => this.closeModal()}>
        <Modal.Header closeButton>
          <Modal.Title>{title}</Modal.Title>
        </Modal.Header>
        <Modal.Body>{content}</Modal.Body>
      </Modal>
    );
  }
}
