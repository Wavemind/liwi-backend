// External import
import * as React from "react";
import createEngine, { DiagramModel } from "@projectstorm/react-diagrams";
import { CanvasWidget } from "@projectstorm/react-canvas-core";

// Internal import
import { withDiagram } from "../context/Diagram.context";
import AdvancedLinkFactory from "./advancedDiagram/link/AdvancedLinkFactory";
import AdvancedNodeFactory from "./advancedDiagram/node/AdvancedNodeFactory";
import {createNode} from "../helpers/nodeHelpers";


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

    let questions = [];

    // Generate questions
    questionsPerLevel.map(level => {
      level.map(question => {
        let questionNode = createNode(question);
        questions.push(questionNode);
        model.addAll(questionNode);
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
          <div className="col-md-2 px-0 liwi-sidebar">
          </div>
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
