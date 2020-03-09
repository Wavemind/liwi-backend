// External import
import * as React from "react";
import createEngine, { DiagramModel } from "@projectstorm/react-diagrams";
import { CanvasWidget } from "@projectstorm/react-canvas-core";
import {NotificationContainer, NotificationManager} from 'react-notifications';

// Internal import
import { withDiagram } from "../../engine/context/Diagram.context";
import { linkNode, createNode } from "../../helpers/nodeHelpers";
import AvailableNodes from "../AvailableNodes";

import QuestionNodeModel from "../extended/QuestionDiagram/node/QuestionNodeModel";

import QuestionLinkFactory from "../extended/QuestionDiagram/link/QuestionLinkFactory";
import QuestionNodeFactory from "../extended/QuestionDiagram/node/QuestionNodeFactory";

import FinalDiagnosticLinkFactory from "../extended/FinalDiagnosticDiagram/link/FinalDiagnosticLinkFactory";
import FinalDiagnosticNodeFactory from "../extended/FinalDiagnosticDiagram/node/FinalDiagnosticNodeFactory";

export class Diagram extends React.Component {

  constructor(props) {
    super(props);

    const engine = createEngine();
    const model = new DiagramModel();

    // Register our own factory
    engine.getLinkFactories().registerFactory(new QuestionLinkFactory());
    engine.getNodeFactories().registerFactory(new QuestionNodeFactory());

    engine.getLinkFactories().registerFactory(new FinalDiagnosticLinkFactory());
    engine.getNodeFactories().registerFactory(new FinalDiagnosticNodeFactory());

    this.state = {
      engine: engine,
      model: model
    };

    this.initDiagram();
  }

  initDiagram = () => {
    const { engine, model } = this.state;
    const { instances, addAvailableNode } = this.props;

    let diagramNodes = [];

    // Generate questions
    instances.map(instance => {
      let diagramNode = createNode(instance, addAvailableNode);
      diagramNodes.push(diagramNode);
      model.addAll(diagramNode);
    });

    // Generate link between nodes
    diagramNodes.map(diagramNode => {
      diagramNode.dbInstance.conditions.map(condition => {
        let link = linkNode(diagramNodes, diagramNode, condition);
        model.addLink(link)
      });
    });

    // Load model into engine
    engine.setModel(model);
  };

  // Create instance and init it in diagram when drop
  onDropAction = async (event, positions) => {
    const { http, addAvailableNode, removeAvailableNode } = this.props;
    const { engine } = this.state;

    let dbNode = JSON.parse(event.dataTransfer.getData("node"));
    let httpRequest = await http.createInstance(dbNode.id, positions.x, positions.y);
    let result = await httpRequest.json();

    // Generate node if instance creation success
    if (httpRequest.status === 200) {
      // Generate node
      let diagramInstance = createNode(result, addAvailableNode);

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
    const { engine } = this.state;

    return (
      <div className="content">
        <div className="row">
          <AvailableNodes/>
          <NotificationContainer/>
          <div className="col diagram-wrapper"
               onDrop={event => {
                 let positions = engine.getRelativeMousePoint(event);
                 this.onDropAction(event, positions);
               }}
               onDragOver={event => {
                 event.preventDefault();
               }}>
            <CanvasWidget
              className="srd-canvas"
              engine={engine}
            />
          </div>
        </div>
      </div>
    );
  };
}

export default withDiagram(Diagram);
