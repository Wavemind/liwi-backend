import * as React from "react";

import { DefaultLinkFactory, DiagramEngine, Toolkit } from "storm-react-diagrams";
import AdvancedLinkModel from "../models/AdvancedLinkModel";
import AdvancedLinkWidget from "../widgets/AdvancedLinkWidget";

class AdvancedLinkFactory extends DefaultLinkFactory {
  constructor() {
    super("advanced");
  }

  generateReactWidget(diagramEngine: DiagramEngine, link: AdvancedLinkModel): JSX.Element {
    return React.createElement(AdvancedLinkWidget, {
      link: link,
      diagramEngine: diagramEngine
    });
  }

  getNewInstance(initialConfig?: any): AdvancedLinkModel {
    return new AdvancedLinkModel();
  }

  generateLinkSegment(model: AdvancedLinkModel, widget: AdvancedLinkWidget, selected: boolean, path: string, startMarkerId: string = "-", endMarkerId: string = "-") {
    let markerId= Toolkit.UID();
    let markerEndUrl = "url(#"+markerId+")";
    let displayArrow = widget.props.link.arrow;
    let displaySeparator = widget.props.link.separator;

    return (
      <g className={displaySeparator ? widget.bem(" separator-link") : ""}>
        {displayArrow === true ? (
        <defs>
          <marker id={markerId} markerWidth="6" markerHeight="4" refX="11.5" refY="2" orient="auto">
            <path d="M0,0 L0,4 L5,2 Z" style={{fill: "#000", stroke: 'none'}} />
          </marker>

          <marker id={markerEndUrl} markerWidth="6" markerHeight="4" refX="-1" refY="2" orient="auto">
            <path d="M4,0 L4,4 L0,2 Z" style={{fill: "#000", stroke: 'none'}} />
          </marker>
        </defs>) : ''}
        <path
          className={selected ? widget.bem("--path-selected") : ""}
          fill= "none"
          strokeWidth={model.width}
          stroke={model.color}
          d={path}
          markerEnd={markerEndUrl}
        />
      </g>
    );
  }
}

export default AdvancedLinkFactory;
