// External import
import * as React from "react";
import createEngine, { DiagramModel } from "@projectstorm/react-diagrams";
import { CanvasWidget } from "@projectstorm/react-canvas-core";

// Internal import
import { withDiagram } from "../context/Diagram.context";
import AdvancedLinkFactory from "./advancedDiagram/link/AdvancedLinkFactory";
import AdvancedNodeFactory from "./advancedDiagram/node/AdvancedNodeFactory";
import AdvancedNodeModel from "./advancedDiagram/node/AdvancedNodeModel";
import AdvancedPortModel from "./advancedDiagram/port/AdvancedPortModel";
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
    console.log(this.props);

    // Generate questions
    questionsPerLevel.map(level => {
      level.map(question => {
        questions.push(createNode(question))
      })
    });

    // const node1 = new AdvancedNodeModel({ color: 'rgb(192,255,0)' });
    // let port1 = node1.addPort(new AdvancedPortModel(false, 'out'));
    // node1.setPosition(100, 100);
    //
    // const node2 = new AdvancedNodeModel({ color: 'rgb(0,192,255)' });
    // let port2 = node2.addPort(new AdvancedPortModel(true, 'in'));
    // node2.setPosition(500, 350);
    //
    // const node3 = new AdvancedNodeModel('Source', 'rgb(0,192,255)');
    // let port3 = node3.addPort(new AdvancedPortModel(false, 'out'));
    // node3.setPosition(100, 500);
    //
    // const node4 = new AdvancedNodeModel('Target', 'rgb(192,255,0)');
    // let port4 = node4.addPort(new AdvancedPortModel(true, 'in'));
    // node4.setPosition(500, 450);
    //
    // model.addAll(port1.link(port2), port3.link(port4));

    console.log(questions);

    // add everything else
    model.addAll(questions);

    // load model into engine
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
