import * as React from "react";
import * as _ from "lodash";
import I18n from "i18n-js";
import { DefaultLinkModel } from "@projectstorm/react-diagrams";
import { NotificationManager } from "react-notifications";

import Http from "../../../../engine/http";
import store from "../../../../engine/reducers/store";
import { openModal } from "../../../../engine/reducers/creators.actions";


export default class AdvancedLinkModel extends DefaultLinkModel {
  constructor(options = {}) {

    super({ ...options });

    this.options.type = "advanced";
    this.options.width = 3;
    this.options.color = "rgb(51,47,46)";

    this.dbConditionId = options.dbConditionId || {};
    this.parentInstanceId = options.parentInstanceId || {};
    this.score = options.score || "";
    this.triggerEvent = options.triggerEvent || true;
    this.http = new Http();

    // Set event listener
    this.registerListener({
      eventWillFire: _.debounce(
        (event) => {
          switch (event.function) {
            case "targetPortChanged":
              // Trigger only on user action
              if (event.entity.options.selected) {
                this.createLink();
              }
              break;
            case "entityRemoved":
              // Trigger only on user action
              if (event.entity.options.selected && this.triggerEvent && this.targetPort !== null) {
                this.removeLink();
              }
              break;
            default:
              break;
          }
        },
        100
      )
    });
  }

  /**
   * Create link in database and assign value
   */
  createLink = async () => {
    let instanceId = this.targetPort.options.id;
    let answerId = this.sourcePort.options.id;

    if (this.targetPort.parent.diagramType === "scored") {
      this.options.selected = false;
      store.dispatch(
        openModal(I18n.t("questions_sequences.edit.title"), "ScoreForm", {
          answerId,
          instanceId,
          diagramObject: this,
          engine: this.sourcePort.parent.engine,
          score: this.score,
          method: 'create'
        })
      );
    } else {
      let httpRequest = await this.http.createLink(instanceId, answerId);
      let result = await httpRequest.json();

      if (httpRequest.status === 200) {
        this.dbConditionId = result.id;
        this.parentInstanceId = this.sourcePort.parent.options.dbInstance.id;
      } else {
        this.triggerEvent = false;
        this.remove();
        NotificationManager.error(result);
      }
    }
  };

  /**
   * Remove link in database
   */
  removeLink = async () => {
    let httpRequest = await this.http.removeLink(this.parentInstanceId, this.dbConditionId);
    let result = await httpRequest.json();

    if (httpRequest.status !== 200) {
      this.triggerEvent = false;
      this.remove();
      NotificationManager.error(result);
    }
  };

  /**
   * Get first label
   */
  getLabel() {
    return this.getLabels()[0];
  }

  serialize() {
    return {
      ...super.serialize(),
      dbConditionId: this.dbConditionId,
      parentInstanceId: this.parentInstanceId,
      score: this.score,
      triggerEvent: this.triggerEvent,
      http: this.http
    };
  }

  deserialize(event) {
    super.deserialize(event);
    this.dbConditionId = event.data.dbConditionId;
    this.parentInstanceId = event.data.parentInstanceId;
    this.score = event.data.score;
    this.triggerEvent = event.data.triggerEvent;
  }
}
