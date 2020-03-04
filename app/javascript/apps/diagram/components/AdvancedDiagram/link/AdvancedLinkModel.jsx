import { DefaultLinkModel } from "@projectstorm/react-diagrams";
import * as React from "react";
import * as _ from "lodash";

import Http from "../../../engine/http";

export default class AdvancedLinkModel extends DefaultLinkModel {
  constructor() {
    super({
      type: "advanced", // <-- here we give it a new type
      width: 3 // we specifically want this to also be width 10
    });

    const http = new Http();

    // Set event listener
    this.registerListener({
      eventDidFire: _.debounce(
        (event) => {
          switch (event.function) {
            case "targetPortChanged":
              let instanceId = this.targetPort.options.id;
              let answerId = this.sourcePort.options.id;
              http.createLink(instanceId, answerId);
              break;
            default:
              break;
          }
        },
        100
      )
    });
  }
}
