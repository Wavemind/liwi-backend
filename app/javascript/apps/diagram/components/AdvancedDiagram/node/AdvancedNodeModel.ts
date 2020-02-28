import * as _ from "lodash";
import { NodeModel } from "@projectstorm/react-diagrams";
import { BaseModelOptions } from "@projectstorm/react-canvas-core";

import AdvancedPortModel from "../port/AdvancedPortModel";
import { getLabel } from "../../../helpers/nodeHelpers";
import Http from "../../../engine/http";

export interface AdvancedNodeModelOptions extends BaseModelOptions {
  dbInstance?: object;
}

export default class AdvancedNodeModel extends NodeModel {
  dbInstance: object;

  constructor(options: AdvancedNodeModelOptions = {}) {
    super({
      ...options,
      type: "advanced"
    });
    this.dbInstance = options.dbInstance || {};
    const http = new Http();
    // inPort
    this.addPort(
      new AdvancedPortModel({
        in: true,
        name: "in"
      })
    );

    // outPorts
    this.dbInstance.node.answers.map(answer => {
      this.addPort(new AdvancedPortModel({
        in: false,
        name: getLabel(answer)
      }));
    });

    // Set Position
    this.setPosition(this.dbInstance.position_x, this.dbInstance.position_y);

    // Set event listener
    this.registerListener({
      eventDidFire: _.debounce(
        (event) =>
          http.updateInstance(this.dbInstance.id, event.entity.position.x, event.entity.position.y),
        100
      )
    });

  }

  // Get single in port
  getInPort(): AdvancedPortModel[] {
    return _.find(this.ports, portModel => {
      return portModel.options.in;
    });
  }

  // Get all out ports
  getOutPorts(): AdvancedPortModel[] {
    return _.filter(this.ports, portModel => {
      return !portModel.options.in;
    });
  }

  serialize() {
    return {
      ...super.serialize(),
      dbInstance: this.dbInstance
    };
  }

  deserialize(event): void {
    super.deserialize(event);
    this.dbInstance = event.data.dbInstance;
  }
}
