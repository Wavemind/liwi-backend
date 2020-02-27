import * as _ from "lodash";
import { NodeModel } from "@projectstorm/react-diagrams";
import { BaseModelOptions } from "@projectstorm/react-canvas-core";

import AdvancedPortModel from "../port/AdvancedPortModel";
import { getLabel } from "../../../helpers/nodeHelpers";


export interface AdvancedNodeModelOptions extends BaseModelOptions {
  color?: string;
  dbInstance?: object;
}

export default class AdvancedNodeModel extends NodeModel {
  color: string;
  dbInstance: object;

  constructor(options: AdvancedNodeModelOptions = {}) {
    super({
      ...options,
      type: "advanced"
    });
    this.color = options.color || "red";
    this.dbInstance = options.dbInstance || {};

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
      color: this.color,
      dbInstance: this.dbInstance
    };
  }

  deserialize(event): void {
    super.deserialize(event);
    this.color = event.data.color;
    this.dbInstance = event.data.dbInstance;
  }
}
