import * as React from "react";

export default class Http {

  url;
  token;
  instanceableId;
  instanceableType;
  version;
  algorithm;
  finalDiagnostic;

  constructor() {
    let data = document.querySelector(".metadata");

    this.url = window.location.origin;
    this.instanceableId = data.dataset.id;
    this.finalDiagnostic = data.dataset.final_diagnostic;
    this.instanceableType = data.dataset.type === "Diagnostic" ? "diagnostics" : "questions_sequences";
    this.version = data.dataset.version;
    this.algorithm = data.dataset.algorithm;
    this.token = document.querySelector("meta[name='csrf-token']").content;
  }

  // @params [Integer] nodeId
  // @return [Object] body of request
  // Create an instance
  createFinalDiagnostic = async (label, description) => {
    let response;
    const url = `${this.url}/algorithms/${this.algorithm}/versions/${this.version}/${this.instanceableType}/${this.instanceableId}/final_diagnostics/create_from_diagram`;
    const body = {
      final_diagnostic: {
        label_en: label,
        description_en: description,
        diagnostic_id: this.instanceableId
      }
    };
    const header = await this.setHeaders("POST", body);
    const request = await fetch(url, header).catch(error => console.log(error));

    // Display error or parse json
    if (request.ok) {
      response = await request.json();
    } else {
      response = request;
    }
    return await response;
  };

  // @params [Integer] nodeId
  // @return [Object] body of request
  // Create an instance
  createHealthCare = async (type, label, description) => {
    let response;
    const url = `${this.url}/algorithms/${this.algorithm}/${type}/create_from_diagram`;
    const body = {
      diagnostic_id: this.instanceableId,
      final_diagnostic_id: this.finalDiagnostic
    };
    body["health_cares_" + type.substring(0, type.length - 1)] = {
      label_en: label,
      description_en: description
    };
    const header = await this.setHeaders("POST", body);
    const request = await fetch(url, header).catch(error => console.log(error));

    // Display error or parse json
    if (request.ok) {
      response = await request.json();
    } else {
      response = request;
    }
    return await response;
  };

  /**
   * Create an instance
   * @params [Integer] nodeId
   * @params [Integer] x
   * @params [Integer] y
   * @return [Object] body of request
   */
  createInstance = async (nodeId, x, y) => {
    const url = `${this.url}/${this.instanceableType}/${this.instanceableId}/instances`;
    const body = {
      instance: {
        node_id: nodeId,
        position_x: x,
        position_y: y,
        instanceable_id: this.instanceableId,
        instanceable_type: this.instanceableType,
        final_diagnostic_id: this.finalDiagnostic
      }
    };
    const header = await this.setHeaders("POST", body);
    return await fetch(url, header).catch(error => console.log(error));
  };

  /**
   * Create a link
   * @params [Integer] instanceId
   * @params [Integer] answerId
   * @params [Integer] score
   * @return [Object] body of request
   */
  createLink = async (instanceId, answerId, score = null) => {
    const url = `${this.url}/${this.instanceableType}/${this.instanceableId}/instances/${instanceId}/create_link`;
    const body = {
      instance: {
        id: instanceId,
        answer_id: answerId,
        final_diagnostic_id: this.finalDiagnostic,
        score: score
      },
    };
    const header = await this.setHeaders("POST", body);
    return await fetch(url, header).catch(error => console.log(error));
  };

  // @params [Hash] body of the question with its answers
  // @return [Object] body of request
  // Create an instance
  createQuestion = async (questionBody) => {
    let response;
    const url = `${this.url}/algorithms/${this.algorithm}/questions/create_from_diagram`;
    questionBody["instanceable_id"] = this.instanceableId;
    questionBody["instanceable_type"] = this.instanceableType;

    const header = await this.setHeaders("POST", questionBody);
    const request = await fetch(url, header).catch(error => console.log(error));

    // Display error or parse json
    if (request.ok) {
      response = await request.json();
    } else {
      response = request;
    }
    return await response;
  };

  // @params [Integer] nodeId
  // @return [Object] body of request
  // Create an instance
  createQuestionsSequence = async (label, description, type, minScore) => {
    let response;
    const url = `${this.url}/algorithms/${this.algorithm}/questions_sequences/create_from_diagram`;
    const body = {
      questions_sequence: {
        label_en: label,
        description_en: description,
        type: type,
        min_score: minScore
      },
      instanceable_id: this.instanceableId,
      instanceable_type: this.instanceableType,
      final_diagnostic_id: this.finalDiagnostic
    };
    const header = await this.setHeaders("POST", body);
    const request = await fetch(url, header).catch(error => console.log(error));

    // Display error or parse json
    if (request.ok) {
      response = await request.json();
    } else {
      response = request;
    }
    return await response;
  };

  // @params [Integer] instanceId, [Integer] condID
  // @return [Object] body of request
  // Remove condition
  removeCondition = async (instanceId, condID) => {
    let response;
    const url = `${this.url}/${this.instanceableType}/${this.instanceableId}/instances/${instanceId}/conditions/${condID}`;
    const body = {
      instance: {
        instanceable_id: this.instanceableId,
        instanceable_type: this.instanceableType
      }
    };
    const header = await this.setHeaders("DELETE", body);
    const request = await fetch(url, header).catch(error => console.log(error));

    // Display error or parse json
    if (request.ok) {
      response = await request.json();
    } else {
      response = request;
    }
    return await response;
  };

  /**
   * Exclude a final diagnostic
   * @params [Integer] nodeId
   * @params [Integer] nodeId
   * @return [Object] body of request
   */
  excludeDiagnostic = async (excludingId, excludedId) => {
    const url = `${this.url}/algorithms/${this.algorithm}/versions/${this.version}/${this.instanceableType}/${this.instanceableId}/final_diagnostics/add_excluded_diagnostic`;
    const body = {
      final_diagnostic: {
        id: excludingId,
        final_diagnostic_id: excludedId
      }
    };
    const header = await this.setHeaders("PUT", body);
    return await fetch(url, header).catch(error => console.log(error));
  };

  /**
   * Remove excluding final diagnostic
   * @params [Integer] dfId
   * @return [Object] body of request
   */
  removeExcluding = async (dfId) => {
    const url = `${this.url}/algorithms/${this.algorithm}/versions/${this.version}/${this.instanceableType}/${this.instanceableId}/final_diagnostics/${dfId}/remove_excluded_diagnostic`;
    const header = await this.setHeaders("PUT");
    return await fetch(url, header).catch(error => console.log(error));
  };

  /**
   * Delete an instance
   * @params [Integer] nodeId
   * @return [Object] body of request
   */
  removeInstance = async (instanceId) => {
    const url = `${this.url}/${this.instanceableType}/${this.instanceableId}/instances/${instanceId}`;
    const body = {
      instance: {
        id: instanceId,
        final_diagnostic_id: this.finalDiagnostic
      }
    };
    const header = await this.setHeaders("DELETE", body);
    return await fetch(url, header).catch(error => console.log(error));
  };

  /**
   * Delete a Link
   * @params [Integer] nodeId
   * @params [Integer] answerId
   * @return [Object] body of request
   */
  removeLink = async (id, conditionId) => {
    const url = `${this.url}/${this.instanceableType}/${this.instanceableId}/instances/${id}/remove_link`;
    const body = {
      instance: {
        id: id,
        condition_id: conditionId,
        final_diagnostic_id: this.finalDiagnostic
      }
    };
    const header = await this.setHeaders("DELETE", body);
    return await fetch(url, header).catch(error => console.log(error));
  };

  // @params [String] panel
  // @return [Object] body of request
  // Redirect to algorithm panel
  redirectToAlgorithm = async (panel) => {
    window.location = `${this.url}/algorithms/${this.algorithm}?panel=${panel}`;
  };

  // @params [Integer] dfId
  // @return [Object] body of request
  // Redirect to diagnostic
  redirectToDiagnostic = async () => {
    window.location = `${this.url}/algorithms/${this.algorithm}/versions/${this.version}/${this.instanceableType}/${this.instanceableId}`;
  };

  // @params [Integer] dfId
  // @return [Object] body of request
  // Redirect to diagnostic diagram
  redirectToDiagnosticDiagram = async () => {
    window.location = `${this.url}/algorithms/${this.algorithm}/versions/${this.version}/${this.instanceableType}/${this.instanceableId}/diagram`;
  };

  // @params [Integer] dfId
  // @return [Object] body of request
  // Redirect to diagnostic
  redirectToFinalDiagnostic = async () => {
    window.location = `${this.url}/algorithms/${this.algorithm}/versions/${this.version}/${this.instanceableType}/${this.instanceableId}/final_diagnostics`;
  };

  // @params [String] term
  // @return [Object] json with results
  // Search for snomet results from search string
  searchSnomed = async (term) => {
    let response;
    const url = `https://browser.ihtsdotools.org/snowstorm/snomed-ct/MAIN/concepts?term=${term}&limit=50`;
    const request = await fetch(url).catch(error => console.log(error));

    // Display error or parse json
    if (request.ok) {
      response = await request.json();
    } else {
      response = request;
    }
    return await response;
  };

  // @params [String] method, [Object] body
  // @return [Object] header
  // Set header credentials to communicate with server
  setHeaders = async (method = "GET", body = false) => {
    let header = {
      method: method,
      headers: {}
    };
    if (method === "POST" || method === "PATCH" || method === "PUT" || method === "DELETE") {
      header.body = JSON.stringify(body);
      header.headers["Accept"] = "application/json, text/plain";
      header.headers["Content-Type"] = "application/json";
      header.headers["X-CSRF-Token"] = this.token;
    }
    return header;
  };

  // @params [Integer] dfId
  // @return [Object] body of request
  // Redirect to final diagnostic diagram
  showFinalDiagnosticDiagram = async (dfId) => {
    window.location = `${this.url}/algorithms/${this.algorithm}/versions/${this.version}/${this.instanceableType}/${this.instanceableId}/final_diagnostics/${dfId}/diagram`;
  };

  // @params [Integer] psId
  // @return [Object] body of request
  // Redirect to predefined syndrome diagram
  showQuestionsSequenceDiagram = async (qsId) => {
    window.location = `${this.url}/questions_sequences/${qsId}/diagram`;
  };

  // @params [Integer] nodeId, [Integer] answerId, [Integer] score
  // @return [Object] body of request
  // Update a condition to change its score
  updateConditionScore = async (answerId, nodeId, score) => {
    let response;
    const url = `${this.url}/${this.instanceableType}/${this.instanceableId}/instances/update_score`;
    const body = {
      instance: {
        node_id: nodeId,
        answer_id: answerId,
        final_diagnostic_id: this.finalDiagnostic
      },
      score: score
    };
    const header = await this.setHeaders("PUT", body);
    const request = await fetch(url, header).catch(error => console.log(error));

    // Display error or parse json
    if (request.ok) {
      response = await request.json();
    } else {
      response = request;
    }
    return await response;
  };

  // @params [Integer] id, [String] label, [String] description, [Integer] final_diagnostic_id
  // @return [Object] body of request
  // Update final diagnostic node
  updateFinalDiagnostic = async (id, label, description, final_diagnostic_id) => {
    let response;
    const url = `${this.url}/algorithms/${this.algorithm}/versions/${this.version}/${this.instanceableType}/${this.instanceableId}/final_diagnostics/${id}/update_from_diagram`;
    const body = {
      final_diagnostic: {
        id: id,
        label_en: label,
        description_en: description,
        final_diagnostic_id: final_diagnostic_id
      }
    };
    const header = await this.setHeaders("PUT", body);
    const request = await fetch(url, header).catch(error => console.log(error));

    // Display error or parse json
    if (request.ok) {
      response = await request.json();
    } else {
      response = request;
    }
    return await response;
  };

  // @params [Integer] id, [String] label, [String] description, [Integer] final_diagnostic_id
  // @return [Object] body of request
  // Update final diagnostic node
  updateHealthCare = async (id, label, description, type) => {
    let response;
    const url = `${this.url}/algorithms/${this.algorithm}/${type}/${id}/update_from_diagram`;
    const body = {
      diagnostic_id: this.instanceableId,
      final_diagnostic_id: this.finalDiagnostic
    };
    body["health_cares_" + type.substring(0, type.length - 1)] = {
      id: id,
      label_en: label,
      description_en: description
    };
    const header = await this.setHeaders("PUT", body);
    const request = await fetch(url, header).catch(error => console.log(error));

    // Display error or parse json
    if (request.ok) {
      response = await request.json();
    } else {
      response = request;
    }
    return await response;
  };

  /**
   * Set X and Y position in diagram
   * @params [Integer] id
   * @params [Integer] positionX
   * @params [Integer] positionY
   * @return [Object] body of request
   */
  setInstancePosition = async (id, positionX, positionY) => {
    const url = `${this.url}/instances/${id}`;
    const body = {
      instance: {
        position_x: positionX,
        position_y: positionY
      }
    };

    const header = await this.setHeaders("PUT", body);
    return await fetch(url, header).catch(error => console.log(error));
  };

  // @params [Hash] body of the question with its answers
  // @return [Object] body of request
  // Update a question and its answers
  updateQuestion = async (questionBody) => {
    let response;
    const url = `${this.url}/algorithms/${this.algorithm}/questions/${questionBody.question.id}/update_from_diagram`;
    questionBody["instanceable_id"] = this.instanceableId;
    questionBody["instanceable_type"] = this.instanceableType;

    const header = await this.setHeaders("PUT", questionBody);
    const request = await fetch(url, header).catch(error => console.log(error));

    // Display error or parse json
    if (request.ok) {
      response = await request.json();
    } else {
      response = request;
    }
    return await response;
  };

  // @params [Integer] id, [String] label, [String] description
  // @return [Object] body of request
  // Update predefined syndrome node
  updateQuestionsSequence = async (id, label, description, minScore) => {
    let response;
    const url = `${this.url}/algorithms/${this.algorithm}/questions_sequences/${id}/update_from_diagram`;
    const body = {
      questions_sequence: {
        id: id,
        label_en: label,
        description_en: description,
        min_score: minScore
      }
    };
    const header = await this.setHeaders("PUT", body);
    const request = await fetch(url, header).catch(error => console.log(error));

    // Display error or parse json
    if (request.ok) {
      response = await request.json();
    } else {
      response = request;
    }
    return await response;
  };

  // @return [Object] flash message
  // Validate diagnostic
  validateDiagnostic = async () => {
    let response;
    const url = `${this.url}/algorithms/${this.algorithm}/versions/${this.version}/${this.instanceableType}/${this.instanceableId}/validate`;
    const body = null;
    const header = await this.setHeaders("GET", body);
    const request = await fetch(url, header).catch(error => console.log(error));

    // Display error or parse json
    if (request.ok) {
      response = await request.json();
    } else {
      response = request;
    }
    return await response;
  };

  // @params [Hash] body of the question
  // @return [Object] body of request
  // Validate the question itself
  validateQuestion = async (questionBody) => {
    let response;
    const url = `${this.url}/algorithms/${this.algorithm}/questions/validate`;
    questionBody["instanceable_id"] = this.instanceableId;
    questionBody["instanceable_type"] = this.instanceableType;

    const header = await this.setHeaders("POST", questionBody);
    const request = await fetch(url, header).catch(error => console.log(error));

    // Display error or parse json
    if (request.ok) {
      response = await request.json();
    } else {
      response = request;
    }
    return await response;
  };

  // @return [Object] flash message
  // Validate predefined syndrome scored
  validateQuestionsSequence = async () => {
    let response;
    const url = `${this.url}/${this.instanceableType}/${this.instanceableId}/validate`;
    const body = null;
    const header = await this.setHeaders("GET", body);
    const request = await fetch(url, header).catch(error => console.log(error));

    // Display error or parse json
    if (request.ok) {
      response = await request.json();
    } else {
      response = request;
    }
    return await response;
  };

}
