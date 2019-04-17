import { DefaultNodeModel, DiagramEngine, Toolkit } from "storm-react-diagrams";
import AdvancedPortModel from "../models/AdvancedPortModel";
import * as _ from "lodash";

class AdvancedNodeModel extends DefaultNodeModel {
  node;
  reference: string;
  color: string;
  outPorts: array;
  ports: { [s: string]: AdvancedPortModel };

  constructor(node, reference: string, color: string, outPorts) {
    super("advanced");
    this.node = node;
    this.reference = reference;
    this.color = color;
    this.outPorts = outPorts;
  }

  addInPort(label: string, reference: string = '', id: string = ''): AdvancedPortModel {
    let inPort = new AdvancedPortModel(true, Toolkit.UID(), label);
    inPort.setData(reference, id);
    return this.addPort(inPort);
  }

  addOutPort(label: string, reference: string = '', id: string = ''): AdvancedPortModel {
    let outPort = new AdvancedPortModel(false, Toolkit.UID(), label);
    outPort.setData(reference, id);
    return this.addPort(outPort);
  }

  deSerialize(object, engine: DiagramEngine) {
    super.deSerialize(object, engine);
    this.node = object.node;
    this.reference = object.reference;
    this.color = object.color;
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
}

export default AdvancedNodeModel;
