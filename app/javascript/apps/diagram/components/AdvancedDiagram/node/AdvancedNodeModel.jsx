import * as _ from "lodash";
import { NodeModel } from "@projectstorm/react-diagrams";

import AdvancedPortModel from "../port/AdvancedPortModel";
import { getLabel } from "../../../helpers/nodeHelpers";
import Http from "../../../engine/http";

export default class AdvancedNodeModel extends NodeModel {

  constructor(options = {}) {
    super({
      ...options,
      type: "advanced"
    });
    this.dbInstance = options.dbInstance || {};
    this.addAvailableNode = options.addAvailableNode || {};
    const http = new Http();

    // inPort
    this.addPort(
      new AdvancedPortModel({
        in: true,
        name: "in",
        id: this.dbInstance.id
      })
    );

    // outPorts
    this.dbInstance.node.answers.map(answer => {
      this.addPort(new AdvancedPortModel({
        in: false,
        name: getLabel(answer),
        id: answer.id
      }));
    });


    // Set Position
    this.setPosition(this.dbInstance.position_x, this.dbInstance.position_y);

    // Set event listener
    this.registerListener({
      eventDidFire: _.debounce(
        (event) => {
          switch(event.function) {
            case 'positionChanged':
              http.updateInstance(this.dbInstance.id, event.entity.position.x, event.entity.position.y);
              break;
            case 'entityRemoved':
              http.removeInstance(this.dbInstance.id);
              this.addAvailableNode(this.dbInstance.node);
              break;
            default:
              break;
          }
        },
        100
      )
    });
  }

  // Get single in port
  getInPort() {
    return _.find(this.ports, portModel => {
      return portModel.options.in;
    });
  }

  // Get all out ports
  getOutPorts() {
    return _.filter(this.ports, portModel => {
      return !portModel.options.in;
    });
  }

  serialize() {
    return {
      ...super.serialize(),
      dbInstance: this.dbInstance,
      addAvailableNode: this.addAvailableNode,
    };
  }

  deserialize(event) {
    super.deserialize(event);
    this.dbInstance = event.data.dbInstance;
    this.addAvailableNode = event.data.addAvailableNode;
  }
}
