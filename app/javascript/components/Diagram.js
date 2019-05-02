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
import Http from "../http";

import FormModal from "./FormModal";

import { withDiagram } from '../context/Diagram.context';

class Diagram extends React.Component {

  constructor() {
    super();
    this.state = {
      engine: new DiagramEngine()
    };
  }

  componentWillMount() {
    this.initDiagram();
  }

  initDiagram = () => {
    const {
      instanceableType,
      questions,
      finalDiagnostics,
      healthCares,
    } = this.props;

    const { engine } = this.state;

    // Setup the diagram model
    let model = new DiagramModel();

    // Init http class
    const http = new Http();

    // Setup the diagram engine
    engine.installDefaultFactories();
    engine.registerLinkFactory(new AdvancedLinkFactory());
    engine.registerNodeFactory(new AdvancedNodeFactory());

    let nodes = []; // Save nodes to link them at the end
    let nodeLevels = []; // Save nodes level to position them at the end

    // Create nodes for PS and questions
    questions.map((levels) => {
      let currentLevel = [];
      levels.map((instance) => {
        let node = this.createNode(instance.node, instance.node.answers);
        currentLevel.push(node);
        instance.node.answers.map((answer) => (node.addOutPort(this.getFullLabel(answer), answer.reference, answer.id)));
        nodes.push(node);
        model.addAll(node);
      });

      nodeLevels.push(currentLevel);
    });

    let instances = questions.flat();

    // Create nodes for final diagnostics
    let dfLevel = [];
    let excludingDF = null;

    if (instanceableType === 'Diagnostic') {
      finalDiagnostics.map((instance) => {
        let df = instance.node;
        let node = this.createNode(df);
        if (df.final_diagnostic_id !== null) {
          excludingDF = df;
          node.addOutPort(this.getFullLabel(_.find(finalDiagnostics, ["id", df.final_diagnostic_id])), df.reference, df.id);
        }
        dfLevel.push(node);
        nodes.push(node);
        model.addAll(node);
        instances.push(instance);
      });

      // Excluded diagnostic
      if (excludingDF !== null) {
        let mainDF = _.find(dfLevel, ["node.id", excludingDF.id]);
        let excludedDF = _.find(dfLevel, ["node.id", excludingDF.final_diagnostic_id]);

        let link = mainDF.getOutPort().link(excludedDF.getInPort());
        link.displaySeparator(true);

        model.addAll(link);
      }

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
            let answerNode = condition.first_conditionable.get_node;
            let condNode;
            if (!(answerNode.reference in conditionRefs)) {
              condNode = this.createNode(answerNode, answerNode.answers);

              answerNode.answers.map((answer) => (condNode.addOutPort(this.getFullLabel(answer), answer.reference, answer.id)));

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
    }

    // Positions nodes in a horizontal way
    let width = 1400;
    let x = 0;
    let y = 60;
    nodeLevels.map((level) => {
      let nbNodes = level.length;
      let totalSpace = width - (nbNodes * 200);
      let marges = totalSpace - ((nbNodes - 1) * 120);
      x += marges / 2;
      level.map((node) => {
        node.setPosition(x, y);
        x += 200 + 120;
      });
      x = 0;
      if (level.length > 0) {
        y += 200;
      }
    });

    // Create links between nodes
    nodes.map((node, index) => {
      instances[index].conditions.map((condition) => {
        let firstAnswer = condition.first_conditionable;
        let firstNodeAnswer = _.find(nodes, ["reference", firstAnswer.get_node.reference]);

        if (condition.second_conditionable_id !== null && condition.operator === "and_operator") {
          let secondAnswer = condition.second_conditionable;
          let secondNodeAnswer = _.find(nodes, ["reference", secondAnswer.get_node.reference]);

          let andNode = new AdvancedNodeModel("AND", "", "", "");
          andNode.addInPort(" ");
          andNode.setPosition(Math.min(firstNodeAnswer.x, secondNodeAnswer.x) + 200, firstNodeAnswer.y + 100);
          andNode.addOutPort(" ");

          let firstLink = _.find(firstNodeAnswer.getOutPorts(), ["label", this.getFullLabel(firstAnswer)]).link(andNode.getInPort());
          let secondLink = _.find(secondNodeAnswer.getOutPorts(), ["label", this.getFullLabel(secondAnswer)]).link(andNode.getInPort());
          let andLink = andNode.getOutPort().link(node.getInPort());

          firstLink.displayArrow(false);
          secondLink.displayArrow(false);

          model.addAll(andNode, firstLink, secondLink, andLink);
        } else {
          let link = _.find(firstNodeAnswer.getOutPorts(), ["label", this.getFullLabel(firstAnswer)]).link(node.getInPort());
          model.addAll(link);
        }
      });
    });


    // Set eventListener for create link
    model.addListener({
      linksUpdated: function(eventModel) {
        // Disable link from inPort
        if (eventModel.link.sourcePort.in) {
          if (model.getLink(eventModel.link.id) !== null) {
            model.removeLink(eventModel.link.id)
          }
        }

        eventModel.link.addListener({
          targetPortChanged: function(eventLink) {
            let exists = false;

            // Verify if link is already set
            Object.keys(eventModel.entity.links).map(index => {
              let link = eventModel.entity.links[index];
              let portEntity = eventLink.entity;
              if (link.id !== portEntity.id && (link.sourcePort.id === portEntity.sourcePort.id && link.targetPort.parent.id === portEntity.targetPort.parent.id)) {
                exists = true;
              }
            });

            let nodeId = eventLink.port.parent.node.id;
            let answerId = eventModel.link.sourcePort.dbId;
            http.createLink(nodeId, answerId);
          }
        });
      },
    });

    // load model into engine
    engine.setDiagramModel(model);
    this.updateEngine(engine);
  };

  // @params engine
  // Set state of engine
  updateEngine = (engine) => {
    this.setState({ engine });
  };

  // @params node
  // Get full label of an object
  getFullLabel = (node) => {
    return node.label_translations["en"];
  };

  // Create a node from label with its inport
  createNode = (node, outPorts = [], color = "rgb(255,255,255)") => {
    const { addNode } = this.props;

    let advancedNode = new AdvancedNodeModel(node, node.reference, outPorts, color, addNode);
    advancedNode.addInPort(" ");
    return advancedNode;
  };

  render = () => {
    const { engine } = this.state;
    const { removeNode } = this.props;

    const http = new Http();

    let model = engine.getDiagramModel();

    return (
      <div className="content">
        <FormModal/>
        <ul className="nav">
          <li className="nav-item">
            <div className="pt-2"
                 draggable={true}
                 onDragStart={event => {
                   event.dataTransfer.setData("node", JSON.stringify('AND'));
                 }}
            >
              AND
            </div>
          </li>
        </ul>
        <div className="row">
          <div className="col-md-2 px-0">
            <section className="node-list">
              <NodeList />
            </section>
            <button className="btn btn-primary mt-2 mr-2" onClick={() => {this.initDiagram()}}>Order node</button>
          </div>
          <div
            className="col-md-10 mt-2"
            onDrop={async event => {
              let nodeDb = JSON.parse(event.dataTransfer.getData("node"));
              let points = engine.getRelativeMousePoint(event);
              let nodeDiagram = {};

              // Create new node
              // else
              // create AND node
              if (nodeDb !== 'AND') {
                if (nodeDb.get_answers !== null) {
                  nodeDiagram = this.createNode(nodeDb, nodeDb.get_answers);
                  nodeDb.get_answers.map((answer) => (nodeDiagram.addOutPort(this.getFullLabel(answer), answer.reference, answer.id)));
                } else {
                  nodeDiagram = this.createNode(nodeDb);
                }

                await http.createInstance(nodeDb.id);
                removeNode(nodeDb);
              } else {
                nodeDiagram = new AdvancedNodeModel("AND", "", "", "");
                nodeDiagram.addInPort(" ");
                nodeDiagram.addOutPort(" ");
              }

              nodeDiagram.x = points.x;
              nodeDiagram.y = points.y;

              model.addAll(nodeDiagram);
              this.updateEngine(engine);
            }}
            onDragOver={event => {
              event.preventDefault();
            }}
          >
            <DiagramWidget
              className="srd-canvas"
              diagramEngine={engine}
              allowCanvasZoom={false}
              maxNumberPointsPerLink={0}
            />
          </div>
        </div>
      </div>
    );
  };
}

export default withDiagram(Diagram);
