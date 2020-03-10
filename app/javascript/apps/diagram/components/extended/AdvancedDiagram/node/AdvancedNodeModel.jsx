import * as _ from "lodash";
import { NodeModel } from "@projectstorm/react-diagrams";

import AdvancedPortModel from "../port/AdvancedPortModel";
import Http from "../../../../engine/http";
import { NotificationManager } from "react-notifications";

export default class AdvancedNodeModel extends NodeModel {

  constructor(options = {}) {
    super({
      ...options,
    });
    this.options.type = "advanced";
    this.dbInstance = options.dbInstance || {};
    this.addAvailableNode = options.addAvailableNode || {};
    this.http = new Http();

    // inPort
    this.addPort(
      new AdvancedPortModel({
        locked: true,
        in: true,
        name: "in",
        id: this.dbInstance.id
      })
    );

    // Set Position
    this.setPosition(this.dbInstance.position_x, this.dbInstance.position_y);

    // Set event listener
    this.registerListener({
      eventWillFire: _.debounce(
        (event) => {
          switch(event.function) {
            case 'positionChanged':
              this.updateInstance(event);
              break;
            case 'entityRemoved':
              this.removeInstance();
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
   * Update x;y position in database
   */
  updateInstance(event) {
    this.http.updateInstance(this.dbInstance.id, event.entity.position.x, event.entity.position.y).then(httpRequest => {
      httpRequest.json().then(result => {
        if (httpRequest.status !== 200) {
          this.triggerEvent = false;
          this.remove();
          NotificationManager.error(result);
        }
      });
    });
  }

  /**
   * Remove instance in database
   */
  removeInstance() {
    this.http.removeInstance(this.dbInstance.id).then(httpRequest => {
      httpRequest.json().then(result => {
        if (httpRequest.status === 200) {
          this.addAvailableNode(this.dbInstance.node);
        } else {
          this.triggerEvent = false;
          this.remove();
          NotificationManager.error(result);
        }
      });
    });
  }

  /**
   * Get single in port
   * @return in port
   */
  getInPort() {
    return _.find(this.ports, portModel => {
      return portModel.options.in;
    });
  }

  getPortByName(name) {
    return _.find(this.ports, portModel => {
      return portModel.options.name === name;
    });
  }

  /**
   * Get all out port
   * @return array of out port
   */
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
      http: this.http,
    };
  }

  deserialize(event) {
    super.deserialize(event);
    this.dbInstance = event.data.dbInstance;
    this.addAvailableNode = event.data.addAvailableNode;
  }
}
