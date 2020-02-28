import * as React from 'react';

// @params [object] node
// Get full label of an object
export const getLabel = (node) => {
  return node.label_translations["en"];
};

// @params node
// Find category
export const getCategoryNode = (node) => {
  let category = null;
  if (node.node_type === "Question" || node.node_type === "QuestionsSequence" || node.node_type === "HealthCare") {
    category = _.camelCase(node.category_name);
  } else {
    category = _.camelCase(node.node_type);
  }
  return category;
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
