import { DefaultNodeModel, DiagramEngine, Toolkit } from "storm-react-diagrams";
import AdvancedPortModel from "../models/AdvancedPortModel";
import * as _ from "lodash";
import Http from "../../http";

class AdvancedNodeModel extends DefaultNodeModel {
  node;
  reference;
  minScore;
  color;
  outPorts;
  ports: { [s] };
  addNode;
  isReadOnly;

  constructor(node, reference, color, outPorts, addNode, isReadOnly) {
    super("advanced");
    this.node = node;
    this.reference = reference;
    this.color = color;
    this.outPorts = outPorts;
    this.isReadOnly = isReadOnly;
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
    inPort.setData(reference, id, this.isReadOnly);
    return this.addPort(inPort);
  }

  addOutPort(label, reference = '', id = '') {
    let outPort = new AdvancedPortModel(false, Toolkit.UID(), label);
    outPort.setData(reference, id, this.isReadOnly);
    return this.addPort(outPort);
  }

  deSerialize(object, engine) {
    super.deSerialize(object, engine);
    this.node = object.node;
    this.reference = object.reference;
    this.minScore = object.minScore;
    this.color = object.color;
    this.outPorts = object.outPorts;
  }

  serialize() {
    return _.merge(super.serialize(), {
      node: this.node,
      reference: this.reference,
      minScore: this.minScore,
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

  isLocked() {
    return this.isReadOnly;
  }

  setReference(reference) {
    return this.reference = reference
  }

  setMinScore(minScore) {
    return this.minScore = minScore
  }

  setNode(node) {
    return this.node = node
  }
}

export default AdvancedNodeModel;
