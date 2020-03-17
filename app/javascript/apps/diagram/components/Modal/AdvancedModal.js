import * as React from "react";
import { Modal } from "react-bootstrap";

import store from "../../engine/reducers/store";
import { closeModal } from "../../engine/reducers/creators.actions";

import UpdateScoreForm from "../form/updateScoreForm";


export default class AdvancedModal extends React.Component {

  closeModal = () => {
    store.dispatch(
      closeModal()
    );
  };

  getContent = () => {
    const {
      state: {
        modal: {
          content,
          params
        }
      }
    } = this.props;

    switch (content) {
      case "UpdateScoreForm":
        return <UpdateScoreForm answerId={params.answerId} instanceId={params.instanceId}/>;
      default:
        console.log("Action exist pas");
        return null;
    }
  };

  render() {
    const {
      state: {
        modal: {
          open,
          title,
        }
      }
    } = this.props;

    if (!open) {
      return null
    }

    return (
      <Modal show={open} onHide={() => this.closeModal()}>
        <Modal.Header closeButton>
          <Modal.Title>{title}</Modal.Title>
        </Modal.Header>
        <Modal.Body>
          {this.getContent()}
        </Modal.Body>
      </Modal>
    );
  }
}
