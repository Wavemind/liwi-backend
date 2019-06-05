import { DefaultNodeModel, DiagramEngine, Toolkit } from "storm-react-diagrams";
import AdvancedPortModel from "../models/AdvancedPortModel";
import * as _ from "lodash";
import Http from "../../http";

class AdvancedNodeModel extends DefaultNodeModel {
  node;
  reference: string;
  color: string;
  outPorts: array;
  ports: { [s: string]: AdvancedPortModel };
  addNode;
  isReadOnly: boolean;

  constructor(node, reference: string, color: string, outPorts, addNode, isReadOnly) {
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

  addInPort(label: string, reference: string = '', id: string = ''): AdvancedPortModel {
    let inPort = new AdvancedPortModel(true, Toolkit.UID(), label);
    inPort.setData(reference, id, this.isReadOnly);
    return this.addPort(inPort);
  }

  addOutPort(label: string, reference: string = '', id: string = ''): AdvancedPortModel {
    let outPort = new AdvancedPortModel(false, Toolkit.UID(), label);
    outPort.setData(reference, id, this.isReadOnly);
    return this.addPort(outPort);
  }

  deSerialize(object, engine: DiagramEngine) {
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

  getInPorts(): AdvancedPortModel[] {
    return _.filter(this.ports, portModel => {
      return portModel.in;
    });
  }

  getInPort(): AdvancedPortModel[] {
    return _.find(this.ports, portModel => {
      return portModel.in;
    });
  }

  getOutPorts(): AdvancedPortModel[] {
    return _.filter(this.ports, portModel => {
      return !portModel.in;
    });
  }

  getOutPort(): AdvancedPortModel[] {
    return _.find(this.ports, portModel => {
      return !portModel.in;
    });
  }
  isLocked() {
    return this.isReadOnly;
  }
}

export default AdvancedNodeModel;
