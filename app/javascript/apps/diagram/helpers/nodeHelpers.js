import * as React from "react";
import I18n from "i18n-js";
import _ from "lodash";
import QuestionNodeModel from "../components/extended/QuestionDiagram/node/QuestionNodeModel";
import FinalDiagnosisNodeModel from "../components/extended/FinalDiagnosisDiagram/node/FinalDiagnosisNodeModel";
import HealthCareNodeModel from "../components/extended/HealthCareDiagram/node/HealthCareNodeModel";
import QuestionsSequenceNodeModel
  from "../components/extended/QuestionsSequenceDiagram/node/QuestionsSequenceNodeModel";

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
export const createNode = (instance, addAvailableNode, readOnly, diagramType, engine, user) => {
  let diagramNode;

  let params = {
    dbInstance: instance,
    addAvailableNode,
    locked: readOnly,
    diagramType,
    engine,
    user
  };

  switch (instance.node.node_type) {
    case "Question":
      diagramNode = new QuestionNodeModel(params);
      break;
    case "FinalDiagnosis":
      diagramNode = new FinalDiagnosisNodeModel(params);
      break;
    case "HealthCare":
      diagramNode = new HealthCareNodeModel(params);
      break;
    case "QuestionsSequence":
      diagramNode = new QuestionsSequenceNodeModel(params);
      break;
    default:
      console.log("Cette factory n'existe pas", instance.node.node_type);
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
 * @params [Object] answerPort -> inPort
 * @params [Object] diagramNode -> outPort
 * @params [Object] condition -> condition of current instance
 * @return Diagram link
 */
export const linkNode = (answerPort, diagramNode, condition) => {
  // Fetch value
  let inPort = diagramNode.getInPort();
  let link = answerPort.link(inPort);

  // Add label to display score
  if (condition.score) {
    link.addLabel(condition.score);
  }

  // Add label to display cut offs
  if (condition.cut_off_start && condition.cut_off_end) {
    link.addLabel(I18n.t("conditions.cut_off_label", {start: condition.cut_off_start, end: condition.cut_off_end}))
  }

  // Add value in link
  link.options.score = condition.score;
  link.options.dbConditionId = condition.id;
  link.options.cutOffStart = condition.cut_off_start;
  link.options.cutOffEnd = condition.cut_off_end;
  link.options.parentInstanceId = link.sourcePort.parent.options.dbInstance.id;

  return link;
};

/**
 * Link excluded final diagnosis in diagram
 * @params [Object] diagramNode -> outPort or excludingOutPort
 * @params [Integer] excludedFinalDiagnosis -> inPort or excludedInPort
 * @return Diagram port
 */
export const linkFinalDiagnosisExclusion = (diagramNode, excludedFinalDiagnosis) => {
  let excludedInPort = excludedFinalDiagnosis.getPortByName("excludedInPort");
  let excludingOutPort = diagramNode.getPortByName("excludingOutPort");

  return excludingOutPort.link(excludedInPort);
};

/**
 * Fetch a port model
 * @params [Object] diagramNodes -> list of nodes generated by diagram plugin
 * @params [Integer] answerId
 * @return Diagram port
 */
export const getConditionPort = (diagramNodes, answerId) => {
  let port = {};

  diagramNodes.map(node => {
    let ports = node.getOutPorts();
    Object.keys(ports).map(index => {
      if (ports[index].options.id === `answer_${answerId}`) {
        port = ports[index];
      }
    });
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
    <g className="arrow" transform={"translate(" + point.getPosition().x + ", " + point.getPosition().y + ")"}>
      <g style={{ transform: "rotate(" + angle + "deg)" }}>
        <g transform={"translate(0, -3)"}>
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
