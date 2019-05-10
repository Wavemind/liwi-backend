import {
  DiagramEngine,
  DiagramModel,
} from "storm-react-diagrams";
import * as React from "react";
import * as _ from "lodash";

import AdvancedLinkFactory from "../react-diagram/factories/AdvancedLinkFactory";
import AdvancedNodeFactory from "../react-diagram/factories/AdvancedNodeFactory";
import AdvancedNodeModel from "../react-diagram/models/AdvancedNodeModel";
import AdvancedDiagramWidget from "../react-diagram/widgets/AdvancedDiagramWidget";

import NodeList from "../react-diagram/lists/NodeList";
import Http from "../http";
import FlashMessages from "./FlashMessages";

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
      addMessage,
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
    let self = this;

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
    let finalDiagnosticLevel = [];
    let excludingDF = null;

    if (instanceableType === 'Diagnostic') {
      finalDiagnostics.map((instance) => {
        let finalDiagnostic = instance.node;
        let node = this.createNode(finalDiagnostic);
        node.addInPort(" ");

        node.addOutPort(" ", finalDiagnostic.reference, finalDiagnostic.id);

        // Manage excluding final diagnostics
        if (finalDiagnostic.final_diagnostic_id !== null) {
          excludingDF = finalDiagnostic;
        }
        finalDiagnosticLevel.push(node);
        nodes.push(node);
        model.addAll(node);
        instances.push(instance);
      });

      // Excluded diagnostic
      if (excludingDF !== null) {
        let mainDF = _.find(finalDiagnosticLevel, ["node.id", excludingDF.id]);
        let excludedDF = _.find(finalDiagnosticLevel, ["node.id", excludingDF.final_diagnostic_id]);

        let link = mainDF.getOutPort().link(excludedDF.getInPorts()[1]);
        link.displaySeparator(true);

        model.addAll(link);
      }

      nodeLevels.push(finalDiagnosticLevel);

      let hcLevel = [];
      let hcConditions = [];

      nodeLevels.push(hcConditions);
      nodeLevels.push(hcLevel);
    }

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
      linksUpdated: function (eventModel) {
        // Disable link from inPort
        if (eventModel.link.sourcePort.in) {
          if (model.getLink(eventModel.link.id) !== null) {
            model.removeLink(eventModel.link.id)
          }
        }

        // Add event listener on port change
        // Trigger exclude diagnostic and remove link
        eventModel.link.addListener({
          targetPortChanged: function (eventLink) {
            let exists = false;

            // Verify if link is already set
            Object.keys(eventModel.entity.links).map(index => {
              let link = eventModel.entity.links[index];
              let portEntity = eventLink.entity;
              if (link.id !== portEntity.id && (link.sourcePort.id === portEntity.sourcePort.id && link.targetPort.parent.id === portEntity.targetPort.parent.id)) {
                exists = true;
              }
            });


            // Don't create an another link in DB if it already exist
            if (!exists) {
              if (eventLink.entity.sourcePort.parent.node.type === "FinalDiagnostic") {
                if (eventLink.entity.targetPort.parent.node.type === "FinalDiagnostic") {
                  http.excludeDiagnostic(eventLink.entity.sourcePort.parent.node.id, eventLink.entity.targetPort.parent.node.id);
                } else {
                  model.removeLink(eventModel.link.id)
                }
              } else {
                let nodeId = eventLink.port.parent.node.id;
                let answerId = eventModel.link.sourcePort.dbId;
                if (eventModel.link.targetPort.in) {
                  // Create link in DB
                  http.createLink(nodeId, answerId).then((response) => {
                    if (response.status !== "success") {
                      // if throw an error, remove link in diagram
                      if (model.getLink(eventModel.link.id) !== null) {
                        model.removeLink(eventModel.link.id);
                        self.updateEngine(engine);
                      }
                      addMessage(response);
                    }
                  }).catch((err) => {
                    console.log(err);
                  });
                } else {
                  if (model.getLink(eventModel.link.id) !== null) {
                    model.removeLink(eventModel.link.id);
                    self.updateEngine(engine);
                  }
                }
              }
            }
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
    this.setState({engine});
  };

  // @params node
  // Get full label of an object
  getFullLabel = (node) => {
    return node.label_translations["en"];
  };

  // Create a node from label with its inport
  createNode = (node, outPorts = [], color = "rgb(255,255,255)") => {
    const {addNode} = this.props;

    let advancedNode = new AdvancedNodeModel(node, node.reference, outPorts, color, addNode);
    advancedNode.addInPort(" ");
    return advancedNode;
  };

  // @params [String] status, [String] message
  // Call context method to display flash message
  addFlashMessage = async (status, response) => {
    const {addMessage} = this.props;
    let message = {
      status,
      message: [`An error occured: ${response.status} - ${response.statusText}`],
    };
    await addMessage(message);
  };

  render = () => {
    const {engine} = this.state;
    const {removeNode} = this.props;

    const http = new Http();

    let model = engine.getDiagramModel();

    return (
      <div className="content">
        <FlashMessages/>
        <div className="row">
          <div className="col-md-2 px-0 liwi-sidebar">
            <NodeList />
          </div>
          <div
            className="col-md-10 diagram-wrapper"
            onDrop={async event => {
              let nodeDb = JSON.parse(event.dataTransfer.getData("node"));
              let points = engine.getRelativeMousePoint(event);
              let nodeDiagram = {};
              let result;

              // Create AND node
              if (nodeDb === "AND") {
                nodeDiagram = new AdvancedNodeModel("AND", "", "", "");
                nodeDiagram.addInPort(" ");
                nodeDiagram.addOutPort(" ");
                // Create Final Diagnostic node
              } else if (nodeDb.type === "FinalDiagnostic") {
                result = await http.createInstance(nodeDb.id);
                if (result.ok === undefined || result.ok) {
                  nodeDiagram = this.createNode(nodeDb);
                  nodeDiagram.addInPort(" ");
                  nodeDiagram.addOutPort(" ");
                  removeNode(nodeDb);
                } else  {
                  this.addFlashMessage("danger", result);
                }

              } else {
                // Create regular node
                result = await http.createInstance(nodeDb.id);
                if (result.ok === undefined || result.ok) {
                  if (nodeDb.get_answers !== null) {
                    nodeDiagram = this.createNode(nodeDb, nodeDb.get_answers);
                    nodeDb.get_answers.map((answer) => (nodeDiagram.addOutPort(this.getFullLabel(answer), answer.reference, answer.id)));
                  } else {
                    nodeDiagram = this.createNode(nodeDb);
                  }
                  removeNode(nodeDb);
                } else {
                  this.addFlashMessage("danger", result);
                }
              }

              // Set position of node in canevas
              nodeDiagram.x = points.x;
              nodeDiagram.y = points.y;

              // Update diagram nodes
              model.addAll(nodeDiagram);
              this.updateEngine(engine);
            }}
            onDragOver={event => {
              event.preventDefault();
            }}
          >
            <AdvancedDiagramWidget
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
