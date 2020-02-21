import * as React from "react";
import createEngine, { DiagramModel, DefaultNodeModel, DefaultPortModel } from "@projectstorm/react-diagrams";
import { CanvasWidget } from "@projectstorm/react-canvas-core";

import { withDiagram } from "../context/Diagram.context";
import AdvancedLinkFactory from "./advancedDiagram/AdvancedLinkFactory";
import AdvancedPortModel from "./advancedDiagram/AdvancedPortModel";

class Diagram extends React.Component {

  constructor() {
    super();
  }

  render = () => {

    //1) setup the diagram engine
    var engine = createEngine();
    engine.getLinkFactories().registerFactory(new AdvancedLinkFactory());

    // create some nodes
    var node1 = new DefaultNodeModel("Source", "rgb(0,192,255)");
    let port1 = node1.addPort(new AdvancedPortModel(false, "out-1", "Out thick"));
    let port2 = node1.addPort(new DefaultPortModel(false, "out-2", "Out default"));
    node1.setPosition(100, 100);

    var node2 = new DefaultNodeModel("Target", "rgb(192,255,0)");
    var port3 = node2.addPort(new AdvancedPortModel(true, "in-1", "In thick"));
    var port4 = node2.addPort(new DefaultPortModel(true, "in-2", "In default"));
    node2.setPosition(300, 100);

    var node3 = new DefaultNodeModel("Source", "rgb(0,192,255)");
    node3.addPort(new AdvancedPortModel(false, "out-1", "Out thick"));
    node3.addPort(new DefaultPortModel(false, "out-2", "Out default"));
    node3.setPosition(100, 200);

    var node4 = new DefaultNodeModel("Target", "rgb(192,255,0)");
    node4.addPort(new AdvancedPortModel(true, "in-1", "In thick"));
    node4.addPort(new DefaultPortModel(true, "in-2", "In default"));
    node4.setPosition(300, 200);

    var model = new DiagramModel();

    model.addAll(port1.link(port3), port2.link(port4));

    // add everything else
    model.addAll(node1, node2, node3, node4);

    // load model into engine
    engine.setModel(model);

    return (
      <div className="content">
        <div className="row">
          <div className="col-md-2 px-0 liwi-sidebar">
          </div>
          <div
            className="col diagram-wrapper"
          >
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
