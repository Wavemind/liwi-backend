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

import NodeList from "./lists/NodeList";

import FlashMessages from "./utils/FlashMessages";
import {withDiagram} from "../context/Diagram.context";
import Toolbar from "./utils/Toolbar";
import FormModal from "./modal/FormModal";

class FinalDiagnosticDiagram extends React.Component {

  constructor() {
    super();
    this.state = {
      engine: new DiagramEngine()
    };
  }

  componentWillMount() {
    this.initDiagram();
  }

  async shouldComponentUpdate(nextProps, nextState) {
    if (this.props.currentDbNode !== nextProps.currentDbNode) {
      const { engine } = this.state;
      const { currentDbNode, currentDiagramNode } = nextProps;
      const model = engine.getDiagramModel();

      // Create or update node in diagram
      if (nextProps.modalToOpen === 'CreateQuestionsSequence') {
        let node = this.createNode(currentDbNode, currentDbNode.answers);
        currentDbNode.answers.map((answer) => (node.addOutPort(this.getFullLabel(answer), answer.reference, answer.id)));
        model.addAll(node);
      } else if (nextProps.modalToOpen === 'UpdateQuestionsSequence') {
        currentDiagramNode.setReference(currentDbNode.reference);
        currentDiagramNode.setNode(currentDbNode);
      } else if (nextProps.modalToOpen === 'CreateHealthCare') {
        let node = this.createNode(currentDbNode);
        model.addAll(node);
      }
      this.updateEngine(engine);
    }

    return true;
  }

  initDiagram = () => {
    const {
      questions,
      healthCares,
      addMessage,
      http
    } = this.props;

    const {engine} = this.state;

    // Setup the diagram model
    let model = new DiagramModel();

    // Setup the diagram engine
    engine.installDefaultFactories();
    engine.registerLinkFactory(new AdvancedLinkFactory());
    engine.registerNodeFactory(new AdvancedNodeFactory());

    let nodes = []; // Save nodes to link them at the end
    let nodeLevels = []; // Save nodes level to position them at the end
    let self = this;

    let instances = questions.flat().concat(healthCares);

    let hcLevel = [];
    let hcConditions = [];

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

    // Create nodes for treatments and managements
    healthCares.map((healthCare) => {
      let node = this.createNode(healthCare.node);
      nodes.push(node);
      hcLevel.push(node);
      model.addAll(node);
    });

    nodeLevels.push(hcLevel);
    nodeLevels.push(hcConditions);

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
          console.log(firstNodeAnswer)
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
            model.removeLink(eventModel.link.id);
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
              if (eventLink.entity.sourcePort.parent.node.node_type === "FinalDiagnostic") {
                if (eventLink.entity.targetPort.parent.node.node_type === "FinalDiagnostic") {
                  http.excludeDiagnostic(eventLink.entity.sourcePort.parent.node.id, eventLink.entity.targetPort.parent.node.id);
                } else {
                  model.removeLink(eventModel.link.id);
                }
              } else {
                let nodeId = eventLink.port.parent.node.id;
                let answerId = eventModel.link.sourcePort.dbId;

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
              }
            }
          }
        });
      }
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
      messages: [`An error occured: ${response.status} - ${response.statusText}`]
    };
    await addMessage(message);
  };

  render = () => {
    const {engine} = this.state;
    const {
      removeNode,
      finalDiagnostic,
      http
    } = this.props;

    let model = engine.getDiagramModel();

    return (
      <div className="content">
        <FormModal/>
        <FlashMessages/>
        <div className="row">
          <Toolbar/>
          <NodeList/>
          <div
            className="col-md-10 diagram-wrapper"
            onDrop={async event => {
              let nodeDb = JSON.parse(event.dataTransfer.getData("node"));
              let points = engine.getRelativeMousePoint(event);
              let nodeDiagram = {};
              let result;


              // Create node
              result = await http.createHealthCareInstance(nodeDb.id);
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

export default withDiagram(FinalDiagnosticDiagram);
