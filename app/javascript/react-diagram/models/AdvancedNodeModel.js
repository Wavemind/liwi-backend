import { DefaultNodeModel, DiagramEngine, Toolkit } from "storm-react-diagrams";
import AdvancedPortModel from "../models/AdvancedPortModel";
import * as _ from "lodash";

class AdvancedNodeModel extends DefaultNodeModel {
  // Set ALL DATA HERE !!
  name: string;
  color: string;
  reference: string;
  dbId;
  ports: { [s: string]: AdvancedPortModel };

  constructor(name: string = "Untitled", reference: string, dbId, color: string = "rgb(255,255,255)") {
    super("advanced");
    this.name = name;
    this.color = color;
    this.reference= reference;
    this.dbId= dbId;
  }

  addInPort(label: string): AdvancedPortModel {
    return this.addPort(new AdvancedPortModel(true, Toolkit.UID(), label));
  }

  addOutPort(label: string): AdvancedPortModel {
    return this.addPort(new AdvancedPortModel(false, Toolkit.UID(), label));
  }

  deSerialize(object, engine: DiagramEngine) {
    super.deSerialize(object, engine);
    this.name = object.name;
    this.color = object.color;
  }

  serialize() {
    return _.merge(super.serialize(), {
      name: this.name,
      color: this.color
    });
  }

  getInPorts(): AdvancedPortModel[] {
    return _.filter(this.ports, portModel => {
      return portModel.in;
    });
  }

  getOutPorts(): AdvancedPortModel[] {
    return _.filter(this.ports, portModel => {
      return !portModel.in;
    });
  }
}

export default AdvancedNodeModel;
