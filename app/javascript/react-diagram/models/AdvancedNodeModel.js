import { DefaultNodeModel, DiagramEngine, Toolkit } from "storm-react-diagrams";
import AdvancedPortModel from "../models/AdvancedPortModel";
import * as _ from "lodash";
import Http from "../../http";

class AdvancedNodeModel extends DefaultNodeModel {

  constructor(node, reference, color, outPorts, addNode) {
    super("advanced");
    this.node = node;
    this.reference = reference;
    this.color = color;
    this.outPorts = outPorts;
    const http = new Http();

    // Don't trigger entity removed for AND node
    if (this.node !== 'AND') {
      this.addListener({
        entityRemoved: function(removedNode) {
          // Delete node in DB
          http.removeInstance(removedNode.entity.node.id);
          addNode(removedNode.entity.node)
        },
      });
    }
  }

  addInPort(label, reference = '', id = '') {
    let inPort = new AdvancedPortModel(true, Toolkit.UID(), label);
    inPort.setData(reference, id);
    return this.addPort(inPort);
  }

  addOutPort(label, reference = '', id = '') {
    let outPort = new AdvancedPortModel(false, Toolkit.UID(), label);
    outPort.setData(reference, id);
    return this.addPort(outPort);
  }

  deSerialize(object, engine) {
    super.deSerialize(object, engine);
    this.node = object.node;
    this.reference = object.reference;
    this.color = object.color;
    this.outPorts = object.outPorts;
  }

  serialize() {
    return _.merge(super.serialize(), {
      node: this.node,
      reference: this.reference,
      color: this.color,
      outPorts: this.outPorts,
    });
  }

  getInPorts() {
    return _.filter(this.ports, portModel => {
      return portModel.in;
    });
  }

  getInPort() {
    return _.find(this.ports, portModel => {
      return portModel.in;
    });
  }

  getOutPorts() {
    return _.filter(this.ports, portModel => {
      return !portModel.in;
    });
  }

  getOutPort() {
    return _.find(this.ports, portModel => {
      return !portModel.in;
    });
  }
}

export default AdvancedNodeModel;
