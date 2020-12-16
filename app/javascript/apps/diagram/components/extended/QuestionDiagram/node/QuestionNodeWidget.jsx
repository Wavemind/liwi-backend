import * as React from "react";
import { PortWidget } from "@projectstorm/react-diagrams-core";
import I18n from "i18n-js";

import store from "../../../../engine/reducers/store";
import { withDiagram } from "../../../../engine/context/Diagram.context";
import { getLabel } from "../../../../helpers/nodeHelpers";
import { openModal } from "../../../../engine/reducers/creators.actions";


class QuestionNodeWidget extends React.Component {
  constructor(props) {
    super(props);
    this.state = {};
  }

  /**
   * Open modal to edit final diagnostic
   */
  editQuestion() {
    const { node } = this.props;
    node.options.selected = false;

    store.dispatch(
      openModal(I18n.t("questions.edit.title"), "QuestionForm", {
        question: node.options.dbInstance.node,
        diagramObject: node,
        engine: node.options.engine,
        method: "update",
        is_used: true,
        from: "react"
      })
    );
  }

  render() {
    const { getReferencePrefix, node, engine, readOnly } = this.props;
    return (
      <div className={`node ${node.options.dbInstance.node.is_neonat ? 'is_neonat' : null}`}>
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
          <div className="col pl-0 pr-2 text-right">
            <div className="dropdown">
              <button className="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton"
                      data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
              </button>
              <div className="dropdown-menu" aria-labelledby="dropdownMenuButton">
                <a className={`dropdown-item ${readOnly ? 'disabled' : null}`} href="#" onClick={() => this.editQuestion()}>{I18n.t("edit")}</a>
              </div>
            </div>
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

export default withDiagram(QuestionNodeWidget);
