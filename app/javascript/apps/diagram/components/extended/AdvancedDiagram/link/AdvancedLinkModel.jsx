import * as React from "react";
import * as _ from "lodash";
import { DefaultLinkModel } from "@projectstorm/react-diagrams";
import { NotificationManager } from "react-notifications";

import Http from "../../../../engine/http";

export default class AdvancedLinkModel extends DefaultLinkModel {
  constructor(options = {}) {
    super({
      ...options,
      type: "advanced",
      width: 3 // we specifically want this to also be width 10
    });

    this.dbConditionId = options.dbConditionId || {};
    this.parentInstanceId = options.parentInstanceId || {};
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
              if (event.entity.options.selected && this.triggerEvent) {
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
  createLink() {
    let instanceId = this.targetPort.options.id;
    let answerId = this.sourcePort.options.id;

    this.http.createLink(instanceId, answerId).then(httpRequest => {
      httpRequest.json().then(result => {
        if (httpRequest.status === 200) {
          this.dbConditionId = result.id;
          this.parentInstanceId = this.sourcePort.parent.options.dbInstance.id;
        } else {
          this.triggerEvent = false;
          this.remove();
          NotificationManager.error(result);
        }
      });
    });
  }

  /**
   * Remove link in database
   */
  removeLink() {
    this.http.removeLink(this.parentInstanceId, this.dbConditionId).then(httpRequest => {
      httpRequest.json().then(result => {
        if (httpRequest.status !== 200) {
          this.triggerEvent = false;
          this.remove();
          NotificationManager.error(result);
        }
      });
    });
  }

  serialize() {
    return {
      ...super.serialize(),
      dbConditionId: this.dbConditionId,
      parentInstanceId: this.parentInstanceId,
      triggerEvent: this.triggerEvent,
      http: this.http
    };
  }

  deserialize(event) {
    super.deserialize(event);
    this.dbConditionId = event.data.dbConditionId;
    this.parentInstanceId = event.data.parentInstanceId;
    this.triggerEvent = event.data.triggerEvent;
  }
}
