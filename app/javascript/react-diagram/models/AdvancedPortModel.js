import * as _ from "lodash";
import { DefaultPortModel, } from "storm-react-diagrams";
import AdvancedLinkModel from "../models/AdvancedLinkModel";
import Http from "../../http";

class AdvancedPortModel extends DefaultPortModel {

  in;
  label;
  reference;
  dbId;
  links = {};
  isReadOnly;

  constructor(isInput, name, label = null, id) {
    super(name, "default", id);
    this.in = isInput;
    this.label = label || name;
    this.name = id;
  }

  deSerialize(object, engine) {
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

  link(port){
    let link = this.createLinkModel();
    link.setSourcePort(this);
    link.setTargetPort(port);
    return link;
  }

  canLinkToPort(port) {
    if (port instanceof DefaultPortModel) {
      return this.in !== port.in;
    }
    return true;
  }

  setData(reference, id, isReadOnly) {
    this.reference = reference;
    this.dbId = id;
    this.isReadOnly = isReadOnly;
  }

  setName(name) {
    this.name = name;
  }

  createLinkModel() {
    return new AdvancedLinkModel(this.isReadOnly);
  }

  isLocked() {
    return this.isReadOnly;
  }
}

export default AdvancedPortModel;
