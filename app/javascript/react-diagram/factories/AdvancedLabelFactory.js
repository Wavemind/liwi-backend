import * as React from "react";

import {DefaultLabelModel, DefaultLabelFactory} from "storm-react-diagrams";
import AdvancedLabelWidget from "../widgets/AdvancedLabelWidget";

/**
 * @author Alain Fresco
 */
class AdvancedLabelFactory extends DefaultLabelFactory {
  generateReactWidget(DiagramEngine, DefaultLabelModel) {
    return <AdvancedLabelWidget model={label} />;
  }
}

export default AdvancedLabelFactory;
