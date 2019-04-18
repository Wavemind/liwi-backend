import * as React from "react";

export default class Http {

  url: string;
  token: string;
  instanceableId;
  instanceableType;

  constructor(instanceableId, instanceableType) {
    this.url = window.location.origin;
    this.instanceableId = instanceableId;
    this.instanceableType = instanceableType === 'Diagnostic' ? 'diagnostics' : 'predefined_syndromes';
    this.token = document.querySelector("meta[name='csrf-token']").content;
  }

  createInstance = async (nodeId) => {
    const url = `${this.url}/${this.instanceableType}/${this.instanceableId}/instances/create_from_diagram`;

    const request = await fetch(url, {
      method: 'post',
      headers: {
        Accept: 'application/json, text/plain',
        'Content-Type': 'application/json',
        'X-CSRF-Token': this.token,
      },
      body: JSON.stringify({
        instance: {
          node_id: nodeId,
          instanceable_id: this.instanceableId,
          instanceable_type: this.instanceableType,
        }
      }),
    }).catch(error => console.log(error));

    let body = await request.json();

    // Display error
    if (!request.ok) {
      console.log(body.errors);
    }

    return await body;
  }


  deleteInstance = async (nodeId) => {
    const url = `${this.url}/${this.instanceableType}/${this.instanceableId}/instances/${nodeId}/delete_from_diagram`;

    const request = await fetch(url, {
      method: 'delete',
      headers: {
        Accept: 'application/json, text/plain',
        'Content-Type': 'application/json',
        'X-CSRF-Token': this.token,
      },
    }).catch(error => console.log(error));

    let body = await request.json();

    // Display error
    if (!request.ok) {
      console.log(body.errors);
    }

    return await body;
  }



}
