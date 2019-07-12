import React from "react";
import { withDiagram } from "../../context/Diagram.context";

/**
 * @author Quentin Girard
 * Toolbar of available button
 */
class Toolbar extends React.Component {

  constructor(props) {
    super(props);
    this.state = {
      isLoading: false
    };
  }

  // Button to open modal with new final diagnostic node form
  newFinalDiagnostic = () => {
    const { set } = this.props;
    set("modalToOpen", "CreateFinalDiagnostic");
    set("modalIsOpen", true);
  };

  // Button to open modal with new predefined syndrome node form
  newQuestionsSequence = () => {
    const { set } = this.props;
    set("modalToOpen", "CreateQuestionsSequence");
    set("modalIsOpen", true);
  };

  // Button to open modal with new predefined syndrome node form
  newQuestion = () => {
    const { set } = this.props;
    set("modalToOpen", "CreateQuestion");
    set("modalIsOpen", true);
  };

  newHealthCare = (type) => {
    const { set } = this.props;
    set("currentHealthCareType", type);
    set("modalToOpen", "CreateHealthCare");
    set("modalIsOpen", true);
  };

  // Launch validation of diagram and display flash message
  validate = async () => {
    const {
      http,
      addMessage,
      type,
    } = this.props;

    let response;
    this.setState({ isLoading: true });

    if (type === "Diagnostic") {
      response = await http.validateDiagnostic();
    } else {
      response = await http.validateQuestionsSequence();
    }

    let message = {
      status: response.status,
      messages: response.messages
    };
    await addMessage(message);
    this.setState({ isLoading: false });
  };

  redirectToDiagnostic = () => {
    const { http } = this.props;
    http.redirectToDiagnosticDiagram();
  };

  // Close and redirect user to list of...
  save = async () => {
    const { http, type, instanceable } = this.props;
    if (type === "Diagnostic") {
      await http.redirectToDiagnostic();
    } else {
      let panel = instanceable.category_name === "scored" ? "questions_sequences_scored" : "questions_sequences";
      await http.redirectToAlgorithm(panel);
    }
  };

  render() {
    const { type } = this.props;
    const { isLoading } = this.state;

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
                <a className="dropdown-item" href="#" onClick={this.newQuestion}>Question</a>
                <a className="dropdown-item" href="#" onClick={this.newQuestionsSequence}>Questions Sequence</a>
                {type === "Diagnostic" ? (
                  <a className="dropdown-item" href="#" onClick={this.newFinalDiagnostic}>Final diagnostic</a>) : null}
                {type === "FinalDiagnostic" ? (<a className="dropdown-item" href="#"
                                                  onClick={() => this.newHealthCare("treatments")}>Treatment</a>) : null}
                {type === "FinalDiagnostic" ? (<a className="dropdown-item" href="#"
                                                  onClick={() => this.newHealthCare("managements")}>Management</a>) : null}
              </div>
            </div>
          </div>
          <div className="col text-right">
            {type === "Diagnostic" || type === "QuestionsSequence" ? (
              <button type="button" className="btn btn-transparent" onClick={this.validate}>
                {isLoading ?
                  <span>Loading</span> : <span>Validate</span>
                }
              </button>
            ) : null}
            {type === "FinalDiagnostic" ? (
              <button type="button" className="btn btn-transparent" onClick={this.redirectToDiagnostic}>
                Diagnostic diagram
              </button>
            ) : (
              <button type="button" className="btn btn-transparent" onClick={this.save}>
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
