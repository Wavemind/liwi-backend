import { DefaultPortModel } from "storm-react-diagrams";
import AdvancedLinkModel from "../models/AdvancedLinkModel";

class AdvancedPortModel extends DefaultPortModel {
  createLinkModel(): AdvancedLinkModel | null {
    return new AdvancedLinkModel();
  }
}

export default AdvancedPortModel;
