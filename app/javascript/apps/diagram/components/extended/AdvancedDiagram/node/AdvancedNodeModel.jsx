import * as _ from "lodash";
import { NodeModel } from "@projectstorm/react-diagrams";

import AdvancedPortModel from "../port/AdvancedPortModel";
import Http from "../../../../engine/http";
import { NotificationManager } from "react-notifications";

export default class AdvancedNodeModel extends NodeModel {

  constructor(options = {}) {

    super({ ...options });

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
          switch (event.function) {
            case "positionChanged":
              this.setInstancePosition(event);
              break;
            case "entityRemoved":
              if (!this.locked) {
                this.removeInstance();
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
   * Update x;y position in database
   * @params [Object] event
   */
  setInstancePosition = async (event) => {
    let httpRequest = await this.http.setInstancePosition(this.dbInstance.id, event.entity.position.x, event.entity.position.y);
    let result = await httpRequest.json();

    if (httpRequest.status !== 200) {
      this.triggerEvent = false;
      this.remove();
      NotificationManager.error(result);
    }
  };

  /**
   * Remove instance in database
   */
  removeInstance = async () => {
    let httpRequest = await this.http.removeInstance(this.dbInstance.id);
    let result = await httpRequest.json();

    if (httpRequest.status === 200) {
      this.addAvailableNode(this.dbInstance.node);
    } else {
      this.triggerEvent = false;
      this.remove();
      NotificationManager.error(result);
    }
  };

  /**
   * Get single in port
   * @return in port
   */
  getInPort() {
    return _.find(this.ports, portModel => {
      return portModel.options.in;
    });
  }

  /**
   * Get single in port by name
   * @params [String] name
   * @return in port
   */
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
      http: this.http
    };
  }

  deserialize(event) {
    super.deserialize(event);
    this.dbInstance = event.data.dbInstance;
    this.addAvailableNode = event.data.addAvailableNode;
  }
}
