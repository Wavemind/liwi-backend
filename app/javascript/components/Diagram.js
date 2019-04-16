import {
  DiagramEngine,
  DiagramModel,
  DiagramWidget
} from "storm-react-diagrams";
import * as React from "react";
import * as _ from "lodash";

import AdvancedLinkFactory from "../react-diagram/factories/AdvancedLinkFactory";
import AdvancedNodeFactory from "../react-diagram/factories/AdvancedNodeFactory";
import AdvancedNodeModel from "../react-diagram/models/AdvancedNodeModel";
import NodeList from "../react-diagram/lists/NodeList";

class Diagram extends React.Component {

  componentDidMount() {
    // Add css class to the 'and' nodes in order to make them invisible and simulate an and link
    for (let e of document.getElementsByClassName("srd-default-node__name")) {
      if (e.innerText.indexOf(" - ") === -1) { // Titles box
        e.parentElement.parentElement.classList.add("node-titles");
      }
    }
  }

  // @params node
  // Get full label of an object
  getFullLabel = (node) => {
    return node.label_translations["en"];
  };

  // Create a node from label with its inport
  createNode = (node, outPorts = [], color = "rgb(255,255,255)") => {
    let advancedNode = new AdvancedNodeModel(node, node.reference, outPorts, color);
    advancedNode.addInPort(" ");
    return advancedNode;
  };

  render = () => {
    const {
      questions,
      finalDiagnostics,
      healthCares,
      availableNodes,
      isDiagnostic,
    } = this.props;

    // Setup the diagram engine
    let engine = new DiagramEngine();
    engine.installDefaultFactories();
    engine.registerLinkFactory(new AdvancedLinkFactory());
    engine.registerNodeFactory(new AdvancedNodeFactory());

    // Setup the diagram model
    let model = new DiagramModel();

    let nodes = []; // Save nodes to link them at the end
    let nodeLevels = []; // Save nodes level to position them at the end

    // Create nodes for PS and questions
    questions.map((levels) => {
      let currentLevel = [];
      levels.map((relation) => {
        let node = this.createNode(relation.node, relation.node.answers);
        currentLevel.push(node);
        relation.node.answers.map((answer) => (node.addOutPort(this.getFullLabel(answer))));
        nodes.push(node);
        model.addAll(node);
      });

      nodeLevels.push(currentLevel);
    });

    let instances = questions.flat();

    // Create nodes for final diagnostics
    let dfLevel = [];

    if (isDiagnostic) {
      finalDiagnostics.map((df) => {
        let node = this.createNode(df);
        if (df.final_diagnostic_id !== null) {
          node.addOutPort(this.getFullLabel(_.find(finalDiagnostics, ["id", df.final_diagnostic_id])));
        }
        dfLevel.push(node);
        nodes.push(node);
        model.addAll(node);
        instances.push(df.instances[0]);
      });

      // Excluded diagnostic
      finalDiagnostics.map((df) => {
        if (df.final_diagnostic_id !== null) {
          let mainDF = _.find(dfLevel, ["dbId", df.id]);
          let excludedDF = _.find(dfLevel, ["dbId", df.final_diagnostic_id]);

          let link = mainDF.getOutPort().link(excludedDF.getInPort());
          link.displaySeparator(true);

          model.addAll(link);
        }
      });

      nodeLevels.push(dfLevel);

      let hcLevel = [];
      let hcConditions = [];
      let conditionRefs = {};

      // Create nodes for treatments and managements
      healthCares.map((healthCare) => {
        let node = this.createNode(healthCare.node);
        // Get condition nodes of treatments and managements
        if (healthCare.conditions != null && healthCare.conditions.length > 0) {
          healthCare.conditions.map((condition) => {
            let answerNode = condition.first_conditionable.node;
            let condNode;
            if (!(answerNode.reference in conditionRefs)) {
              condNode = this.createNode(answerNode, answerNode.answers);

              answerNode.answers.map((answer) => (condNode.addOutPort(this.getFullLabel(answer))));

              hcConditions.push(condNode);
              conditionRefs[answerNode.reference] = condNode;
              model.addAll(condNode);
            } else {
              condNode = _.find(hcConditions, ["reference", answerNode.reference]);
            }
            model.addAll(_.find(condNode.getOutPorts(), ["label", this.getFullLabel(condition.first_conditionable)]).link(node.getInPort()));
          });
        }

        hcLevel.push(node);
        model.addAll(node);
      });

      nodeLevels.push(hcConditions);
      nodeLevels.push(hcLevel);

    //   // Titles
    //   x = 0;
    //   y = 0;
    //   let yBot = 700;
    //   let qTitle = this.createNode("Questions and Predefined syndromes");
    //   qTitle.setPosition(x, y);
    //   x += (300 * questions.length);
    //
    //   let dfTitle = this.createNode("Final diagnostics");
    //   let dfBotTitle = this.createNode(" ");
    //   dfTitle.setPosition(x - 50, y);
    //   dfBotTitle.setPosition(x - 50, yBot);
    //
    //   x += 400;
    //
    //   let dfLink = dfTitle.getInPort().link(dfBotTitle.getInPort());
    //   dfLink.displayArrow(false);
    //   dfLink.displaySeparator(true);
    //
    //   if (hcConditions.length > 0) {
    //     let hcCondTitle = this.createNode("Treatments and Managements conditions");
    //     let hcCondBotTitle = this.createNode(" ");
    //     let hcCondLink = hcCondTitle.getInPort().link(hcCondBotTitle.getInPort());
    //
    //     hcCondTitle.setPosition(x - 50, y);
    //     hcCondBotTitle.setPosition(x - 50, yBot);
    //
    //     x += 400;
    //
    //     hcCondLink.displayArrow(false);
    //     hcCondLink.displaySeparator(true);
    //
    //     model.addAll(hcCondTitle, hcCondBotTitle, hcCondLink);
    //   }
    //
    //   let hcTitle = this.createNode("Treatments and Managements");
    //   hcTitle.setPosition(x - 50, y);
    //   let hcBotTitle = this.createNode(" ");
    //   hcBotTitle.setPosition(x - 50, yBot);
    //   let hcTitleLink = hcTitle.getInPort().link(hcBotTitle.getInPort());
    //   hcTitleLink.displayArrow(false);
    //   hcTitleLink.displaySeparator(true);
    //
    //   model.addAll(qTitle, dfTitle, dfBotTitle, dfLink, hcTitle, hcBotTitle, hcTitleLink);
    }

    // Positions nodes in a horizontal way
    let height = 500;
    let x = 0;
    let y = 60;
    nodeLevels.map((level) => {
      let space = height - (level.length * 100);
      y += space / 2;
      level.map((node) => {
        node.setPosition(x, y);
        y += 150;
      });
      y = 60;
      x += 320;
    });


    // Create links between nodes
    nodes.map((node, index) => {
      instances[index].conditions.map((condition) => {
        let firstAnswer = condition.first_conditionable;
        let firstNodeAnswer = _.find(nodes, ["reference", firstAnswer.node.reference]);

        if (condition.second_conditionable_id !== null && condition.operator === "and_operator") {
          let secondAnswer = condition.second_conditionable;
          let secondNodeAnswer = _.find(nodes, ["reference", secondAnswer.node.reference]);

          // let andNode = this.createNode("AND", "red");
          let andNode = new AdvancedNodeModel('AND', '', '', 'red');
          andNode.addInPort(" ");
          andNode.setPosition(Math.min(firstNodeAnswer.x, secondNodeAnswer.x) + 250, firstNodeAnswer.y + 50);
          andNode.addOutPort(" ");

          let firstLink = _.find(firstNodeAnswer.getOutPorts(), ["label", this.getFullLabel(firstAnswer)]).link(andNode.getInPort());
          let secondLink = _.find(secondNodeAnswer.getOutPorts(), ["label", this.getFullLabel(secondAnswer)]).link(andNode.getInPort());
          let andLink = andNode.getInPort().link(node.getInPort());

          firstLink.displayArrow(false);
          secondLink.displayArrow(false);

          model.addAll(andNode, firstLink, secondLink, andLink);
        } else {
          let link = _.find(firstNodeAnswer.getOutPorts(), ["label", this.getFullLabel(firstAnswer)]).link(node.getInPort());
          model.addAll(link);
        }
      });
    });

    // load model into engine
    engine.setDiagramModel(model);

    // render the diagram!
    return (
      <div className="row">
        <div className="col-md-2 px-0">
          <NodeList nodes={availableNodes} />
        </div>
        <div
          className="col-md-10 mt-2"
          onDrop={event => {
            let nodeDb = JSON.parse(event.dataTransfer.getData("node"));
            let nodeDiagram = this.createNode(nodeDb);
            let points = engine.getRelativeMousePoint(event);
            nodeDiagram.x = points.x;
            nodeDiagram.y = points.y;

            if (nodeDb.get_answers !== undefined) {
              nodeDb.get_answers.map((answer) => (nodeDiagram.addOutPort(this.getFullLabel(answer))));
            } else {
              nodeDiagram.addOutPort(' ')
            }

            model.addNode(nodeDiagram);
          }}
          onDragOver={event => {
            event.preventDefault();
          }}
        >
          <DiagramWidget
            className="srd-demo-canvas"
            diagramEngine={engine}
            allowCanvasZoom={false}
          />
        </div>
      </div>
    );
  };
}

export default Diagram;
