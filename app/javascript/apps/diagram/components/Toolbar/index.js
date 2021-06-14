import React from "react";
import I18n from "i18n-js";
import store from "../../engine/reducers/store";
import { withDiagram } from "../../engine/context/Diagram.context";
import { openModal } from "../../engine/reducers/creators.actions";
import { NotificationManager } from "react-notifications";
import ReactHtmlParser from "react-html-parser";
import * as _ from "lodash";


class Toolbar extends React.Component {

  constructor(props) {
    super(props);

    this.state = {
      isLoading: false
    };
  }

  /**
   * open modal to create a node
   * @params [String] title
   * @params [String] content
   */
  createNode(title, content) {
    const { engine, addAvailableNode } = this.props;

    // Remove focus from entities before opening the modal so the text editing (backspace and delete buttons) would not remove them
    _.forEach(engine.getModel().getSelectedEntities(), entity => {
      entity.options.selected = false;
    });

    store.dispatch(
      openModal(title, content, {
        engine,
        addAvailableNode,
        method: "create",
        from: "react"
      })
    );
  }

  /**
   * Redirect to diagnosis diagram
   */
  redirectToDiagnosisDiagram() {
    const { http } = this.props;
    http.redirectToDiagnosisDiagram();
  }

  /**
   * Close and redirect user to list of...
   */
  save() {
    const { http, instanceable } = this.props;
    if (instanceable.type === "Diagnosis") {
      http.redirectToDiagnosis();
    } else {
      let panel = instanceable.category_name === "scored" ? "questions_sequences_scored" : "questions_sequences";
      http.redirectToAlgorithm(panel);
    }
  }

  /**
   * Validate current diagram
   */
  validate = async () => {
    const { instanceable, http } = this.props;
    let httpRequest = {};
    this.setState({ isLoading: true });

    if (instanceable.type === "Diagnosis") {
      httpRequest = await http.validateDiagnosis();
    } else {
      httpRequest = await http.validateQuestionsSequence();
    }

    let result = await httpRequest.json();

    if (httpRequest.status === 200) {
      NotificationManager.info(result);
    } else if (httpRequest.status === 202) {
      result.map(error => (
        NotificationManager.warning(ReactHtmlParser(error), "", 10000)
      ));
    } else {
      result.map(error => (
        NotificationManager.error(ReactHtmlParser(error), "", 10000)
      ));
    }

    this.setState({ isLoading: false });
  };

  render() {
    const { instanceable, readOnly } = this.props;
    const { isLoading } = this.state;

    return (
      <div className="col-md-12 liwi-toolbar">
        <div className="row">
          <div className="col">
            <div className="btn-group">
              <button key="new" type="button" className="btn btn-transparent" data-toggle="dropdown"
                      aria-haspopup="true" aria-expanded="false" disabled={readOnly}>
                {I18n.t("toolbar.new")}
              </button>
              <div className="dropdown-menu">
                <a className="dropdown-item" key="questions" href="#"
                   onClick={() => this.createNode(I18n.t("questions.new.title"), "QuestionForm")}>{I18n.t("toolbar.question")}</a>
                <a className="dropdown-item" key="questionsSequence" href="#"
                   onClick={() => this.createNode(I18n.t("questions_sequences.new.title"), "QuestionsSequenceForm")}>{I18n.t("toolbar.questions_sequence")}</a>
                {instanceable.type === "Diagnosis" ? (
                  <a className="dropdown-item" key="finalDiagnosis" href="#"
                     onClick={() => this.createNode(I18n.t("final_diagnoses.new.title"), "FinalDiagnosisForm")}>{I18n.t("toolbar.final_diagnosis")}</a>) : null}
                {instanceable.type === "FinalDiagnosis" ? ([
                  <a className="dropdown-item" key="drug" href="#"
                     onClick={() => this.createNode(I18n.t("drugs.new.title"), "DrugForm")}>{I18n.t("toolbar.drug")}</a>,
                  <a className="dropdown-item" key="management" href="#"
                     onClick={() => this.createNode(I18n.t("managements.new.title"), "ManagementForm")}>{I18n.t("toolbar.management")}</a>])
                : null}
              </div>
            </div>
          </div>
          {instanceable.type !== "QuestionsSequence" ? (
            <span className="mt-2 btn-transparent">{instanceable.chief_complaint_label}</span>
          ) : null}

          <div className="col text-right">
            {instanceable.type === "Diagnosis" || instanceable.type === "QuestionsSequence" ? (
              <button key="validate" type="button" className="btn btn-transparent" disabled={isLoading || readOnly}
                      onClick={() => this.validate()}>
                <span>{isLoading ? "Loading" : I18n.t("toolbar.validate")}</span>
              </button>
            ) : null}
            {instanceable.type === "FinalDiagnosis" ? (
              <button key="diagnosisDiagram" type="button" className="btn btn-transparent"
                      onClick={() => this.redirectToDiagnosisDiagram()} disabled={readOnly}>
                {I18n.t("toolbar.diagnosis_diagram")}
              </button>
            ) : (
              <button key="save" type="button" className="btn btn-transparent" onClick={() => this.save()} disabled={readOnly}>
                {I18n.t("toolbar.save")}
              </button>
            )}
          </div>
        </div>
      </div>
    );
  }
}

export default withDiagram(Toolbar);
