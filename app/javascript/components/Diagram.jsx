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

  componentDidMount(){
    for (let e of document.getElementsByClassName('srd-default-node__name')) {
      if (e.innerText === ''){
        e.parentElement.parentElement.classList.add("and");
      }
    }
  }

  render = () => {
    const {
      diagnostic,
      finalDiagnostics,
      healthCares
    } = this.props;

    let nodeLevels = [];
    let maxLevel = 0;

    //1) setup the diagram engine
    let engine = new DiagramEngine();
    engine.installDefaultFactories();

    //2) setup the diagram model
    let model = new DiagramModel();

    let nodes = [];

    // PS and QUESTIONS
    diagnostic.map((levels, i) => {
      let currentLevel = [];
      levels.map((relation, j) => {
        let node = new DefaultNodeModel(relation.node.reference + ' - ' + relation.node.label_translations['en'], "rgb(0,192,255)");
        currentLevel.push(node);
        relation.node.answers.map((answer) => (node.addOutPort(answer.reference + ' - ' + answer.label_translations['en'])));
        node.addInPort(' ');
        nodes.push(node);
        model.addAll(node);
      });

      nodeLevels.push(currentLevel);
      if (nodeLevels.length > maxLevel){
        maxLevel = nodeLevels.length
      }
    });

    let instances = diagnostic.flat();

    let dfLevel = [];
    // Display final diagnostics
    finalDiagnostics.map((df, index) => {
      let node = new DefaultNodeModel(`${df.reference + ' - ' + df.label_translations['en']}`, "rgb(0,192,255)");
      dfLevel.push(node);
      node.addInPort(df.reference);
      nodes.push(node);
      model.addAll(node);
      instances.push(df.instances[0])
    });

    nodeLevels.push(dfLevel);
    if (dfLevel.length > maxLevel){
      maxLevel = dfLevel.length
    }

    let hcLevel = [];
    let hcConditions = [];
    let conditionRefs = {};
    healthCares.map((healthCare, j) => {
      let node = new DefaultNodeModel(healthCare.node.reference + ' - ' + healthCare.node.label_translations['en'], "rgb(0,192,255)");

      if (healthCare.conditions != null && healthCare.conditions.length > 0){
        node.addInPort(' ');
        healthCare.conditions.map((condition) => {
          let answerNode = condition.first_conditionable.node;
          let condNode;
          if (!(answerNode.reference in conditionRefs)){
            condNode = new DefaultNodeModel(answerNode.reference + ' - ' + answerNode.label_translations['en'], "rgb(0,192,255)");
            answerNode.answers.map((answer) => (condNode.addOutPort(answer.reference + ' - ' + answer.label_translations['en'])));

            hcConditions.push(condNode);
            conditionRefs[answerNode.reference] = condNode;
            model.addAll(condNode);
          } else {
            condNode = _.filter(hcConditions, ["name", answerNode.reference + ' - ' + answerNode.label_translations['en']])[0];
          }
          model.addAll(_.filter(condNode.getOutPorts(), ["label", condition.first_conditionable.reference + ' - ' + condition.first_conditionable.label_translations['en']])[0].link(node.getInPorts()[0]));
        });
      }

      hcLevel.push(node);
      model.addAll(node);
    });

    nodeLevels.push(hcConditions);
    if (hcConditions.length > maxLevel){
      maxLevel = hcConditions.length
    }

    nodeLevels.push(hcLevel);
    if (hcLevel.length > maxLevel){
      maxLevel = hcLevel.length
    }


    let height = 500;
    let x = 0;
    let y = 0;
    nodeLevels.map((level) => {
      let space = height - (level.length * 100);
      y += space / 2;
      level.map((node) => {
        node.setPosition(x, y);
        y += 80;
      });
      y = 0;
      x += 300;
    });




    nodes.map((node, index) => {
      instances[index].conditions.map((condition) => {

        let firstAnswer = condition.first_conditionable;
        let firstNodeAnswer = _.filter(nodes, ["name", firstAnswer.node.reference + ' - ' + firstAnswer.node.label_translations['en']])[0];

        if (condition.second_conditionable_id !== null && condition.operator === 'and_operator'){
          let secondAnswer = condition.second_conditionable;
          let secondNodeAnswer = _.filter(nodes, ["name", secondAnswer.node.reference + ' - ' + secondAnswer.node.label_translations['en']])[0];

          let andNode = new DefaultNodeModel(' ', "rgba(f,f,f, 0)");
          andNode.setPosition( Math.min(firstNodeAnswer.x, secondNodeAnswer.x) + 200, firstNodeAnswer.y + 50);
          andNode.addOutPort(' ');
          andNode.addInPort(' ');


          let firstLink = _.filter(firstNodeAnswer.getOutPorts(), ["label", firstAnswer.reference + ' - ' + firstAnswer.label_translations['en']])[0].link(andNode.getInPorts()[0]);
          let secondLink =  _.filter(secondNodeAnswer.getOutPorts(), ["label", secondAnswer.reference + ' - ' + secondAnswer.label_translations['en']])[0].link(andNode.getInPorts()[0]);
          let andLink = andNode.getInPorts()[0].link(node.getInPorts()[0]);
          model.addAll(andNode, firstLink, secondLink, andLink);
        } else {
          model.addAll(_.filter(firstNodeAnswer.getOutPorts(), ["label", firstAnswer.reference + ' - ' + firstAnswer.label_translations['en']])[0].link(node.getInPorts()[0]));
        }
      });
    });


    // DF
    //5) load model into engine
    engine.setDiagramModel(model);

    //6) render the diagram!
    return <DiagramWidget className="srd-demo-canvas" diagramEngine={engine}/>;
  };
}

export default Diagram;
