import * as React from "react";
import I18n from "i18n-js";
import { PortWidget } from "@projectstorm/react-diagrams-core";

import { withDiagram } from "../../../../engine/context/Diagram.context";
import { getLabel } from "../../../../helpers/nodeHelpers";
import { openModal } from "../../../../engine/reducers/creators.actions";
import store from "../../../../engine/reducers/store";


class FinalDiagnosisNodeWidget extends React.Component {
  constructor(props) {
    super(props);
  }

  /**
   * Open final diagnosis diagram
   */
  openDiagram() {
    const { node, http } = this.props;
    http.showFinalDiagnosisDiagram(node.options.dbInstance.node.id);
  }

  /**
   * Open modal to edit final diagnosis
   */
  editFinalDiagnosis() {
    const { node } = this.props;
    node.options.selected = false;

    store.dispatch(
      openModal(I18n.t("final_diagnoses.edit.title"), "FinalDiagnosisForm", {
        finalDiagnosis: node.options.dbInstance.node,
        diagramObject: node,
        engine: node.options.engine,
        method: "update",
        from: "react"
      })
    );
  }

  render() {
    const { getReferencePrefix, node, engine, readOnly, user } = this.props;
    const label = user.role === "admin" ? `${node.options.dbInstance.node.id} : ${getLabel(node.options.dbInstance.node)}` : getLabel(node.options.dbInstance.node);

    return (
      <div className="node">
        <div className="port py-2 node-category">
          <div className="port srd-port in-port">
            <PortWidget engine={engine} port={node.getPortByName("in")}>
              &nbsp; {/*It need to have content in PortWidget to make a link*/}
            </PortWidget>
          </div>
          <div className="col pl-2 pr-0 text-left">
            {getReferencePrefix(node.options.dbInstance.node.node_type, node.options.dbInstance.node.type) + node.options.dbInstance.node.reference}
          </div>
          <div className="col pl-0 pr-2 text-right">
            <div className="dropdown">
              <button className="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton"
                      data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
              </button>
              <div className="dropdown-menu" aria-labelledby="dropdownMenuButton">
                <a className="dropdown-item" href="#" onClick={() => this.openDiagram()}>{I18n.t("open_treatments")}</a>
                <a className={`dropdown-item ${readOnly ? 'disabled' : null}`} href="#" onClick={() => this.editFinalDiagnosis()}>{I18n.t("edit")}</a>
              </div>
            </div>
          </div>
        </div>
        <div>
          <div className="py-2 node-label">
            <div className="col text-center">
              {label}
            </div>
          </div>
          <div className="port inExcluded">
            <PortWidget engine={engine} port={node.getPortByName("excludedInPort")}>
              &nbsp; {/*It need to have content in PortWidget to make a link*/}
            </PortWidget>
          </div>
          <div className="port outExcluded">
            <PortWidget engine={engine} port={node.getPortByName("excludingOutPort")}>
              &nbsp; {/*It need to have content in PortWidget to make a link*/}
            </PortWidget>
          </div>
        </div>
      </div>
    );
  }
}

export default withDiagram(FinalDiagnosisNodeWidget);
