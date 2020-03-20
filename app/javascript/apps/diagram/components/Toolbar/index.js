import React from "react";
import I18n from "i18n-js";
import store from "../../engine/reducers/store";
import { withDiagram } from "../../engine/context/Diagram.context";
import { openModal } from "../../engine/reducers/creators.actions";


class Toolbar extends React.Component {

  constructor(props) {
    super(props);
  }

  createNode(title, content) {
    const {engine, addAvailableNode} = this.props;
    store.dispatch(
      openModal(title, content, {
        engine,
        addAvailableNode,
        method: "create",
        from: "react",
      })
    );
  }

  render() {
    const { instanceable } = this.props;

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
                {instanceable.type === "Diagnostic" ? (<a className="dropdown-item" key="finalDiagnostic" href="#" onClick={() => this.createNode(I18n.t("final_diagnostics.new.title"), 'FinalDiagnosticForm')}>{I18n.t("toolbar.final_diagnostic")}</a>) : null}
                {instanceable.type === "FinalDiagnostic" ? (<a className="dropdown-item" key="treatment" href="#">{I18n.t("toolbar.treatment")}</a>) : null}
                {instanceable.type === "FinalDiagnostic" ? (<a className="dropdown-item" key="management" href="#">{I18n.t("toolbar.management")}</a>) : null}
              </div>
            </div>
          </div>

          <div className="col text-right">
            {instanceable.type === "Diagnostic" || instanceable.type === "QuestionsSequence" ? (
                <button key="validate" type="button" className="btn btn-transparent">
                  <span>{I18n.t("toolbar.validate")}</span>
                </button>
            ) : null}
            {instanceable.type === "FinalDiagnostic" ? (
              <button key="diagnosticDiagram" type="button" className="btn btn-transparent">
                {I18n.t("toolbar.diagnostic_diagram")}
              </button>
            ) : (
              <button key="save" type="button" className="btn btn-transparent">
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
