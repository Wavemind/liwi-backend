import React from "react";
import { withDiagram } from "../../engine/context/Diagram.context";


class Toolbar extends React.Component {

  constructor(props) {
    super(props);
  }

  render() {
    const { instanceable } = this.props;

    return (
      <div className="col-md-12 liwi-toolbar">
        <div className="row">
          <div className="col">
            <div className="btn-group">
              <button type="button" className="btn btn-transparent" data-toggle="dropdown"
                      aria-haspopup="true" aria-expanded="false">
                New
              </button>
              <div className="dropdown-menu">
                <a className="dropdown-item" href="#">Question</a>
                <a className="dropdown-item" href="#">Questions Sequence</a>
                {instanceable.type === "Diagnostic" ? (<a className="dropdown-item" href="#" >Final diagnostic</a>) : null}
                {instanceable.type === "FinalDiagnostic" ? (<a className="dropdown-item" href="#">Treatment</a>) : null}
                {instanceable.type === "FinalDiagnostic" ? (<a className="dropdown-item" href="#">Management</a>) : null}
              </div>
            </div>
          </div>

          <div className="col text-right">
            {instanceable.type === "Diagnostic" || instanceable.type === "QuestionsSequence" ? (
                <button type="button" className="btn btn-transparent">
                  <span>Validate</span>
                </button>
            ) : null}
            {instanceable.type === "FinalDiagnostic" ? (
              <button type="button" className="btn btn-transparent">
                Diagnostic diagram
              </button>
            ) : (
              <button type="button" className="btn btn-transparent">
                Save
              </button>
            )}
          </div>
        </div>
      </div>
    );
  }
}

export default withDiagram(Toolbar);
