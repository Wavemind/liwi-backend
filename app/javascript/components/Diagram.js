import {
  DiagramEngine,
  DiagramModel
} from "storm-react-diagrams";
import * as React from "react";
import * as _ from "lodash";

import AdvancedLinkFactory from "../react-diagram/factories/AdvancedLinkFactory";
import AdvancedLabelFactory from "../react-diagram/factories/AdvancedLabelFactory";
import AdvancedNodeFactory from "../react-diagram/factories/AdvancedNodeFactory";
import AdvancedLinkModel from "../react-diagram/models/AdvancedLinkModel";
import AdvancedNodeModel from "../react-diagram/models/AdvancedNodeModel";
import AdvancedDiagramWidget from "../react-diagram/widgets/AdvancedDiagramWidget";

import NodeList from "./lists/NodeList";
import FlashMessages from "./utils/FlashMessages";
import FormModal from "./modal/FormModal";

import {withDiagram} from '../context/Diagram.context';
import Toolbar from "./utils/Toolbar";

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

  async shouldComponentUpdate(nextProps, nextState) {
    // Listen to the change of the props score in order to update the model in the proper way
    if (this.props.currentScore !== nextProps.currentScore) {
      const {http, currentNode, currentAnswerId, currentLinkId, currentScore} = nextProps;
      const {engine} = this.state;
      const model = engine.getDiagramModel();

      // Handle inserting a link with a score
      if (nextProps.modalToOpen === 'InsertScore') {
        if (nextProps.currentScore === null) {
          model.removeLink(currentLinkId);
        } else {
          http.createLink(currentNode.id, currentAnswerId, currentScore).then((result) => {
            if (result.ok === undefined || result.ok) {
              model.getLink(currentLinkId).addLabel(currentScore);
            } else {
              this.addFlashMessage("danger", result);
              // if throw an error, remove link in diagram
              if (model.getLink(currentLinkId) !== null) {
                model.removeLink(currentLinkId);
              }
            }
            this.updateEngine(engine);
          });
          return true;
        }
        return false;
        // Handle what happens after an update of a score
      } else if (nextProps.modalToOpen === 'UpdateScore') {
        const label = model.getLink(currentLinkId).labels[0];
        label.setLabel(currentScore);
        this.updateEngine(engine);
      }
    } else if (this.props.currentDbNode !== nextProps.currentDbNode) {
      const { engine } = this.state;
      const { currentDbNode, currentDiagramNode } = nextProps;
      const model = engine.getDiagramModel();

      // Create or update node in diagram
      if (nextProps.modalToOpen === 'CreateFinalDiagnostic') {
        let node = this.createNode(currentDbNode);
        node.addInPort(" ");
        node.addOutPort(" ", currentDbNode.reference, currentDbNode.id);
        model.addAll(node);
      } else if (nextProps.modalToOpen === 'UpdateFinalDiagnostic') {
        currentDiagramNode.setReference(currentDbNode.reference);
        currentDiagramNode.setNode(currentDbNode);
      } else if (nextProps.modalToOpen === 'CreateQuestionsSequence') {
        let node = this.createNode(currentDbNode, currentDbNode.answers);
        currentDbNode.answers.map((answer) => (node.addOutPort(this.getFullLabel(answer), answer.reference, answer.id)));
        model.addAll(node);
      } else if (nextProps.modalToOpen === 'UpdateQuestionsSequence') {
        currentDiagramNode.setReference(currentDbNode.reference);
        currentDiagramNode.setNode(currentDbNode);
      }
      this.updateEngine(engine);
    }

    return true;
  }

  initDiagram = () => {
    const {
      instanceableType,
      questions,
      finalDiagnostics,
      addMessage,
      http,
      type,
      instanceable,
      set
    } = this.props;

    const {engine} = this.state;

    // Setup the diagram model
    let model = new DiagramModel();

    // Setup the diagram engine
    engine.installDefaultFactories();
    engine.registerLinkFactory(new AdvancedLinkFactory());
    engine.registerLabelFactory(new AdvancedLabelFactory());
    engine.registerNodeFactory(new AdvancedNodeFactory());

    let nodes = []; // Save nodes to link them at the end
    let nodeLevels = []; // Save nodes level to position them at the end
    let self = this;

    // Create nodes for PS and questions
    questions.map((levels) => {
      let currentLevel = [];
      levels.map((instance) => {
        let node = null;
        // If this is a PS score diagram, don't put an inport on the nodes, since there is only one level
        if (type === "QuestionsSequence" && instanceable.category_name === 'Scored') {
          node = this.createNode(instance.node, instance.node.answers, "rgb(255,255,255)", (type === instance.node.node_type && instanceable.id === instance.node.id));
        } else {
          node = this.createNode(instance.node, instance.node.answers);
        }
        currentLevel.push(node);

        if (!(type === instance.node.node_type && instanceable.id === instance.node.id)) { // Don't put outports if this is the current PS
          instance.node.answers.map((answer) => (node.addOutPort(this.getFullLabel(answer), answer.reference, answer.id)));
        }

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
          if (type === "QuestionsSequence" && instanceable.category_name === 'Scored') { // Check if it is a diagram PSS
            link.addLabel(condition.score);
          }
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
          if (eventLink.entity.sourcePort.parent.node.node_type === "FinalDiagnostic") {
            if (eventLink.entity.targetPort.parent.node.node_type === "FinalDiagnostic") {
              http.excludeDiagnostic(eventLink.entity.sourcePort.parent.node.id, eventLink.entity.targetPort.parent.node.id);
              eventModel.link.displaySeparator(true);

                } else {
                  model.removeLink(eventModel.link.id)
                }
              } else {
                let node = eventLink.port.parent.node;
                let answerId = eventModel.link.sourcePort.dbId;
                if (eventModel.link.targetPort.in) {
                  if (type === "QuestionsSequence" && instanceable.category_name === 'Scored') { // Check if it is a diagram PSS
                    set('currentNode', node);
                    set('currentAnswerId', answerId);
                    set('currentLinkId', eventModel.link.id);
                    set('modalToOpen', 'InsertScore');
                    set('modalIsOpen', true)
                  } else {
                    // Create link in DB
                    http.createLink(node.id, answerId).then((response) => {
                      if (response.ok !== undefined && !response.ok) {
                        self.addFlashMessage("danger", response);
                        // if throw an error, remove link in diagram
                        if (model.getLink(eventModel.link.id) !== null) {
                          model.removeLink(eventModel.link.id);
                          self.updateEngine(engine);
                        }
                      }
                      self.updateEngine(engine);
                    }).catch((err) => {
                      console.log(err);
                    });
                  }
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
  createNode = (node, outPorts = [], color = "rgb(255,255,255)", inPort = true) => {
    const {addNode, readOnly} = this.props;

    let advancedNode = new AdvancedNodeModel(node, node.reference, outPorts, color, addNode, readOnly);
    if (inPort) {
      advancedNode.addInPort(" ");
    }
    return advancedNode;
  };

  // @params [String] status, [String] message
  // Call context method to display flash message
  addFlashMessage = async (status, response) => {
    const {addMessage} = this.props;
    let message = {
      status,
      messages: [`${response.statusText}`],
    };
    await addMessage(message);
  };

  onDropAction = async (event) => {
    const { removeNode, http, type, instanceable } = this.props;
    const { engine } = this.state;

    let model = engine.getDiagramModel();
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
    } else if (nodeDb.node_type === "FinalDiagnostic") {
      result = await http.createInstance(nodeDb.id);
      if (result.ok === undefined || result.ok) {
        nodeDiagram = this.createNode(nodeDb);
        nodeDiagram.addInPort(" ");
        nodeDiagram.addOutPort(" ");
        removeNode(nodeDb);
      } else {
        this.addFlashMessage("danger", result);
      }
    } else {
      // Create regular node
      result = await http.createInstance(nodeDb.id);
      if (result.ok === undefined || result.ok) {
        if (nodeDb.get_answers !== null) {
          // Don't add an inPort for PSS node
          if (type === "QuestionsSequence" && instanceable.category_name === 'Scored') { // Check if it is a diagram PSS
            nodeDiagram = this.createNode(nodeDb, nodeDb.get_answers, "rgb(255,255,255)", (type === nodeDb.node_type && instanceable.id === nodeDb.id));
          } else {
            nodeDiagram = this.createNode(nodeDb, nodeDb.get_answers);
          }
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
  };

  render = () => {
    const {engine} = this.state;
    const { readOnly } = this.props;

    let diagramStyle = readOnly ? 'col diagram-wrapper-white' : 'col diagram-wrapper';
    let canvasStyle = readOnly ? 'srd-canvas-read-only' : 'srd-canvas';

    return (
      <div className="content">
        <FormModal/>
        <FlashMessages/>
        <div className="row">
          {(!readOnly) ? ([
            <Toolbar/>,
            <NodeList/>
          ]) : null}
          <div
            className={diagramStyle}
            onDrop={async event => {
              this.onDropAction(event);
            }}
            onDragOver={event => {
              event.preventDefault();
            }}
          >
            <AdvancedDiagramWidget
              className={canvasStyle}
              diagramEngine={engine}
              allowCanvasZoom={false}
              allowCanvasTranslation={!readOnly}
              allowLooseLinks={!readOnly}
              maxNumberPointsPerLink={0}
            />
          </div>
        </div>
      </div>
    );
  };
}

export default withDiagram(Diagram);
