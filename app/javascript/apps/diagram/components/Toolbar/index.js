import React from "react";
import I18n from "i18n-js";
import store from "../../engine/reducers/store";
import { withDiagram } from "../../engine/context/Diagram.context";
import { openModal } from "../../engine/reducers/creators.actions";
import { NotificationManager } from "react-notifications";


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
   * Redirect to diagnostic diagram
   */
  redirectToDiagnosticDiagram() {
    const { http } = this.props;
    http.redirectToDiagnosticDiagram();
  }

  /**
   * Close and redirect user to list of...
   */
  save() {
    const { http, instanceable } = this.props;
    if (instanceable.type === "Diagnostic") {
      http.redirectToDiagnostic();
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

    if (instanceable.type === "Diagnostic") {
      httpRequest = await http.validateDiagnostic();
    } else {
      httpRequest = await http.validateQuestionsSequence();
    }

    let result = await httpRequest.json();

    if (httpRequest.status === 200) {
      NotificationManager.info(result);
    } else {
      NotificationManager.error(result);
    }

    this.setState({ isLoading: false });
  };

  render() {
    const { instanceable } = this.props;
    const { isLoading } = this.state;

    return (
      <div className="col-md-12 liwi-toolbar">
        <div className="row">
          <div className="col">
            <div className="btn-group">
              <button key="new" type="button" className="btn btn-transparent" data-toggle="dropdown"
                      aria-haspopup="true" aria-expanded="false">
                {I18n.t("toolbar.new")}
              </button>
              <div className="dropdown-menu">
                <a className="dropdown-item" key="questions" href="#">{I18n.t("toolbar.question")}</a>
                <a className="dropdown-item" key="questionsSequence" href="#">{I18n.t("toolbar.questions_sequence")}</a>
                {instanceable.type === "Diagnostic" ? (
                  <a className="dropdown-item" key="finalDiagnostic" href="#"
                     onClick={() => this.createNode(I18n.t("final_diagnostics.new.title"), "FinalDiagnosticForm")}>{I18n.t("toolbar.final_diagnostic")}</a>) : null}
                {instanceable.type === "FinalDiagnostic" ? ([
                    <a className="dropdown-item" key="drug" href="#">{I18n.t("toolbar.drug")}</a>,
                    <a className="dropdown-item" key="management" href="#">{I18n.t("toolbar.management")}</a>])
                  : null}
              </div>
            </div>
          </div>

          <div className="col text-right">
            {instanceable.type === "Diagnostic" || instanceable.type === "QuestionsSequence" ? (
              <button key="validate" type="button" className="btn btn-transparent" disabled={isLoading}
                      onClick={() => this.validate()}>
                <span>{isLoading ? "Loading" : I18n.t("toolbar.validate")}</span>
              </button>
            ) : null}
            {instanceable.type === "FinalDiagnostic" ? (
              <button key="diagnosticDiagram" type="button" className="btn btn-transparent"
                      onClick={() => this.redirectToDiagnosticDiagram()}>
                {I18n.t("toolbar.diagnostic_diagram")}
              </button>
            ) : (
              <button key="save" type="button" className="btn btn-transparent" onClick={() => this.save()}>
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
