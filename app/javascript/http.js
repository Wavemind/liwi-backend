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
    let data = document.querySelector("p");

    this.url = window.location.origin;
    this.instanceableId = data.dataset.id;
    this.finalDiagnostic = data.dataset.final_diagnostic;
    this.instanceableType = data.dataset.type === "Diagnostic" ? "diagnostics" : "predefined_syndromes";
    this.version = data.dataset.version;
    this.algorithm = data.dataset.algorithm;
    this.token = document.querySelector("meta[name='csrf-token']").content;
  }


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
      },
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


  // @params [Integer] nodeId, [Integer] answerId
  // @return [Object] body of request
  // Create a Link
  createLink = async (nodeId, answerId) => {
    let response;
    const url = `${this.url}/${this.instanceableType}/${this.instanceableId}/instances/create_link`;
    const body = {
      instance: {
        node_id: nodeId,
        answer_id: answerId,
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
  // @return [Object] response
  // Get a condition with its conditions
  getInstanceConditions = async (nodeId) => {
    let response;
    const url = `${this.url}/${this.instanceableType}/${this.instanceableId}/instances/load_conditions?node_id=${nodeId}`;
    const header = await this.setHeaders("GET");
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
  removeHealthCaresInstance = async (nodeId) => {
    let response;
    const url = `${this.url}/${this.instanceableType}/${this.instanceableId}/instances/remove_from_diagram`;
    const body = {
      instance: {
        node_id: nodeId,
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

}
