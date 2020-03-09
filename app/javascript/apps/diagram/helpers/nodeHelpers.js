import * as React from 'react';
import _ from "lodash";
import QuestionNodeModel from "../components/extended/QuestionDiagram/node/QuestionNodeModel";
import FinalDiagnosticNodeModel from "../components/extended/FinalDiagnosticDiagram/node/FinalDiagnosticNodeModel";

/**
 * Get full label of an object
 * @params [Object] node
 * @return label of node
 */
export const getLabel = (node) => {
  return node.label_translations["en"];
};

/**
 * Generate diagram node by instance type
 * @params [Object] instance
 * @params [Function] addAvailableNode
 * @return diagram node
 */
export const createNode = (instance, addAvailableNode) => {
  let diagramNode;

  switch(instance.node.node_type) {
    case 'Question':
      diagramNode = new QuestionNodeModel({
        dbInstance: instance,
        addAvailableNode: addAvailableNode
      });
      break;
    case 'FinalDiagnostic':
      diagramNode = new FinalDiagnosticNodeModel({
        dbInstance: instance,
        addAvailableNode: addAvailableNode
      });
      break;
    default:
      console.log("bah je suis la")
      break;
  }

  return diagramNode;
};

/**
 * Get full label of an object
 * @params [Object] node
 * @return label of category
 */
export const getCategoryNode = (node) => {
  let category = "";
  if (node.node_type === "Question" || node.node_type === "QuestionsSequence" || node.node_type === "HealthCare") {
    category = _.camelCase(node.category_name);
  } else {
    category = _.camelCase(node.node_type);
  }
  return category;
};

/**
 * Link node
 * @params [Object] diagramNodes -> list of nodes generated by diagram plugin
 * @params [Object] diagramNode -> current diagram node
 * @params [Object] condition -> condition of current instance
 * @return Diagram link
 */
export const linkNode = (diagramNodes, diagramNode, condition) => {
  // Fetch value
  let inPort = diagramNode.getInPort();
  let answerPort = getConditionPort(diagramNodes, condition.first_conditionable_id);
  let link = answerPort.link(inPort);

  // Add value in link
  link.dbConditionId = condition.id;
  link.parentInstanceId = link.sourcePort.parent.options.dbInstance.id;

  return link;
};

/**
 * Get full label of an object
 * @params [Object] diagramNodes -> list of nodes generated by diagram plugin
 * @params [Integer] answerId
 * @return Diagram port
 */
export const getConditionPort = (diagramNodes, answerId) => {
  let port = {};

  diagramNodes.map(node => {
    let ports = node.getOutPorts();
    Object.keys(ports).map(index => {
      if (ports[index].options.id === answerId) {
        port = ports[index];
      }
    })
  });

  return port;
};

/**
 * Generate an arrow for link
 * @return SVG of an arrow
 */
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
