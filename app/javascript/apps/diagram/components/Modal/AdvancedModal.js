import * as React from "react";
import { Modal } from "react-bootstrap";

import store from "../../engine/reducers/store";
import { closeModal } from "../../engine/reducers/creators.actions";

import ScoreForm from "../../../form/ScoreForm";
import DrugForm from "../../../form/DrugForm/stepper";
import FinalDiagnosticForm from "../../../form/FinalDiagnosticForm";
import QuestionsSequenceForm from "../../../form/QuestionsSequenceForm";
import StepperQuestionForm from "../../../form/QuestionForm/stepper";
import ManagementForm from "../../../form/ManagementForm";


export default class AdvancedModal extends React.Component {

  /**
   * Close modal by redux and remove diagramObject if we're un score and create method
   */
  closeModal = () => {
    const {
      state: {
        modal: {
          content,
          params
        }
      }
    } = this.props;

    if (content === "ScoreForm" && params.method === "create") {
      params.diagramObject.remove();
    }

    params.engine.repaintCanvas();

    store.dispatch(
      closeModal()
    );
  };

  /**
   * Display content defined by content parameters of props
   */
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
      case "ScoreForm":
        return <ScoreForm {...params} />;
      case "DrugForm":
        return <DrugForm {...params} />;
      case "FinalDiagnosticForm":
        return <FinalDiagnosticForm {...params} />;
      case "QuestionForm":
        return <StepperQuestionForm {...params} />;
      case "QuestionsSequenceForm":
        return <QuestionsSequenceForm {...params} />;
      case "ManagementForm":
        return <ManagementForm {...params} />;
      default:
        console.log("Action n'existe pas");
        return null;
    }
  };

  render() {
    const {
      state: {
        modal: {
          open,
          title
        }
      }
    } = this.props;

    if (!open) {
      return null;
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
