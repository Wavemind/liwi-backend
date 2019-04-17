import * as _ from "lodash";
import { DefaultPortModel, } from "storm-react-diagrams";
import AdvancedLinkModel from "../models/AdvancedLinkModel";

class AdvancedPortModel extends DefaultPortModel {

  in: boolean;
  label: string;
  reference: string;
  dbId: string;
  links: { [id: string]: AdvancedLinkModel };

  deSerialize(object, engine: DiagramEngine) {
    super.deSerialize(object, engine);
    this.in = object.in;
    this.label = object.label;
  }

  serialize() {
    return _.merge(super.serialize(), {
      in: this.in,
      label: this.label,
    });
  }

  link(port: PortModel): AdvancedLinkModel {
    let link = this.createLinkModel();
    link.setSourcePort(this);
    link.setTargetPort(port);
    return link;
  }

  canLinkToPort(port: PortModel): boolean {
    if (port instanceof DefaultPortModel) {
      return this.in !== port.in;
    }
    return true;
  }

  setData(reference, id) {
    this.reference = reference;
    this.dbId = id;
  }

  createLinkModel(): AdvancedLinkModel | null {
    return new AdvancedLinkModel();
  }
}

export default AdvancedPortModel;
