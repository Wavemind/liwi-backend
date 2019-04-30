import * as React from "react";

export default class Http {

  url: string;
  token: string;
  instanceableId;
  instanceableType;

  constructor() {
    let data = document.querySelector("p");

    this.url = window.location.origin;
    this.instanceableId = data.dataset.id;
    this.instanceableType = data.dataset.type === "Diagnostic" ? "diagnostics" : "predefined_syndromes";
    this.token = document.querySelector("meta[name='csrf-token']").content;
  }


  // @params [Integer] nodeId
  // @return [Object] body of request
  // Create an instance
  createInstance = async (nodeId) => {
    const url = `${this.url}/${this.instanceableType}/${this.instanceableId}/instances/create_from_diagram`;
    const body = {
      instance: {
        node_id: nodeId,
        instanceable_id: this.instanceableId,
        instanceable_type: this.instanceableType
      }
    };
    const header = await this.setHeaders('POST', body);
    const request = await fetch( url, header).catch(error => console.log(error));
    let response = await request.json();
    if (!request.ok) {
      console.log(response.errors);
    }
    return await response;
  };


  // @params [Integer] nodeId, [Integer] answerId
  // @return [Object] body of request
  // Create a Link
  createLink = async (nodeId, answerId) => {
    const url = `${this.url}/${this.instanceableType}/${this.instanceableId}/instances/create_link`;
    const body = {
      instance: {
        node_id: nodeId,
        answer_id: answerId,
      }
    };
    const header = await this.setHeaders('POST', body);
    const request = await fetch( url, header).catch(error => console.log(error));
    let response = await request.json();
    if (!request.ok) {
      console.log(response.errors);
    }
    return await response;
  };


  // @params [Integer] nodeId
  // @return [Object] body of request
  // Delete an instance
  removeInstance = async (nodeId) => {
    const url = `${this.url}/${this.instanceableType}/${this.instanceableId}/instances/remove_from_diagram`;
    const body = {
      instance: {
        node_id: nodeId,
        instanceable_id: this.instanceableId,
        instanceable_type: this.instanceableType
      }
    };
    const header = await this.setHeaders('DELETE', body);
    const request = await fetch(url, header).catch(error => console.log(error));
    if (!request.ok) {
      console.log(body.errors);
    }
    return await body;
  };


  // @params [Integer] nodeId, [Integer] answerId
  // @return [Object] body of request
  // Delete a Link
  removeLink = async (nodeId, answerId) => {
    const url = `${this.url}/${this.instanceableType}/${this.instanceableId}/instances/remove_link`;
    const body = {
      instance: {
        node_id: nodeId,
        answer_id: answerId,
      }
    };
    const header = await this.setHeaders('DELETE', body);
    const request = await fetch( url, header).catch(error => console.log(error));
    let response = await request.json();
    if (!request.ok) {
      console.log(response.errors);
    }
    return await response;
  };


  // @params [String] method, [Object] body
  // @return [Object] header
  // Set header credentials to communicate with server
  setHeaders = async (method = 'GET', body = false) => {
    let header = {
      method: method,
      headers: {},
    };
    if (method === 'POST' || method === 'PATCH' || method === 'DELETE') {
      header.body = JSON.stringify(body);
      header.headers['Accept'] = 'application/json, text/plain';
      header.headers['Content-Type'] = 'application/json';
      header.headers["X-CSRF-Token"] = this.token;
    }
    return header;
  };

}
