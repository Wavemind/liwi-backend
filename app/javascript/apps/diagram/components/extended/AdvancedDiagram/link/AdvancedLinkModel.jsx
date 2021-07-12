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
    this.options.score = options.score || "";
    this.options.triggerEvent = options.triggerEvent || true;

    this.http = new Http();

    // Set event listener
    this.registerListener({
      onContextMenu: () => {
        event.preventDefault();
      },
      eventWillFire: _.debounce(
        (event) => {
          switch (event.function) {
            case "targetPortChanged":
              // Trigger only on user action
              if (event.entity.options.selected !== undefined) {
                this.createLink();
              }
              break;
            case "entityRemoved":
              if (event.entity.options.selected && this.options.triggerEvent && this.targetPort !== null) {
                // Trigger only on user action
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

    if (this.targetPort.options.in === false){
      this.options.triggerEvent = false;
      this.remove();
      NotificationManager.error(I18n.t("conditions.validation.link_answer_to_answer"));
    } else {
      if (this.targetPort.parent.options.diagramType === "scored") {
        this.options.selected = false;
        store.dispatch(
          openModal(I18n.t("questions_sequences.edit.title"), "ScoreForm", {
            answerId,
            instanceId,
            diagramObject: this,
            engine: this.sourcePort.parent.options.engine,
            score: this.options.score,
            method: 'create'
          })
        );
      } else {
        let httpRequest = await this.http.createLink(instanceId, answerId);
        let result = await httpRequest.json();

        if (httpRequest.status === 200) {
          this.options.dbConditionId = result.id;
          this.options.parentInstanceId = this.sourcePort.parent.options.dbInstance.id;
        } else {
          this.options.triggerEvent = false;
          this.remove();
          NotificationManager.error(result);
        }
      }
    }
  };

  /**
   * Remove link in database
   */
  removeLink = async () => {
    let httpRequest = await this.http.removeLink(this.options.parentInstanceId, this.options.dbConditionId);
    let result = await httpRequest.json();

    if (httpRequest.status !== 200) {
      this.options.triggerEvent = false;
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
      cutOffStart: this.cutOffStart,
      cutOffEnd: this.cutOffEnd,
      triggerEvent: this.triggerEvent,
      http: this.http
    };
  }

  deserialize(event) {
    super.deserialize(event);
    this.dbConditionId = event.data.dbConditionId;
    this.parentInstanceId = event.data.parentInstanceId;
    this.score = event.data.score;
    this.cutOffStart = event.data.cutOffStart;
    this.cutOffEnd = event.data.cutOffEnd;
    this.triggerEvent = event.data.triggerEvent;
  }
}
