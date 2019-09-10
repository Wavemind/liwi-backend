import * as React from "react";

import {DefaultLabelModel, DefaultLabelFactory} from "storm-react-diagrams";
import AdvancedLabelWidget from "../widgets/AdvancedLabelWidget";

/**
 * @author Alain Fresco
 */
class AdvancedLabelFactory extends DefaultLabelFactory {
  generateReactWidget(diagramEngine: DiagramEngine, label: DefaultLabelModel): JSX.Element {
    return <AdvancedLabelWidget model={label} />;
  }
}

export default AdvancedLabelFactory;
