import * as React from "react";

import { DefaultLinkFactory, DiagramEngine, Toolkit } from "storm-react-diagrams";
import AdvancedLinkModel from "../models/AdvancedLinkModel";
import AdvancedLinkWidget from "../widgets/AdvancedLinkWidget";

/**
 * @author Alain Fresco
 */
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

  /**
   * Set link path marker head regarding to the link path direction
   * @method setPathMarker
   * @param inversed - is the path inversed
   * @return style object with marker
   */
  setPathMarker(inversed){
    if(inversed) {
      return {
        markerStart: `url(#${markerHeadInversed})`
      };
    } else {
      return {
        markerEnd: `url(#${markerHead})`
      };
    }
  };


  generateLinkSegment(
    model: AdvancedLinkModel,
    widget: AdvancedLinkWidget,
    selected: boolean,
    path: string,
    inversed: boolean,
  ): JSX.Element {

    let markerId = Toolkit.UID();
    let markerIdInverse = Toolkit.UID();

    let markerEndUrl = (!inversed ? ("url(#"+markerId+")"): "");
    let markerStartUrl = (inversed ? ("url(#"+markerIdInverse+")"): "");

    let displayArrow = widget.props.link.arrow;
    let displaySeparator = widget.props.link.separator;

    return (
      <g className={displaySeparator ? widget.bem(" separator-link") : ""}>
        {displayArrow === true ? (
        <defs>
          <marker id={markerId} markerWidth="6" markerHeight="4" refX="8.5" refY="2" orient="auto">
            <path d="M0,0 L0,4 L5,2 Z" style={{fill: "#000", stroke: 'none'}} />
          </marker>

          <marker id={markerIdInverse} markerWidth="6" markerHeight="4" refX="-2" refY="2" orient="auto">
            <path d="M8,0 L4,4 L0,2 Z" style={{fill: "#000", stroke: 'none'}} />
          </marker>
        </defs>) : ''}
        <path
          className={selected ? widget.bem("--path-selected") : ""}
          fill= "none"
          strokeWidth={model.width}
          stroke={model.color}
          d={path}
          markerEnd={markerEndUrl}
          markerStart={markerStartUrl}
        />
      </g>
    );
  };
}

export default AdvancedLinkFactory;
