import {
  DiagramEngine,
  DiagramModel,
  DiagramWidget
} from "storm-react-diagrams";
import * as React from "react";
import * as _ from "lodash";

import AdvancedLinkFactory from '../react-diagram/factories/AdvancedLinkFactory';
import AdvancedNodeModel from '../react-diagram/models/AdvancedNodeModel';

class Diagram extends React.Component {

  componentDidMount(){
  // Add css class to the 'and' nodes in order to make them invisible and simulate an and link
    for (let e of document.getElementsByClassName('srd-default-node__name')) {
      if (e.innerText === ''){ // And boxes
        e.parentElement.parentElement.classList.add("and");
      } else if (e.innerText.indexOf(" - ") === -1){ // Titles box
        e.parentElement.parentElement.classList.add("node-titles");
      } else { // Node boxes
        let node = e.parentElement.parentElement;
        node.dataset.reference = e.innerText.substring(0, e.innerText.indexOf(" - "));
        node.dataset.diagnostic = this.props.diagnostic.id;
        node.addEventListener("click", editInstance)
      }
    }
  }

  // Get full label of an object
  getFullLabel = (obj) => {
    return obj.reference + ' - ' + obj.label_translations['en'];
  };

  // Create a node from label with its inport
  createNode = (label, color = "rgb(255,255,255)") => {
    let node = new AdvancedNodeModel(label, color);
    node.addInPort(' ');
    return node;
  };

  render = () => {
    const {
      questions,
      finalDiagnostics,
      healthCares
    } = this.props;

    // setup the diagram engine
    let engine = new DiagramEngine();
    engine.installDefaultFactories();
    engine.registerLinkFactory(new AdvancedLinkFactory());


    // setup the diagram model
    let model = new DiagramModel();

    let nodes = []; // Save nodes to link them at the end
    let nodeLevels = []; // Save nodes level to position them at the end

    // Create nodes for PS and questions
    questions.map((levels) => {
      let currentLevel = [];
      levels.map((relation) => {
        let node = this.createNode(this.getFullLabel(relation.node));
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

    finalDiagnostics.map((df) => {
      let node = this.createNode(this.getFullLabel(df));
      dfLevel.push(node);
      nodes.push(node);
      model.addAll(node);
      instances.push(df.instances[0])
    });

    nodeLevels.push(dfLevel);

    let hcLevel = [];
    let hcConditions = [];
    let conditionRefs = {};

    // Create nodes for treatments and managements
    healthCares.map((healthCare) => {
      let node = this.createNode(this.getFullLabel(healthCare.node));
      // Get condition nodes of treatments and managements
      if (healthCare.conditions != null && healthCare.conditions.length > 0){
        healthCare.conditions.map((condition) => {
          let answerNode = condition.first_conditionable.node;
          let condNode;
          if (!(answerNode.reference in conditionRefs)) {
            condNode = this.createNode(this.getFullLabel(answerNode));

            answerNode.answers.map((answer) => (condNode.addOutPort(this.getFullLabel(answer))));

            hcConditions.push(condNode);
            conditionRefs[answerNode.reference] = condNode;
            model.addAll(condNode);
          } else {
            condNode = _.filter(hcConditions, ["name", this.getFullLabel(answerNode)])[0];
          }
          model.addAll(_.filter(condNode.getOutPorts(), ["label", this.getFullLabel(condition.first_conditionable)])[0].link(node.getInPorts()[0]));
        });
      }

      hcLevel.push(node);
      model.addAll(node);
    });

    nodeLevels.push(hcConditions);
    nodeLevels.push(hcLevel);

    // Positions nodes in a horizontal way
    let height = 500;
    let x = 0;
    let y = 60;
    nodeLevels.map((level) => {
      let space = height - (level.length * 100);
      y += space / 2;
      level.map((node) => {
        node.setPosition(x, y);
        y += 80;
      });
      y = 60;
      x += 300;
    });

    // Titles
    x = 0;
    y = 0;
    let yBot = 500;
    let qTitle = this.createNode("Questions and Predefined syndromes");
    qTitle.setPosition(x, y);
    x += (300 * questions.length);

    let dfTitle = this.createNode("Final diagnostics");
    let dfBotTitle = this.createNode(' ');
    dfTitle.setPosition(x - 50, y);
    dfBotTitle.setPosition(x - 50, yBot);
    x += 300;

    let dfLink = dfTitle.getInPorts()[0].link(dfBotTitle.getInPorts()[0]);
    dfLink.displayArrow(false);
    dfLink.displaySeparator(true);


    if (hcConditions.length > 0) {
      let hcCondTitle = this.createNode("Treatments and Managements conditions");
      hcCondTitle.setPosition(x - 50, y);
      let hcCondBotTitle = this.createNode(' ');
      hcCondBotTitle.setPosition(x - 50, yBot);
      x += 300;
      let hcCondLink = hcCondTitle.getInPorts()[0].link(hcCondBotTitle.getInPorts()[0]);
      hcCondLink.displayArrow(false);
      hcCondLink.displaySeparator(true);
      model.addAll(hcCondTitle, hcCondBotTitle, hcCondLink);
    }

    let hcTitle = this.createNode("Treatments and Managements");
    hcTitle.setPosition(x - 50, y);
    let hcBotTitle = this.createNode(' ');
    hcBotTitle.setPosition(x - 50, yBot);
    let hcTitleLink = hcTitle.getInPorts()[0].link(hcBotTitle.getInPorts()[0]);
    hcTitleLink.displayArrow(false);
    hcTitleLink.displaySeparator(true);

    model.addAll(qTitle, dfTitle, dfBotTitle, dfLink, hcTitle, hcBotTitle, hcTitleLink);

    // Create links between nodes
    nodes.map((node, index) => {
      instances[index].conditions.map((condition) => {

        let firstAnswer = condition.first_conditionable;
        let firstNodeAnswer = _.filter(nodes, ["name", this.getFullLabel(firstAnswer.node)])[0];

        if (condition.second_conditionable_id !== null && condition.operator === 'and_operator') {
          let secondAnswer = condition.second_conditionable;
          let secondNodeAnswer = _.filter(nodes, ["name", this.getFullLabel(secondAnswer.node)])[0];

          let andNode = this.createNode(' ', "rgba(f,f,f, 0)");
          andNode.setPosition( Math.min(firstNodeAnswer.x, secondNodeAnswer.x) + 250, firstNodeAnswer.y + 50);
          andNode.addOutPort(' ');

          let firstLink = _.filter(firstNodeAnswer.getOutPorts(), ["label", this.getFullLabel(firstAnswer)])[0].link(andNode.getInPorts()[0]);
          firstLink.displayArrow(false);
          let secondLink =  _.filter(secondNodeAnswer.getOutPorts(), ["label", this.getFullLabel(secondAnswer)])[0].link(andNode.getInPorts()[0]);
          secondLink.displayArrow(false);
          let andLink = andNode.getInPorts()[0].link(node.getInPorts()[0]);
          model.addAll(andNode, firstLink, secondLink, andLink);
        } else {
          let link = _.filter(firstNodeAnswer.getOutPorts(), ["label", this.getFullLabel(firstAnswer)])[0].link(node.getInPorts()[0]);
          model.addAll(link);
        }
      });
    });

    // load model into engine
    engine.setDiagramModel(model);

    // render the diagram!
    model.setLocked(true);
    return <DiagramWidget className="srd-demo-canvas" diagramEngine={engine} allowLooseLinks={false} allowCanvasZoom={false} />;
  };
}

export default Diagram;