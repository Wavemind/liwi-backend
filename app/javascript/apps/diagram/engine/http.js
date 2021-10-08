import * as React from "react";
import getStudyLanguage from "../../utils";

export default class Http {
  url;
  token;
  instanceableId;
  instanceableType;
  version;
  algorithm;
  finalDiagnosis;
  l;

  constructor() {
    let data = document.querySelector(".metadata");
    this.l = getStudyLanguage();
    this.url = window.location.origin;
    this.instanceableId = data.dataset.id;
    this.finalDiagnosis = data.dataset.final_diagnosis;
    this.diagramType = data.dataset.type;
    this.instanceableType = ["Diagnosis", "FinalDiagnosis"].includes(
      data.dataset.type
    )
      ? "diagnoses"
      : "questions_sequences";
    this.version = data.dataset.version;
    this.algorithm = data.dataset.algorithm;
    this.token = document.querySelector("meta[name='csrf-token']").content;
  }

  /**
   * Create a drug
   * @params [Hash] drug body
   * @return [Object] body of request
   */
  createDrug = async (drug, from) => {
    const url = `${this.url}/algorithms/${this.algorithm}/drugs`;
    const body = {
      health_cares_drug: drug,
      diagnosis_id: this.instanceableId,
      final_diagnosis_id: this.finalDiagnosis,
      from
    };

    const header = await this.setHeaders("POST", body);
    return await fetch(url, header).catch(error => console.log(error));
  };

  /**
   * Create a final diagnosis
   * @params [String] label
   * @params [String] description
   * @params [String] from
   * @return [Object] body of request
   */
  createFinalDiagnosis = async (
    label,
    description,
    level_of_urgency,
    medias_attributes,
    from
  ) => {
    const url = `${this.url}/algorithms/${this.algorithm}/versions/${this.version}/${this.instanceableType}/${this.instanceableId}/final_diagnoses`;
    let body = {
      final_diagnosis: {
        level_of_urgency,
        diagnosis_id: this.instanceableId,
        medias_attributes
      },
      from
    };
    body['final_diagnosis'][`label_${this.l}`] = label;
    body['final_diagnosis'][`description_${this.l}`] = description;
    const header = await this.setHeaders("POST", body);
    return await fetch(url, header).catch(error => console.log(error));
  };

  /**
   * Create a management
   * @params [String] label
   * @params [String] description
   * @params [array] medias_attributes
   * @params [String] from
   * @return [Object] body of request
   */
  createManagement = async (
    label,
    description,
    level_of_urgency,
    is_referral,
    medias_attributes,
    from
  ) => {
    const url = `${this.url}/algorithms/${this.algorithm}/managements`;
    let body = {
      health_cares_management: {
        level_of_urgency,
        is_referral,
        medias_attributes
      },
      diagnosis_id: this.instanceableId,
      final_diagnosis_id: this.finalDiagnosis,
      from
    };
    body['health_cares_management'][`label_${this.l}`] = label;
    body['health_cares_management'][`description_${this.l}`] = label;

    const header = await this.setHeaders("POST", body);
    return await fetch(url, header).catch(error => console.log(error));
  };

  /**
   * Get dependencies of given question
   * @params [Integer] question id
   * @return [Object] body of request
   */
  getQuestionDependencies = async id => {
    const url = `${this.url}/questions/${id}/dependencies`;
    const header = await this.setHeaders("GET", null);
    return await fetch(url, header).catch(error => console.log(error));
  };

  /**
   * Update a condition with its cut offs
   * @params [Integer] id
   * @params [Integer] cutOffStart
   * @params [Integer] cutOffEnd
   * @params [String] cutOffValueType
   * @return [Object] body of request
   */
  updateCutOffs = async (id, cutOffStart, cutOffEnd, cutOffValueType) => {
    const url = `${this.url}/conditions/${id}/update_cut_offs`;
    const body = {
      condition: {
        id,
        cut_off_start: cutOffStart,
        cut_off_end: cutOffEnd,
        cut_off_value_type: cutOffValueType
      }
    };
    const header = await this.setHeaders("PUT", body);
    return await fetch(url, header).catch(error => console.log(error));
  };

  /**
   * Update the full order for a version
   * @params [json] tree
   * @return [Object] body of request
   */
  updateFullOrder = async tree => {
    const url = `${this.url}/algorithms/${this.algorithm}/versions/${this.version}/update_full_order`;
    const body = {
      version: {
        full_order_json: tree
      }
    };
    const header = await this.setHeaders("PUT", body);
    return await fetch(url, header).catch(error => console.log(error));
  };

  /**
   * Update a management
   * @params [String] label
   * @params [String] description
   * @params [array] medias_attributes
   * @params [String] from
   * @return [Object] body of request
   */
  updateManagement = async (
    id,
    label,
    description,
    level_of_urgency,
    is_referral,
    medias_attributes,
    from
  ) => {
    const url = `${this.url}/algorithms/${this.algorithm}/managements/${id}`;
    let body = {
      health_cares_management: {
        id,
        level_of_urgency,
        is_referral,
        medias_attributes
      },
      diagnosis_id: this.instanceableId,
      final_diagnosis_id: this.finalDiagnosis,
      from
    };
    body['health_cares_management'][`label_${this.l}`] = label;
    body['health_cares_management'][`description_${this.l}`] = description;

    const header = await this.setHeaders("PUT", body);
    return await fetch(url, header).catch(error => console.log(error));
  };

  /**
   * Update drug
   * @params [Object] drug
   * @params [String] from
   * @return [Object] body of request
   */
  updateDrug = async (drug, from) => {
    const url = `${this.url}/algorithms/${this.algorithm}/drugs/${drug.id}`;
    const body = {
      health_cares_drug: drug,
      diagnosis_id: this.instanceableId,
      final_diagnosis_id: this.finalDiagnosis,
      from
    };
    const header = await this.setHeaders("PUT", body);
    return await fetch(url, header).catch(error => console.log(error));
  };

  /**
   * Create an instance
   * @params [Integer] nodeId
   * @params [Integer] x
   * @params [Integer] y
   * @return [Object] body of request
   */
  createInstance = async (
    nodeId,
    x,
    y,
    duration = "",
    description = ""
  ) => {
    const url = `${this.url}/${this.instanceableType}/${this.instanceableId}/instances`;
    let body = {
      instance: {
        node_id: nodeId,
        position_x: x,
        position_y: y,
        instanceable_id: this.instanceableId,
        instanceable_type: this.instanceableType,
        final_diagnosis_id: this.finalDiagnosis,
      }
    };
    body['instance'][`duration_${this.l}`] = duration;
    body['instance'][`description_${this.l}`] = description;

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
    // TODO : Figure a better solution out
    instanceId = instanceId.substring(
      instanceId.indexOf("_") + 1,
      instanceId.length
    );
    answerId = answerId.substring(answerId.indexOf("_") + 1, answerId.length);
    const url = `${this.url}/${this.instanceableType}/${this.instanceableId}/instances/${instanceId}/create_link`;
    const body = {
      instance: {
        id: instanceId,
        answer_id: answerId,
        final_diagnosis_id: this.finalDiagnosis,
        score
      }
    };
    const header = await this.setHeaders("POST", body);
    return await fetch(url, header).catch(error => console.log(error));
  };

  /**
   * Create a link
   * @params [Object] question
   * @params [String] from
   * @return [Object] body of request
   */
  createQuestion = async (question, from) => {
    const url = `${this.url}/algorithms/${this.algorithm}/questions/`;
    const body = {
      question,
      instanceable_id: this.instanceableId,
      instanceable_type: this.instanceableType,
      final_diagnosis_id: this.finalDiagnosis,
      from
    };
    const header = await this.setHeaders("POST", body);
    return await fetch(url, header).catch(error => console.log(error));
  };

  /**
   * Create a question sequence
   * @params [String] label
   * @params [String] description
   * @params [String] type
   * @params [Number] min_score
   * @params [Object] complaint_categories_attributes
   * @params [String] from
   * @return [Object] body of request
   */
  createQuestionsSequence = async (
    label,
    description,
    type,
    min_score,
    cut_off_start,
    cut_off_end,
    cut_off_value_type,
    complaint_category_ids,
    from
  ) => {
    const url = `${this.url}/algorithms/${this.algorithm}/questions_sequences`;
    let body = {
      questions_sequence: {
        type,
        min_score,
        cut_off_start,
        cut_off_end,
        cut_off_value_type,
        complaint_category_ids
      },
      instanceable_id: this.instanceableId,
      instanceable_type: this.instanceableType,
      final_diagnosis_id: this.finalDiagnosis,
      from
    };
    body['questions_sequence'][`label_${this.l}`] = label;
    body['questions_sequence'][`description_${this.l}`] = description;

    const header = await this.setHeaders("POST", body);
    return await fetch(url, header).catch(error => console.log(error));
  };

  /**
   * Create components for the version
   * @params [Array] nodes ids
   * @return [Object] body of request
   */
  createVersionInstance = async nodesIds => {
    const url = `${this.url}/algorithms/${this.algorithm}/versions/${this.version}/components`;
    const body = {
      nodes_ids: nodesIds,
      version_id: this.version
    };
    const header = await this.setHeaders("POST", body);
    return await fetch(url, header).catch(error => console.log(error));
  };

  /**
   * Fetch drug medication forms
   * @return [Object] body of request
   */
  fetchDrugMedicationForms = async () => {
    const url = `${this.url}/drugs/lists`;
    const header = await this.setHeaders("GET", null);
    return await fetch(url, header).catch(error => console.log(error));
  };

  /**
   * Fetch answer operators
   * @return [Object] body of request
   */
  fetchAnswerOperators = async () => {
    const url = `${this.url}/answers/operators`;
    const header = await this.setHeaders("GET", null);
    return await fetch(url, header).catch(error => console.log(error));
  };

  /**
   * Fetch questions sequences categories + complaint categories
   * @return [Object] body of request
   */
  fetchQuestionsSequenceLists = async () => {
    const url = `${this.url}/algorithms/${this.algorithm}/questions_sequences/lists`;
    const header = await this.setHeaders("GET", null);
    return await fetch(url, header).catch(error => console.log(error));
  };

  /**
   * Fetch questions sequences categories
   * @return [Object] body of request
   */
  fetchQuestionsLists = async () => {
    const url = `${this.url}/algorithms/${this.algorithm}/questions/lists?diagram_type=${this.diagramType}`;
    const header = await this.setHeaders("GET", null);
    return await fetch(url, header).catch(error => console.log(error));
  };

  /**
   * Exclude a final diagnosis
   * @params [Integer] nodeId
   * @params [Integer] nodeId
   * @return [Object] body of request
   */
  excludeDiagnosis = async (excludingDfId, excludedDfId) => {
    const url = `${this.url}/algorithms/${this.algorithm}/versions/${this.version}/final_diagnoses/add_exclusion`;
    const body = {
      node_exclusion: {
        excluding_node_id: excludingDfId,
        excluded_node_id: excludedDfId
      }
    };
    const header = await this.setHeaders("POST", body);
    return await fetch(url, header).catch(error => console.log(error));
  };

  /**
   * Remove excluding final diagnosis
   * @params [Integer] dfId
   * @return [Object] body of request
   */
  removeExcluding = async (excludingDfId, excludedDfId) => {
    const url = `${this.url}/algorithms/${this.algorithm}/versions/${this.version}/final_diagnoses/remove_exclusion`;
    const body = {
      node_exclusion: {
        excluding_node_id: excludingDfId,
        excluded_node_id: excludedDfId
      }
    };
    const header = await this.setHeaders("DELETE", body);
    return await fetch(url, header).catch(error => console.log(error));
  };

  /**
   * Delete an instance
   * @params [Integer] nodeId
   * @return [Object] body of request
   */
  removeInstance = async instanceId => {
    const url = `${this.url}/${this.instanceableType}/${this.instanceableId}/instances/${instanceId}`;
    const body = {
      instance: {
        id: instanceId,
        final_diagnosis_id: this.finalDiagnosis
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
        id,
        condition_id: conditionId,
        final_diagnosis_id: this.finalDiagnosis
      }
    };
    const header = await this.setHeaders("DELETE", body);
    return await fetch(url, header).catch(error => console.log(error));
  };

  /**
   * Redirect to algorithm panel
   */
  redirectToAlgorithm = async panel => {
    window.location = `${this.url}/algorithms/${this.algorithm}?panel=${panel}`;
  };

  /**
   * Redirect to diagnosis
   */
  redirectToDiagnosis = async () => {
    window.location = `${this.url}/algorithms/${this.algorithm}/versions/${this.version}/${this.instanceableType}/${this.instanceableId}`;
  };

  /**
   * Redirect to diagnosis diagram
   */
  redirectToDiagnosisDiagram = async () => {
    window.location = `${this.url}/algorithms/${this.algorithm}/versions/${this.version}/${this.instanceableType}/${this.instanceableId}/diagram`;
  };

  /**
   * Remove components from version
   * @params [Array] nodes ids
   * @return [Object] body of request
   */
  removeVersionInstances = async nodesIds => {
    const url = `${this.url}/algorithms/${this.algorithm}/versions/${this.version}/remove_components`;
    const body = {
      nodes_ids: nodesIds,
      version_id: this.version
    };
    const header = await this.setHeaders("DELETE", body);
    return await fetch(url, header).catch(error => console.log(error));
  };

  /**
   * Search for snomed results from search string
   * @params [String] term
   * @return [Object] json with results
   */
  searchSnomed = async term => {
    const url = `https://browser.ihtsdotools.org/snowstorm/snomed-ct/MAIN/concepts?term=${term}&limit=50`;
    return await fetch(url).catch(error => console.log(error));
  };

  /**
   * Set header credentials to communicate with server
   * @params [String] method
   * @params [Object] body
   * @return [Object] header
   */
  setHeaders = async (method = "GET", body = false) => {
    let header = {
      method,
      headers: {}
    };
    if (
      method === "POST" ||
      method === "PATCH" ||
      method === "PUT" ||
      method === "DELETE"
    ) {
      header.body = JSON.stringify(body);
      header.headers["Accept"] = "application/json, text/plain";
      header.headers["Content-Type"] = "application/json";
      header.headers["X-CSRF-Token"] = this.token;
    }
    return header;
  };

  /**
   * Redirect to final diagnosis diagram
   * @params [Integer] dfId
   */
  showFinalDiagnosisDiagram = async dfId => {
    window.location = `${this.url}/algorithms/${this.algorithm}/versions/${this.version}/${this.instanceableType}/${this.instanceableId}/final_diagnoses/${dfId}/diagram`;
  };

  /**
   * Redirect to questions sequences diagram
   * @params [Integer] id
   * @return [Object] body of request
   */
  showQuestionsSequenceDiagram = async id => {
    window.location = `${this.url}/questions_sequences/${id}/diagram`;
  };

  /**
   * Update a condition to change its score
   * @params [Integer] conditionId
   * @params [Integer] score
   * @return [Object] body of request
   */
  updateConditionScore = async (conditionId, score) => {
    const url = `${this.url}/${this.instanceableType}/${this.instanceableId}/instances/update_score`;
    const body = {
      instance: {
        condition_id: conditionId,
        score
      }
    };
    const header = await this.setHeaders("PUT", body);
    return await fetch(url, header).catch(error => console.log(error));
  };

  /**
   * Update final diagnosis
   * @params [Integer] id
   * @params [Integer] label
   * @params [Integer] description
   * @params [Integer] from
   * @return [Object] body of request
   */
  updateFinalDiagnosis = async (
    id,
    label,
    description,
    level_of_urgency,
    medias_attributes,
    from,
    source
  ) => {
    const url = `${this.url}/algorithms/${this.algorithm}/versions/${this.version}/${this.instanceableType}/${this.instanceableId}/final_diagnoses/${id}`;
    let body = {
      final_diagnosis: {
        id,
        level_of_urgency,
        medias_attributes
      },
      from,
      source
    };
    body['final_diagnosis'][`label_${this.l}`] = label;
    body['final_diagnosis'][`description_${this.l}`] = description;

    const header = await this.setHeaders("PUT", body);
    return await fetch(url, header).catch(error => console.log(error));
  };

  /**
   * Set X and Y position in diagram
   * @params [Integer] id
   * @params [Integer] positionX
   * @params [Integer] positionY
   * @return [Object] body of request
   */
  updateInstance = async (
    id,
    positionX,
    positionY,
    duration = "",
    description = ""
  ) => {
    const url = `${this.url}/instances/${id}`;
    let body = {
      instance: {
        position_x: positionX,
        position_y: positionY,
      }
    };
    body['instance'][`duration_${this.l}`] = duration;
    body['instance'][`description_${this.l}`] = description;

    const header = await this.setHeaders("PUT", body);
    return await fetch(url, header).catch(error => console.log(error));
  };

  /**
   * Update a question and its answers
   * @params [Object] question
   * @params [String] from
   * @return [Object] body of request
   */
  updateQuestion = async (question, from) => {
    const url = `${this.url}/algorithms/${this.algorithm}/questions/${question.id}`;
    const body = {
      question,
      instanceable_id: this.instanceableId,
      instanceable_type: this.instanceableType,
      final_diagnosis_id: this.finalDiagnosis,
      from
    };
    const header = await this.setHeaders("PUT", body);
    return await fetch(url, header).catch(error => console.log(error));
  };

  /**
   * Update a question sequence
   * @params [Integer] id
   * @params [String] label
   * @params [String] description
   * @params [String] type
   * @params [Integer] min_score
   * @params [String] from
   * @return [Object] body of request
   */
  updateQuestionsSequence = async (
    id,
    label,
    description,
    type,
    min_score,
    cut_off_start,
    cut_off_end,
    cut_off_value_type,
    complaint_category_ids,
    from
  ) => {
    const url = `${this.url}/algorithms/${this.algorithm}/questions_sequences/${id}`;
    let body = {
      questions_sequence: {
        id,
        type,
        min_score,
        cut_off_start,
        cut_off_end,
        cut_off_value_type,
        complaint_category_ids
      },
      from
    };
    body['questions_sequence'][`label_${this.l}`] = label;
    body['questions_sequence'][`description_${this.l}`] = description;

    const header = await this.setHeaders("PUT", body);
    return await fetch(url, header).catch(error => console.log(error));
  };

  /**
   *
   * @param list
   * @param order
   * @returns {Promise<Response | void>}
   */
  updateVersionList = async (list, order) => {
    const url = `${this.url}/algorithms/${this.algorithm}/versions/${this.version}/update_list`;
    const body = {
      list,
      order
    };
    const header = await this.setHeaders("PUT", body);
    return await fetch(url, header).catch(error => console.log(error));
  };

  /**
   * Validate diagnosis
   * @return [Object] body of request
   */
  validateDiagnosis = async () => {
    const url = `${this.url}/algorithms/${this.algorithm}/versions/${this.version}/${this.instanceableType}/${this.instanceableId}/validate`;
    const header = await this.setHeaders("GET", null);
    return await fetch(url, header).catch(error => console.log(error));
  };

  /**
   * Validate question before next step
   * @return [Object] body of request
   */
  validateQuestion = async question => {
    const url = `${this.url}/algorithms/${this.algorithm}/questions/validate`;
    const body = {
      question
    };

    const header = await this.setHeaders("POST", body);
    return await fetch(url, header).catch(error => console.log(error));
  };

  /**
   * Validate a question sequence
   * @return [Object] body of request
   */
  validateQuestionsSequence = async () => {
    const url = `${this.url}/${this.instanceableType}/${this.instanceableId}/validate`;
    const header = await this.setHeaders("GET", null);
    return await fetch(url, header).catch(error => console.log(error));
  };
}
