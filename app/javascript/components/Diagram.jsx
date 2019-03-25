import {
  DiagramEngine,
  DiagramModel,
  DefaultNodeModel,
  LinkModel,
  DiagramWidget
} from "storm-react-diagrams";
import * as React from "react";
import * as _ from "lodash";

class Diagram extends React.Component {
  render = () => {
    const {
      diagnostic,
      finalDiagnostics,
      healthCares
    } = this.props;


    //1) setup the diagram engine
    let engine = new DiagramEngine();
    engine.installDefaultFactories();

    //2) setup the diagram model
    let model = new DiagramModel();

    let nodes = [];

    let yPosition = 0;
    // PS and QUESTIONS
    diagnostic.map((levels, i) => (
      levels.map((relation, j) => {
        let node = new DefaultNodeModel(relation.node.reference, "rgb(0,192,255)");
        yPosition = i * 120;
        node.setPosition(j * 200, yPosition);
        relation.node.answers.map((answer) => (node.addOutPort(answer.reference)));
        node.addInPort(relation.node.reference);
        nodes.push(node);
        model.addAll(node);
      })
    ));

    let instances = diagnostic.flat();

    // Display final diagnostics
    finalDiagnostics.map((df, index) => {
      let node = new DefaultNodeModel(`${df.reference}`, "rgb(0,192,255)");
      yPosition += 120;
      node.setPosition(index  * 200, yPosition);
      node.addInPort(df.reference);
      nodes.push(node);
      model.addAll(node);
      instances.push(df.instances[0])
    });

    nodes.map((node, index) => {
      instances[index].conditions.map((condition) => {

        let nodeAnswer = condition.first_conditionable.node.reference;
        let firstAnswer = _.filter(nodes, ["name", nodeAnswer])[0];

        if (condition.second_conditionable_id !== null && condition.operator === 'and_operator'){
          let nodeAnswer = condition.second_conditionable.node.reference;
          let secondAnswer = _.filter(nodes, ["name", nodeAnswer])[0];

          let andNode = new DefaultNodeModel(` `, "rgba(0,0,0, 0)");
          andNode.setPosition( Math.min(firstAnswer.x, secondAnswer.x) + 150, firstAnswer.y + 80);
          andNode.addOutPort(' ');
          andNode.addInPort(' ');


          let firstLink = firstAnswer.getOutPorts()[0].link(andNode.getInPorts()[0]);
          let secondLink = secondAnswer.getOutPorts()[0].link(andNode.getInPorts()[0]);
          let andLink = andNode.getOutPorts()[0].link(node.getInPorts()[0]);
          model.addAll(andNode, firstLink, secondLink, andLink);
        } else {
          model.addAll(firstAnswer.getOutPorts()[0].link(node.getInPorts()[0]));
        }
      });
    });

    console.log(healthCares);

    healthCares.map((healthCare, j) => {
      console.log(healthCare);
      let node = new DefaultNodeModel(healthCare.reference, "rgb(0,192,255)");
      node.setPosition(100 * j, yPosition + 50);
      model.addAll(node);
    });

    // DF
    //5) load model into engine
    engine.setDiagramModel(model);

    //6) render the diagram!
    return <DiagramWidget className="srd-demo-canvas" diagramEngine={engine}/>;
  };
}

export default Diagram;
