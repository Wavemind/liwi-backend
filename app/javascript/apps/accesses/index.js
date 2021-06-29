import React, { Component, Fragment } from 'react';
import {Form, Button} from "react-bootstrap";
import I18n from "i18n-js";
import parse from 'html-react-parser';

class AccessesComponent extends Component {
  constructor(props) {
    super(props);

    const { versions, current_health_facility_access } = props;
    const isGenerating = current_health_facility_access ? current_health_facility_access.version.job_id !== "" : false

    this.timer = null;
    this.state = {
      current_health_facility_access: current_health_facility_access,
      versions: versions,
      generating: isGenerating,
      validating: false,
      selectedVersion: "",
      message: "",
    };

    /**
     * When the user arrives on the page, checks whether an algorithm is generating.
     * If so, pings the status every 10 seconds
     */
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
    }} = this.state;

    const response = await fetch(`${window.location.origin}/algorithms/${version.algorithm.id}/versions/${version.id}/job_status`, {method: "GET"})
      .catch((error) => {
        console.error(error);
      });
    const data = await response.json();

    if (['complete', 'failed', 'interrupted'].includes(data.job_status)) {
      clearInterval(this.timer);

      let message = "";
      if (['failed', 'interrupted'].includes(data.job_status)) {
        message = I18n.t(`versions.job_status.json_generation_${data.job_status}`)
      }
      this.setState({
        generating: false,
        message: message
      })
    }
  }

  /**
   * Defines the headers to be sent to the server with the requests
   * @param body
   * @param method
   * @returns {{headers: {Accept: string, "X-CSRF-Token": *, "Content-Type": string}, method: string, body: string}}
   */
  setHeader = (body = {}, method = 'PUT') => {
    return {
      method: method,
      headers: {
        "Accept": "application/json, text/plain",
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector("meta[name='csrf-token']").content,
      },
      body: JSON.stringify(body),
    };
  }

  /**
   * Launches the validation and regeneration of the JSON
   * @returns {Promise<void>}
   */
  handleGenerate = async () => {
    const { current_health_facility_access: {
      version
    }} = this.state;

    this.setState({
      validating: true,
      message: "",
    })

    const url = `${window.location.origin}/algorithms/${version.algorithm.id}/versions/${version.id}/regenerate_json`;
    const header = this.setHeader();
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
   * Launches the validation and generation of the new JSON
   * @returns {Promise<void>}
   */
  handleAdd = async () => {
    const { health_facility } = this.props;

    this.setState({
      validating: true,
      message: "",
    })

    const url = `${window.location.origin}/health_facility_accesses`;
    const body = {
      health_facility_access: {
        health_facility_id: health_facility.id,
        version_id: this.state.selectedVersion
      }
    }
    const header = this.setHeader(body, 'POST');
    const response = await fetch(url, header).catch(error => console.log(error));
    const data = await response.json();

    if (data.success) {
      this.setState({
        current_health_facility_access: data.current_health_facility_access,
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
    }} = this.state;

    return (
      <div className="alert alert-success" role="alert">
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
    const { generating, validating, current_health_facility_access } = this.state;

    let message = ""
    let alertType = ""
    if (generating) {
      message = I18n.t('health_facilities.show.generating')
      alertType = "warning"
    } else if (validating) {
      message = I18n.t('health_facilities.show.validating')
      alertType = "warning"
    } else if (current_health_facility_access === null) {
      message = I18n.t('health_facilities.show.no_algorithm')
      alertType = "danger"
    }else {
      return this.renderGenerateButton();
    }
    return this.renderMessage(message, alertType)
  }

  render() {
    const { generating, validating, versions, selectedVersion, message } = this.state;

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
                      onChange={(event) => this.setState({selectedVersion: event.target.value})}
                      value={selectedVersion}
                      disabled={generating || validating}
                    >
                      <option value="">{I18n.t("prompt")}</option>
                      {versions.map((version) => (
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
                    disabled={generating || validating || selectedVersion === ""}
                    onClick={this.handleAdd}
                  >
                    {I18n.t('add')}
                  </Button>
                </div>
              </div>
            </Form>
          </div>
        </div>
        <div className="row">
          <div className="col-md-6">
            {message !== "" &&
              <div className={`alert alert-danger`} role="alert">
                {parse(message)}
              </div>
            }
          </div>
        </div>
      </div>
    );
  }
}

export default AccessesComponent;
