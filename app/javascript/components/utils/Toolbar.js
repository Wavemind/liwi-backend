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
    set('modalToOpen', 'CreateFinalDiagnostic');
    set('modalIsOpen', true)
  };

  // Button to open modal with new predefined syndrome node form
  newPredefinedSyndrome = () => {
    const { set } = this.props;
    set('modalToOpen', 'CreatePredefinedSyndrome');
    set('modalIsOpen', true)
  };

  // Launch validation of diagram and display flash message
  validate = async () => {
    const {
      http,
      addMessage,
      type,
    } = this.props;

    let response;
    this.setState({isLoading: true});

    if (type === 'Diagnostic') {
      response = await http.validateDiagnostic();
    } else {
      response = await http.validatePredefinedSyndromeScored();
    }

    let message = {
      status: response.status,
      messages: response.messages,
    };
    await addMessage(message);
    this.setState({isLoading: false})
  };

  // Close and redirect user to list of...
  save = async () => {
    const { http, type, instanceable } = this.props;
    if (type === 'Diagnostic') {
      await http.redirectToDiagnostic();
    } else {
      let panel = instanceable.category.id === 8 ? 'predefined_syndromes_scored' : 'predefined_syndromes';
      await http.redirectToAlgorithm(panel);
    }
  };

  render() {
    const { isLoading } = this.state;
    const { type } = this.props;

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
                <a className="dropdown-item" href="#" onClick={() => {this.newPredefinedSyndrome()}}>Predefined Syndrome</a>
                <a className="dropdown-item" href="#">Predefined Syndrome Scored</a>
                <a className="dropdown-item" href="#">Question</a>
                {type === 'Diagnostic' ? (<a className="dropdown-item" href="#" onClick={() => {this.newFinalDiagnostic()}}>Final diagnostic</a>) : null}
                {type === 'FinalDiagnostic' ? (<a className="dropdown-item" href="#">Treatment / Management</a>) : null}
              </div>
            </div>
          </div>
          <div className="col text-right">
            {type === 'Diagnostic' || type === "PredefinedSyndrome" ? (
            <button type="button" className="btn btn-transparent" onClick={() => {this.validate()}}>
              {isLoading ?
                <span>Loading</span>: <span>Validate</span>
              }
            </button>
              ) : null }
            <button type="button" className="btn btn-transparent" onClick={() => {this.save()}}>
              Save
            </button>
          </div>
        </div>
      </div>
    );
  }
}

export default withDiagram(Toolbar);
