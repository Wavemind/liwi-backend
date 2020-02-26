import * as React from 'react';
import AdvancedNodeModel from "../components/advancedDiagram/node/AdvancedNodeModel";
import AdvancedPortModel from "../components/advancedDiagram/port/AdvancedPortModel";

// Create diagram node
export const createNode = (node) => {
  let advancedNode = new AdvancedNodeModel({ color: 'rgb(192,255,0)', dbNode: node });
  advancedNode.addPort(new AdvancedPortModel(false, 'out'));
  advancedNode.setPosition(100, 100);
  return advancedNode
};


// Get full label of an object
export const getLabel = (node) => {
  return node.label_translations["en"];
};

// Generate arrow for link
export const AdvancedLinkArrowWidget = props => {
  const { point, previousPoint } = props;

  const angle =
    90 +
    (Math.atan2(
      point.getPosition().y - previousPoint.getPosition().y,
      point.getPosition().x - previousPoint.getPosition().x
      ) *
      180) /
    Math.PI;

  //translate(50, -10),
  return (
    <g className="arrow" transform={'translate(' + point.getPosition().x + ', ' + point.getPosition().y + ')'}>
      <g style={{ transform: 'rotate(' + angle + 'deg)' }}>
        <g transform={'translate(0, -3)'}>
          <polygon
            points="0,10 8,30 -8,30"
            fill={props.color}
            onMouseLeave={() => {
              this.setState({ selected: false });
            }}
            onMouseEnter={() => {
              this.setState({ selected: true });
            }}
            data-id={point.getID()}
            data-linkid={point.getLink().getID()}></polygon>
        </g>
      </g>
    </g>
  );
};
