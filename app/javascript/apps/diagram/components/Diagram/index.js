// External import
import * as React from "react";
import createEngine, { DiagramModel } from "@projectstorm/react-diagrams";
import { NotificationContainer, NotificationManager } from "react-notifications";

// Internal import
import { withDiagram } from "../../engine/context/Diagram.context";
import { linkNode, createNode, linkFinalDiagnosticExclusion, getConditionPort } from "../../helpers/nodeHelpers";
import AdvancedCanvasWidget from "../extended/AdvancedDiagram/canvas/AdvancedCanvasWidget";
import AvailableNodes from "../AvailableNodes";
import AdvancedItemsActions from "../extended/AdvancedDiagram/AdvancedItemsActions";

import AdvancedLinkFactory from "../extended/AdvancedDiagram/link/AdvancedLinkFactory";
import AdvancedNodeFactory from "../extended/AdvancedDiagram/node/AdvancedNodeFactory";

import QuestionLinkFactory from "../extended/QuestionDiagram/link/QuestionLinkFactory";
import QuestionNodeFactory from "../extended/QuestionDiagram/node/QuestionNodeFactory";

import FinalDiagnosticLinkFactory from "../extended/FinalDiagnosticDiagram/link/FinalDiagnosticLinkFactory";
import FinalDiagnosticNodeFactory from "../extended/FinalDiagnosticDiagram/node/FinalDiagnosticNodeFactory";

import HealthCareLinkFactory from "../extended/HealthCareDiagram/link/HealthCareLinkFactory";
import HealthCareNodeFactory from "../extended/HealthCareDiagram/node/HealthCareNodeFactory";

import QuestionsSequenceLinkFactory from "../extended/QuestionsSequenceDiagram/link/QuestionsSequenceLinkFactory";
import QuestionsSequenceNodeFactory from "../extended/QuestionsSequenceDiagram/node/QuestionsSequenceNodeFactory";

export class Diagram extends React.Component {

  constructor(props) {
    super(props);

    const engine = createEngine({registerDefaultDeleteItemsAction: false});
    const model = new DiagramModel();

    // Override deleteKeys to control remove of node
    engine.eventBus.registerAction(new AdvancedItemsActions());

    // Register our own factory
    engine.getLinkFactories().registerFactory(new AdvancedLinkFactory());
    engine.getNodeFactories().registerFactory(new AdvancedNodeFactory());

    engine.getLinkFactories().registerFactory(new QuestionLinkFactory());
    engine.getNodeFactories().registerFactory(new QuestionNodeFactory());

    engine.getLinkFactories().registerFactory(new FinalDiagnosticLinkFactory());
    engine.getNodeFactories().registerFactory(new FinalDiagnosticNodeFactory());

    engine.getLinkFactories().registerFactory(new HealthCareLinkFactory());
    engine.getNodeFactories().registerFactory(new HealthCareNodeFactory());

    engine.getLinkFactories().registerFactory(new QuestionsSequenceLinkFactory());
    engine.getNodeFactories().registerFactory(new QuestionsSequenceNodeFactory());

    this.state = {
      engine: engine,
      model: model
    };

    this.initDiagram();
  }

  initDiagram = () => {
    const { engine, model } = this.state;
    const { instances, addAvailableNode, readOnly } = this.props;

    let diagramNodes = [];

    // Generate questions
    instances.map(instance => {
      let diagramNode = createNode(instance, addAvailableNode, readOnly, this.props.instanceable.category_name);
      diagramNodes.push(diagramNode);
      model.addAll(diagramNode);
    });

    // Generate link
    diagramNodes.map(diagramNode => {

      // Link between nodes
      diagramNode.dbInstance.conditions.map(condition => {
        let answerPort = getConditionPort(diagramNodes, condition.first_conditionable_id);
        let link = linkNode(answerPort, diagramNode, condition);
        model.addLink(link);
      });

      //  Exclusion link
      if (diagramNode.dbInstance.node.final_diagnostic_id !== null) {
        let excludedFinalDiagnostic = _.find(diagramNodes, (node) => {
          return node.options.dbInstance.node_id === diagramNode.dbInstance.node.final_diagnostic_id;
        });
        let link = linkFinalDiagnosticExclusion(diagramNode, excludedFinalDiagnostic);
        model.addLink(link);
      }
    });

    if (readOnly) {
      model.setLocked();
    }

    // Load model into engine
    engine.setModel(model);
  };

  // Create instance and init it in diagram when drop
  onDropAction = async (event) => {
    const { http, addAvailableNode, removeAvailableNode, readOnly } = this.props;
    const { engine } = this.state;

    let positions = engine.getRelativeMousePoint(event);
    let dbNode = JSON.parse(event.dataTransfer.getData("node"));
    let httpRequest = await http.createInstance(dbNode.id, positions.x, positions.y);
    let result = await httpRequest.json();

    // Generate node if instance creation success
    if (httpRequest.status === 200) {
      // Generate node
      let diagramInstance = createNode(result, addAvailableNode, readOnly, this.props.instanceable.category_name);

      // Display node in diagram
      engine.getModel().addNode(diagramInstance);
      engine.repaintCanvas();

      // Remove node from available nodes list
      removeAvailableNode(dbNode);
    } else {
      NotificationManager.error(result);
    }
  };

  render = () => {
    const { readOnly } = this.props;
    const { engine } = this.state;

    let diagramStyle = readOnly ? "col diagram-wrapper-white" : "col diagram-wrapper";
    let canvasStyle = readOnly ? "canvas srd-canvas-read-only" : "canvas srd-canvas";

    return (
      <div className="content">
        <div className="row">
          {!readOnly ? ([
            <AvailableNodes/>,
            <NotificationContainer/>
          ]) : null}
          <div className={diagramStyle}
               onDrop={event => this.onDropAction(event)}
               onDragOver={event => {
                 event.preventDefault();
               }}>
            <AdvancedCanvasWidget
              className={canvasStyle}
              engine={engine}
              allowCanvasZoom={false}
            />
          </div>
        </div>
      </div>
    );
  };
}

export default withDiagram(Diagram);
