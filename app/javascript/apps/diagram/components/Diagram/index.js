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
    const { questionsPerLevel } = this.props;

    let instances = [];

    // Generate questions
    questionsPerLevel.map(level => {
      level.map(instance => {
        let diagramInstance = new AdvancedNodeModel({ dbInstance: instance });
        instances.push(diagramInstance);
        model.addAll(diagramInstance);
      });
    });

    // Load model into engine
    engine.setModel(model);
  };

  // Create instance and init it in diagram when drop
  onDropAction = async (event) => {
    const { http, addMessage } = this.props;

    let dbNode = JSON.parse(event.dataTransfer.getData("node"));
    let result = await http.createInstance(dbNode.id);

    if (result.status === 200) {

    } else {
      let messages = await result.json();
      addMessage(messages, 'danger');
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
               onDrop={event => this.onDropAction(event)}
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
