import * as React from "react";

export default class Http {

  url: string;
  token: string;
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
  createFinalDiagnostic = async (reference, label, description) => {
    let response;
    const url = `${this.url}/algorithms/${this.algorithm}/versions/${this.version}/${this.instanceableType}/${this.instanceableId}/final_diagnostics/create_from_diagram`;
    const body = {
      final_diagnostic: {
        reference: reference,
        label_en: label,
        description_en: description,
        diagnostic_id: this.instanceableId
      }
    };
    const header = await this.setHeaders("POST", body);
    const request = await fetch( url, header).catch(error => console.log(error));

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
  createHealthCare = async (type, reference, label, description) => {
    let response;
    const url = `${this.url}/algorithms/${this.algorithm}/${type}/create_from_diagram`;
    const body = {
      diagnostic_id: this.instanceableId,
      final_diagnostic_id: this.finalDiagnostic
    };
    body['health_cares_' + type.substring(0, type.length-1)] = {
      reference: reference,
      label_en: label,
      description_en: description
    };
    const header = await this.setHeaders("POST", body);
    const request = await fetch( url, header).catch(error => console.log(error));

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
  // Create an instance of a health care or a condition of it
  createHealthCareInstance = async (nodeId) => {
    let response;
    const url = `${this.url}/${this.instanceableType}/${this.instanceableId}/instances/create_from_final_diagnostic_diagram`;
    const body = {
      instance: {
        node_id: nodeId,
        instanceable_id: this.instanceableId,
        instanceable_type: this.instanceableType,
        final_diagnostic_id: this.finalDiagnostic
      }
    };
    const header = await this.setHeaders("POST", body);
    const request = await fetch( url, header).catch(error => console.log(error));

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
  createInstance = async (nodeId) => {
    let response;
    const url = `${this.url}/${this.instanceableType}/${this.instanceableId}/instances/create_from_diagram`;
    const body = {
      instance: {
        node_id: nodeId,
        instanceable_id: this.instanceableId,
        instanceable_type: this.instanceableType,
      }
    };
    const header = await this.setHeaders("POST", body);
    const request = await fetch( url, header).catch(error => console.log(error));

    // Display error or parse json
    if (request.ok) {
      response = await request.json();
    } else {
      response = request;
    }
    return await response;
  };


  // @params [Integer] nodeId, [Integer] answerId, [Integer] score
  // @return [Object] body of request
  // Create a Link
  createLink = async (nodeId, answerId, score = null) => {
    let response;
    const url = `${this.url}/${this.instanceableType}/${this.instanceableId}/instances/create_link`;
    const body = {
      instance: {
        node_id: nodeId,
        answer_id: answerId,
        final_diagnostic_id: this.finalDiagnostic
      },
      score: score
    };
    const header = await this.setHeaders("POST", body);
    const request = await fetch( url, header).catch(error => console.log(error));

    // Display error or parse json
    if (request.ok) {
      response = await request.json();
    } else {
      response = request;
    }
    return await response;
  };

  // @params [Hash] body of the question with its answers
  // @return [Object] body of request
  // Create an instance
  createQuestion = async (questionBody) => {
    let response;
    const url = `${this.url}/algorithms/${this.algorithm}/questions/create_from_diagram`;
    questionBody['instanceable_id'] = this.instanceableId;
    questionBody['instanceable_type'] = this.instanceableType;

    const header = await this.setHeaders("POST", questionBody);
    const request = await fetch( url, header).catch(error => console.log(error));

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
  createQuestionsSequence = async (reference, label, description, type, minScore) => {
    let response;
    const url = `${this.url}/algorithms/${this.algorithm}/questions_sequences/create_from_diagram`;
    const body = {
      questions_sequence: {
        reference: reference,
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
    const request = await fetch( url, header).catch(error => console.log(error));

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


  // @params [Integer] dfId, [Integer] excludedDfId
  // @return [Object] body of request
  // Exclude a final diagnostic
  excludeDiagnostic = async (dfId, excludedDfId) => {
    let response;
    const url = `${this.url}/algorithms/${this.algorithm}/versions/${this.version}/${this.instanceableType}/${this.instanceableId}/final_diagnostics/${dfId}/add_excluded_diagnostic`;
    const body = {
      final_diagnostic: {
        final_diagnostic_id: excludedDfId,
      }
    };
    const header = await this.setHeaders("PUT", body);
    const request = await fetch( url, header).catch(error => console.log(error));
    // Display error or parse json
    if (request.ok) {
      response = await request.json();
    } else {
      response = request;
    }
    return await response;
  };


  // @params [Integer] dfId
  // @return [Object] body of request
  // Remove excluding diagnostic
  removeExcluding = async (dfId) => {
    let response;

    const url = `${this.url}/algorithms/${this.algorithm}/versions/${this.version}/${this.instanceableType}/${this.instanceableId}/final_diagnostics/${dfId}/remove_excluded_diagnostic`;
    const header = await this.setHeaders("PUT");
    const request = await fetch( url, header).catch(error => console.log(error));

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
  // Delete an instance
  removeInstance = async (nodeId) => {
    let response;
    const url = `${this.url}/${this.instanceableType}/${this.instanceableId}/instances/remove_from_diagram`;
    const body = {
      instance: {
        node_id: nodeId,
        instanceable_id: this.instanceableId,
        instanceable_type: this.instanceableType,
        final_diagnostic_id: this.finalDiagnostic
      },
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


  // @params [Integer] nodeId, [Integer] answerId
  // @return [Object] body of request
  // Delete a Link
  removeLink = async (nodeId, answerId) => {
    let response;
    const url = `${this.url}/${this.instanceableType}/${this.instanceableId}/instances/remove_link`;
    const body = {
      instance: {
        node_id: nodeId,
        answer_id: answerId,
        final_diagnostic_id: this.finalDiagnostic,
      }
    };
    const header = await this.setHeaders("DELETE", body);
    const request = await fetch( url, header).catch(error => console.log(error));

    // Display error or parse json
    if (request.ok) {
      response = await request.json();
    } else {
      response = request;
    }
    return await response;
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

  // @params [String] method, [Object] body
  // @return [Object] header
  // Set header credentials to communicate with server
  setHeaders = async (method = "GET", body = false) => {
    let header = {
      method: method,
      headers: {},
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

  // @params [Integer] id, [String] reference, [String] label, [String] description, [Integer] final_diagnostic_id
  // @return [Object] body of request
  // Update final diagnostic node
  updateFinalDiagnostic = async (id, reference, label, description, final_diagnostic_id) => {
    let response;
    const url = `${this.url}/algorithms/${this.algorithm}/versions/${this.version}/${this.instanceableType}/${this.instanceableId}/final_diagnostics/${id}/update_from_diagram`;
    const body = {
      final_diagnostic: {
        id: id,
        reference: reference,
        label_en: label,
        description_en: description,
        final_diagnostic_id: final_diagnostic_id
      }
    };
    const header = await this.setHeaders("PUT", body);
    const request = await fetch( url, header).catch(error => console.log(error));

    // Display error or parse json
    if (request.ok) {
      response = await request.json();
    } else {
      response = request;
    }
    return await response;
  };

  // @params [Integer] id, [String] reference, [String] label, [String] description, [Integer] final_diagnostic_id
  // @return [Object] body of request
  // Update final diagnostic node
  updateHealthCare = async (id, reference, label, description, type) => {
    let response;
    const url = `${this.url}/algorithms/${this.algorithm}/${type}/${id}/update_from_diagram`;
    const body = {
      diagnostic_id: this.instanceableId,
      final_diagnostic_id: this.finalDiagnostic
    };
    body['health_cares_' + type.substring(0, type.length-1)] = {
      id: id,
      reference: reference,
      label_en: label,
      description_en: description
    };
    const header = await this.setHeaders("PUT", body);
    const request = await fetch( url, header).catch(error => console.log(error));

    // Display error or parse json
    if (request.ok) {
      response = await request.json();
    } else {
      response = request;
    }
    return await response;
  };

  // @params [Hash] body of the question with its answers
  // @return [Object] body of request
  // Update a question
  updateQuestion = async (id, questionBody) => {
    let response;
    const url = `${this.url}/algorithms/${this.algorithm}/questions/${id}/update_from_diagram`;
    questionBody['instanceable_id'] = this.instanceableId;
    questionBody['instanceable_type'] = this.instanceableType;

    const header = await this.setHeaders("PUT", questionBody);
    const request = await fetch( url, header).catch(error => console.log(error));

    // Display error or parse json
    if (request.ok) {
      response = await request.json();
    } else {
      response = request;
    }
    return await response;
  };


  // @params [Integer] id, [String] reference, [String] label, [String] description
  // @return [Object] body of request
  // Update predefined syndrome node
  updateQuestionsSequence = async (id, reference, label, description, minScore) => {
    let response;
    const url = `${this.url}/algorithms/${this.algorithm}/questions_sequences/${id}/update_from_diagram`;
    const body = {
      questions_sequence: {
        id: id,
        reference: reference,
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
