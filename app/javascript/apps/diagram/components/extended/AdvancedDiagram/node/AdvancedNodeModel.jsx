import * as _ from "lodash";
import { NodeModel } from "@projectstorm/react-diagrams";

import AdvancedPortModel from "../port/AdvancedPortModel";
import Http from "../../../../engine/http";
import { NotificationManager } from "react-notifications";

export default class AdvancedNodeModel extends NodeModel {

  constructor(options = {}) {

    super({ ...options });

    this.options.type = "advanced";
    this.http = new Http();

    if (this.options.diagramType !=='scored' || (this.options.dbInstance.instanceable_id === this.options.dbInstance.node_id)) {
      // inPort
      this.addPort(
        new AdvancedPortModel({
          locked: true,
          in: true,
          name: "in",
          id: `instance_${this.options.dbInstance.id}`
        })
      );
    }

    // Set Position
    this.setPosition(this.options.dbInstance.position_x, this.options.dbInstance.position_y);

    // Set event listener
    this.registerListener({
      eventWillFire: _.debounce(
        (event) => {
          switch (event.function) {
            case "positionChanged":
              this.setPositionInstance(event);
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
  setPositionInstance = async (event) => {
    let httpRequest = await this.http.updateInstance(this.options.dbInstance.id, event.entity.position.x, event.entity.position.y, this.options.dbInstance.duration_translations.en, this.options.dbInstance.description_translations.en);
    let result = await httpRequest.json();

    if (httpRequest.status !== 200) {
      this.options.triggerEvent = false;
      this.remove();
      NotificationManager.error(result);
    }
  };

  /**
   * Remove instance in database
   */
  removeInstance = async () => {
    let httpRequest = await this.http.removeInstance(this.options.dbInstance.id);
    let result = await httpRequest.json();

    if (httpRequest.status === 200) {
      this.options.addAvailableNode(this.options.dbInstance.node);
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
      engine: this.engine,
      http: this.http,
      diagramType: this.diagramType,
    };
  }

  deserialize(event) {
    super.deserialize(event);
    this.dbInstance = event.data.dbInstance;
    this.addAvailableNode = event.data.addAvailableNode;
    this.engine = event.data.engine;
    this.diagramType = event.data.diagramType;
  }
}
