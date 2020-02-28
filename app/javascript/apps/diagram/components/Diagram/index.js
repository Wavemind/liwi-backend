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
      model: model,
    };

    this.initDiagram();
  }

  initDiagram = () => {
    const {engine, model} = this.state;
    const {questionsPerLevel} = this.props;

    let instances = [];

    // Generate questions
    questionsPerLevel.map(level => {
      level.map(instance => {
        let diagramInstance = new AdvancedNodeModel({ dbInstance: instance });
        instances.push(diagramInstance);
        model.addAll(diagramInstance);
      })
    });

    // Load model into engine
    engine.setModel(model);
  };

  render = () => {
    const {engine} = this.state;

    return (
      <div className="content">
        <div className="row">
          <AvailableNodes/>
          <div className="col diagram-wrapper">
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
