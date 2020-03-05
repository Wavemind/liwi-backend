import { DefaultLinkModel } from "@projectstorm/react-diagrams";
import * as React from "react";
import * as _ from "lodash";

import Http from "../../../engine/http";

export default class AdvancedLinkModel extends DefaultLinkModel {
  constructor(options = {}) {
    super({
      ...options,
      type: "advanced",
      width: 3 // we specifically want this to also be width 10
    });

    this.dbConditionId = options.dbConditionId || {};
    this.parentInstanceId = options.parentInstanceId || {};

    const http = new Http();

    // Set event listener
    this.registerListener({
      eventWillFire: _.debounce(
        (event) => {
          switch (event.function) {
            case "targetPortChanged":
              // Trigger only on user action
              if (event.entity.options.selected) {
                this.createLink()
              }
              break;
            case 'entityRemoved':
              // Trigger only on user action
              if (event.entity.options.selected) {
                http.removeLink(this.parentInstanceId, this.dbConditionId);
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

  createLink() {
    const http = new Http();

    let instanceId = this.targetPort.options.id;
    let answerId = this.sourcePort.options.id;

    http.createLink(instanceId, answerId).then((result) => {
      if (result.status === 200) {
        result.json().then(dbCondition => {
          this.dbConditionId = dbCondition.id;
          this.parentInstanceId = this.sourcePort.parent.options.dbInstance.id;
        });
      }
    })
  }

  serialize() {
    return {
      ...super.serialize(),
      dbConditionId: this.dbConditionId,
      parentInstanceId: this.parentInstanceId,
    };
  }

  deserialize(event) {
    super.deserialize(event);
    this.dbConditionId = event.data.dbConditionId;
    this.parentInstanceId = event.data.parentInstanceId;
  }
}
