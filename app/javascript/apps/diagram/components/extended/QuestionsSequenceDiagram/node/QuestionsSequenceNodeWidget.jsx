import * as React from "react";
import { PortWidget } from "@projectstorm/react-diagrams-core";

import { withDiagram } from "../../../../engine/context/Diagram.context";
import { getLabel } from "../../../../helpers/nodeHelpers";
import store from "../../../../engine/reducers/store";
import { openModal } from "../../../../engine/reducers/creators.actions";
import I18n from "i18n-js";


class QuestionsSequenceNodeWidget extends React.Component {
  constructor(props) {
    super(props);
  }

  /**
   * Open questions sequence diagram
   */
  openDiagram() {
    const { node, http } = this.props;
    http.showQuestionsSequenceDiagram(node.options.dbInstance.node.id);
  }

  /**
   * Open modal to edit questions sequence
   */
  editQuestionsSequences() {
    const { node } = this.props;
    node.options.selected = false;

    store.dispatch(
      openModal(I18n.t("questions_sequences.edit.title"), "QuestionsSequenceForm", {
        questionsSequence: node.options.dbInstance.node,
        diagramObject: node,
        engine: node.options.engine,
        method: "update",
        from: "react"
      })
    );
  }

  render() {
    const { getReferencePrefix, node, engine } = this.props;

    return (
      <div className="node">
        <div className="port py-2 node-category">
          {node.getInPort() ?
            <div className="port srd-port in-port">
              <PortWidget engine={engine} port={node.getInPort()}>
                &nbsp; {/*It need to have content in PortWidget to make a link*/}
              </PortWidget>
            </div>
            : null}
          <div className="col pl-2 pr-0 text-left">
            {getReferencePrefix(node.options.dbInstance.node.node_type, node.options.dbInstance.node.type) + node.options.dbInstance.node.reference}
          </div>
          <div className="col pl-0 pr-2 text-center">
            {(node.options.dbInstance.node.category_name === "scored") ? node.options.dbInstance.node.min_score : ""}
          </div>
          <div className="col pl-0 pr-2 text-right">
            {(node.options.dbInstance.node.is_default === false) ? (
              <div className="dropdown">
                <button className="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton"
                        data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                </button>
                <div className="dropdown-menu" aria-labelledby="dropdownMenuButton">
                  <a className="dropdown-item" href="#" onClick={() => this.openDiagram()}>{I18n.t("open_diagram")}</a>
                  <a className="dropdown-item" href="#" onClick={() => this.editQuestionsSequences()}>{I18n.t("edit")}</a>
                </div>
              </div>
            ) : null}
          </div>
        </div>
        <div>
          <div className="py-2 node-label">
            <div className="col text-center">
              {getLabel(node.options.dbInstance.node)}
            </div>
          </div>
          <div className="node-answers">
            {node.getOutPorts().map((port, index) => (
              <div key={`div-${port.options.id}`} className="col px-0" style={{ position: "relative" }}>
                <div key={`name-${port.options.id}`} className="py-1 text-center answer-split">{port.options.name}</div>
                <PortWidget key={`port-${port.options.id}`} engine={engine} port={port} node={node}
                            className="out-port">
                  &nbsp; {/*It need to have content in PortWidget to make a link*/}
                </PortWidget>
              </div>
            ))}
          </div>
        </div>
      </div>
    );
  }
}

export default withDiagram(QuestionsSequenceNodeWidget);
