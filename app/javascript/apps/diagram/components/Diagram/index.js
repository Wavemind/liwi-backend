// External import
import * as React from "react";
import * as _ from "lodash";
import createEngine, { DiagramModel } from "@projectstorm/react-diagrams";
import { NotificationContainer, NotificationManager } from "react-notifications";
import Appsignal from "@appsignal/javascript"
import 'react-notifications/lib/notifications.css';

// Internal import
import { withDiagram } from "../../engine/context/Diagram.context";
import { linkNode, createNode, linkFinalDiagnosisExclusion, getConditionPort } from "../../helpers/nodeHelpers";
import AdvancedCanvasWidget from "../extended/AdvancedDiagram/canvas/AdvancedCanvasWidget";
import AvailableNodes from "../AvailableNodes";
import Toolbar from "../Toolbar";
import AdvancedItemsActions from "../extended/AdvancedDiagram/AdvancedItemsActions";
import store from "../../engine/reducers/store";

import AdvancedLinkFactory from "../extended/AdvancedDiagram/link/AdvancedLinkFactory";
import AdvancedNodeFactory from "../extended/AdvancedDiagram/node/AdvancedNodeFactory";

import QuestionLinkFactory from "../extended/QuestionDiagram/link/QuestionLinkFactory";
import QuestionNodeFactory from "../extended/QuestionDiagram/node/QuestionNodeFactory";

import FinalDiagnosisLinkFactory from "../extended/FinalDiagnosisDiagram/link/FinalDiagnosisLinkFactory";
import FinalDiagnosisNodeFactory from "../extended/FinalDiagnosisDiagram/node/FinalDiagnosisNodeFactory";

import HealthCareLinkFactory from "../extended/HealthCareDiagram/link/HealthCareLinkFactory";
import HealthCareNodeFactory from "../extended/HealthCareDiagram/node/HealthCareNodeFactory";

import QuestionsSequenceLinkFactory from "../extended/QuestionsSequenceDiagram/link/QuestionsSequenceLinkFactory";
import QuestionsSequenceNodeFactory from "../extended/QuestionsSequenceDiagram/node/QuestionsSequenceNodeFactory";

import QuestionsSequenceScoreLabelFactory
  from "../extended/QuestionsSequenceScoreDiagram/label/QuestionsSequenceScoreLabelFactory";
import { openModal } from "../../engine/reducers/creators.actions";
import I18n from "i18n-js";

export class Diagram extends React.Component {

  constructor(props) {
    super(props);

    const engine = createEngine({ registerDefaultDeleteItemsAction: false });
    const model = new DiagramModel();

    // Override deleteKeys to control remove of node
    engine.eventBus.registerAction(new AdvancedItemsActions());

    // Register our own factory
    engine.getLinkFactories().registerFactory(new AdvancedLinkFactory());
    engine.getNodeFactories().registerFactory(new AdvancedNodeFactory());

    engine.getLinkFactories().registerFactory(new QuestionLinkFactory());
    engine.getNodeFactories().registerFactory(new QuestionNodeFactory());

    engine.getLinkFactories().registerFactory(new FinalDiagnosisLinkFactory());
    engine.getNodeFactories().registerFactory(new FinalDiagnosisNodeFactory());

    engine.getLinkFactories().registerFactory(new HealthCareLinkFactory());
    engine.getNodeFactories().registerFactory(new HealthCareNodeFactory());

    engine.getLinkFactories().registerFactory(new QuestionsSequenceLinkFactory());
    engine.getNodeFactories().registerFactory(new QuestionsSequenceNodeFactory());

    engine.getLabelFactories().registerFactory(new QuestionsSequenceScoreLabelFactory());

    this.state = {
      engine,
      model
    };

    this.initDiagram();
  }

  /**
   * Generate node + link based on database info and set it in diagram model
   */
  initDiagram() {
    const { engine, model } = this.state;
    const { instances, addAvailableNode, readOnly, instanceable, user } = this.props;

    let diagramNodes = [];

    // Generate questions
    instances.map(instance => {
      let diagramNode = createNode(instance, addAvailableNode, readOnly, instanceable.category_name, engine, user);
      diagramNodes.push(diagramNode);
      model.addAll(diagramNode);
    });

    // Generate link
    diagramNodes.map(diagramNode => {

      // Link between nodes
      diagramNode.options.dbInstance.conditions.map(condition => {
        let answerPort = getConditionPort(diagramNodes, condition.answer_id);

        let link = linkNode(answerPort, diagramNode, condition);
        model.addLink(link);
      });

      //  Exclusion links
      if (diagramNode.options.dbInstance.node.excluded_nodes_ids !== undefined) {
        diagramNode.options.dbInstance.node.excluded_nodes_ids.map(excludedDiagnosisId => {
          let excludedFinalDiagnosis = _.find(diagramNodes, (node) => {
            return node.options.dbInstance.node_id === excludedDiagnosisId;
          });
          if (excludedFinalDiagnosis !== undefined) {
            let link = linkFinalDiagnosisExclusion(diagramNode, excludedFinalDiagnosis);
            model.addLink(link);
          }
        });
      }
    });

    if (readOnly) {
      model.setLocked();
    }

    // Load model into engine
    engine.setModel(model);
  };

  /**
   * Create instance and init it in diagram when drop
   * @params [Object] event
   */
  onDropAction = async (event) => {
    const { http, addAvailableNode, removeAvailableNode, readOnly, instanceable, user } = this.props;
    const { engine } = this.state;

    let positions = engine.getRelativeMousePoint(event);
    let dbNode = JSON.parse(event.dataTransfer.getData("node"));

    // Launch modal when dropping a drug to set value in instance
    if (dbNode.type === "HealthCares::Drug") {
      store.dispatch(
        openModal(I18n.t("drugs.edit.title"), "DrugInstanceForm", {
          drug: dbNode,
          method: "create",
          from: "react",
          isFromAvailableNode: true,
          engine,
          removeAvailableNode,
          addAvailableNode,
          positions,
          is_deployed: readOnly
        })
      );
    } else {
      let httpRequest = await http.createInstance(dbNode.id, positions.x, positions.y);
      let result = await httpRequest.json();

      // Generate node if instance creation success
      if (httpRequest.status === 200) {
        // Generate node
        let diagramInstance = createNode(result, addAvailableNode, readOnly, instanceable.category_name, engine, user);

        // Display node in diagram
        engine.getModel().addNode(diagramInstance);
        engine.repaintCanvas();

        // Remove node from available nodes list
        removeAvailableNode(dbNode);
      } else {
        NotificationManager.error(result);
      }
    }
  };

  render() {
    const { readOnly } = this.props;
    const { engine, model } = this.state;

    // TODO reactivate when cutoffs are updated
    // if (readOnly) {
    //   model.setLocked(true)
    // }

    return (
      <div className="content">
        <div className="row">
          <Toolbar engine={engine} />
          <AvailableNodes />
          <NotificationContainer />
          <div className="col diagram-wrapper"
            onDrop={event => this.onDropAction(event)}
            onDragOver={event => {
              event.preventDefault();
            }}>
            <AdvancedCanvasWidget
              className="canvas srd-canvas"
              engine={engine}
              allowCanvasZoom={true}
              readOnly={readOnly}
            />
          </div>
        </div>
      </div>
    );
  };
}

export default withDiagram(Diagram);
