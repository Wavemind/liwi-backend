import React, { Component, Fragment } from 'react';
import {Form, Button} from "react-bootstrap";
import I18n from "i18n-js";
import parse from 'html-react-parser';

class AccessesComponent extends Component {
  constructor(props) {
    super(props);

    const { versions, current_health_facility_access } = props;
    const isGenerating = current_health_facility_access.version.job_id !== ""

    this.timer = null;
    this.state = {
      versions: versions,
      generating: isGenerating,
      validating: false,
      selectedVersion: "",
      message: "",
    };
    if (isGenerating) {
      this.timer = setInterval(() => this.checkStatus(), 10000);
    }
  };

  /**
   * Removes the interval timer if the user navigates away from the page
   */
  componentWillUnmount = () => {
    clearInterval(this.timer)
  }

  /**
   * Checks the status of the background job (JSON generation)
   * @returns {Promise<void>}
   */
  checkStatus = async () => {
    const { current_health_facility_access: {
      version
    }} = this.props;
    const response = await fetch(`${window.location.origin}/algorithms/${version.algorithm.id}/versions/${version.id}/job_status`, {method: "GET"})
      .catch((error) => {
        console.error(error);
      });
    const data = await response.json();
    if (['complete', 'failed', 'interrupted'].includes(data.job_status)) {
      clearInterval(this.timer);
      this.setState({
        generating: false,
        message: data.message
      })
    }
  }

  /**
   * Launches the validation and generation of the JSON
   * @returns {Promise<void>}
   */
  handleGenerate = async () => {
    const { current_health_facility_access: {
      version
    }} = this.props;

    this.setState({
      validating: true,
      message: "",
    })
    const url = `${window.location.origin}/algorithms/${version.algorithm.id}/versions/${version.id}/regenerate_json`;
    let header = {
      method: 'PUT',
      headers: {
        "Accept": "application/json, text/plain",
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector("meta[name='csrf-token']").content
      }
    };
    const response = await fetch(url, header).catch(error => console.log(error));
    const data = await response.json();
    if (data.success) {
      this.setState({
        validating: false,
        generating: true,
      })
      this.timer = setInterval(() => this.checkStatus(), 10000);
    } else {
      this.setState({
        validating: false,
        generating: false,
        message: data.message,
      })
    }
  }

  /**
   * TODO WE STILL NEED TO HANDLE WHATEVER THIS DOES
   * Handles the select change event
   * @param event
   */
  handleChange = (event) => {
    this.setState({
      selectedVersion: event.target.value,
    })
  }

  /**
   * Renders the correct message with the correct alert colour
   * @param message
   * @param alertType
   * @returns {JSX.Element}
   */
  renderMessage = (message, alertType) => {
    return (
      <div className={`alert alert-${alertType}`} role="alert">
        {message}
      </div>
    )
  }

  /**
   * Displays the generate button if no validation/generation is in progress
   * @returns {JSX.Element}
   */
  renderGenerateButton = () => {
    const { current_health_facility_access: {
      version
    }} = this.props;

    return (
      <div className="alert alert-info" role="alert">
        <div className="row">
          <div className="col">
            {parse(I18n.t('health_facilities.current_algorithm', {version_name: version.display_label}))}
          </div>
          <div className="col">
            <Button variant="primary" onClick={this.handleGenerate}>{I18n.t('health_facilities.show.generate_json')}</Button>
          </div>
        </div>
      </div>
    )
  }

  /**
   * Sets the correct message and alert colour before rendering the display
   * @returns {JSX.Element}
   */
  renderAlert = () => {
    let message = ""
    let alertType = ""
    if (this.props.current_health_facility_access === null) {
      message = I18n.t('health_facilities.show.no_algorithm')
      alertType = "danger"
    } else if (this.state.generating) {
      message = I18n.t('health_facilities.show.generating')
      alertType = "success"
    } else if (this.state.validating) {
      message = I18n.t('health_facilities.show.validating')
      alertType = "warning"
    } else {
      return this.renderGenerateButton();
    }
    return this.renderMessage(message, alertType)
  }

  render() {
    return (
      <div>
        <div className="row">
          <div className="col">
            {this.renderAlert()}
          </div>
          <div className="col">
            <Form>
              <div className="row">
                <div className="col">
                  <Form.Group controlId="versionSelect">
                    <Form.Control
                      as="select"
                      onChange={(event) => this.handleChange(event)}
                      value={this.state.selectedVersion}
                      disabled={this.state.generating || this.state.validating || this.props.current_health_facility_access === null}
                    >
                      <option value="">{I18n.t("prompt")}</option>
                      {this.state.versions.map((version) => (
                        <option key={`version-${version.name}`} value={version.id}>{version.name}</option>
                      ))}
                    </Form.Control>
                  </Form.Group>
                </div>
                <div className="col">
                  <Button
                    variant="primary"
                    type="submit"
                    className="btn btn-primary"
                    disabled={this.state.generating || this.state.validating || this.props.current_health_facility_access === null}
                  >
                    {I18n.t('add')}
                  </Button>
                </div>
              </div>
            </Form>
          </div>
        </div>
        <div className="row">
          {this.state.message !== "" && this.state.message}
        </div>
      </div>
    );
  }
}

export default AccessesComponent;
