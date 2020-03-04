// External import
import * as React from "react";
import createEngine, { DiagramModel } from "@projectstorm/react-diagrams";
import { CanvasWidget } from "@projectstorm/react-canvas-core";

// Internal import
import { withDiagram } from "../../engine/context/Diagram.context";
import AdvancedLinkFactory from "../AdvancedDiagram/link/AdvancedLinkFactory";
import AdvancedNodeFactory from "../AdvancedDiagram/node/AdvancedNodeFactory";
import AdvancedNodeModel from "../AdvancedDiagram/node/AdvancedNodeModel";
import AvailableNodes from "../AvailableNodes";
import FlashMessages from "../FlashMessages";


export class Diagram extends React.Component {

  constructor(props) {
    super(props);

    const engine = createEngine();
    const model = new DiagramModel();

    // Register our own factory
    engine.getLinkFactories().registerFactory(new AdvancedLinkFactory());
    engine.getNodeFactories().registerFactory(new AdvancedNodeFactory());

    this.state = {
      engine: engine,
      model: model
    };

    this.initDiagram();
  }

  initDiagram = () => {
    const { engine, model } = this.state;
    const { questionsPerLevel, addAvailableNode } = this.props;

    let instances = [];

    // Generate questions
    questionsPerLevel.map(level => {
      level.map(instance => {
        let diagramInstance = new AdvancedNodeModel({
          dbInstance: instance,
          addAvailableNode: addAvailableNode
        });
        instances.push(diagramInstance);
        model.addAll(diagramInstance);
      });
    });

    // Load model into engine
    engine.setModel(model);
  };

  // Create instance and init it in diagram when drop
  onDropAction = async (event, positions) => {
    const { http, addMessage, addAvailableNode, removeAvailableNode } = this.props;
    const { engine } = this.state;

    let dbNode = JSON.parse(event.dataTransfer.getData("node"));
    let result = await http.createInstance(dbNode.id, positions.x, positions.y);

    // Generate node if instance creation success
    if (result.status === 200) {
      let dbInstance = await result.json();

      // Generate node
      let diagramInstance = new AdvancedNodeModel({
        dbInstance: dbInstance,
        addAvailableNode: addAvailableNode
      });

      // Display node in diagram
      engine.getModel().addNode(diagramInstance);
      engine.repaintCanvas();

      // Remove node from available nodes list
      removeAvailableNode(dbNode);
    } else {
      let messages = await result.json();
      addMessage(messages, "danger");
    }
  };

  render = () => {
    const { engine } = this.state;

    return (
      <div className="content">
        <div className="row">
          <AvailableNodes/>
          <FlashMessages/>
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
