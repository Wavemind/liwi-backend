import * as _ from "lodash";
import { DefaultPortModel, } from "storm-react-diagrams";
import AdvancedLinkModel from "../models/AdvancedLinkModel";

class AdvancedPortModel extends DefaultPortModel {

  setData(reference, id) {
    this.reference = reference;
    this.dbId = id;
  }

  createLinkModel() {
    return new AdvancedLinkModel();
  }
}

export default AdvancedPortModel;
