import * as React from 'react';
import AdvancedNodeModel from "../components/advancedDiagram/node/AdvancedNodeModel";


// @params [object] instance
// Create diagram node
export const createNode = (instance) => {
  let advancedNode = new AdvancedNodeModel({ color: 'rgb(192,255,0)', dbInstance: instance });

  // Node position
  advancedNode.setPosition(100, 100);

  // Set event listener
  advancedNode.registerListener({
    eventDidFire: _.debounce(
      () =>
        console.log('je test'),
      100
    )
  });

  return advancedNode
};

// @params [object] node
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

  return (
    <g className="arrow" transform={'translate(' + point.getPosition().x + ', ' + point.getPosition().y + ')'}>
      <g style={{ transform: 'rotate(' + angle + 'deg)' }}>
        <g transform={'translate(0, -3)'}>
          <polygon
            points="0,9 7,30 -7,30"
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
