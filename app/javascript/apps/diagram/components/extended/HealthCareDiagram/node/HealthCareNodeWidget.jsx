import * as React from "react";
import { PortWidget } from "@projectstorm/react-diagrams-core";

import { withDiagram } from "../../../../engine/context/Diagram.context";
import { getLabel } from "../../../../helpers/nodeHelpers";
import I18n from "i18n-js";
import store from "../../../../engine/reducers/store";
import { openModal } from "../../../../engine/reducers/creators.actions";


class HealthCareNodeWidget extends React.Component {
  constructor(props) {
    super(props);
  }

  /**
   * Open modal to edit health care
   */
  editHealthCare() {
    const { node } = this.props;
    node.options.selected = false;

    let params = {
      diagramObject: node,
      engine: node.options.engine,
      method: "update",
      from: "react"
    };

    if (node.options.dbInstance.node.type === "HealthCares::Management") {
      store.dispatch(
        openModal(I18n.t("managements.edit.title"), "ManagementForm", {
          management: node.options.dbInstance.node,
          ...params
        })
      );
    } else {
      store.dispatch(
        openModal(I18n.t("drugs.edit.title"), "DrugForm", {
          drug: node.options.dbInstance.node,
          ...params
        })
      );
    }
  }

  editHealthCareInstance() {
    const { node } = this.props;
    node.options.selected = false;

    let params = {
      diagramObject: node,
      engine: node.options.engine,
      method: "update",
      from: "react"
    };

    store.dispatch(
      openModal(I18n.t("drugs.edit.title"), "DrugForm", {
        drug: node.options.dbInstance.node,
        step: 3,
        ...params
      })
    );
  }

  render() {
    const { getReferencePrefix, node, engine } = this.props;

    return (
      <div className="node">
        <div className="port py-2 node-category">
          <div className="port srd-port in-port">
            <PortWidget engine={engine} port={node.getInPort()}>
              &nbsp; {/*It need to have content in PortWidget to make a link*/}
            </PortWidget>
          </div>
          <div className="col pl-2 pr-0 text-left">
            {getReferencePrefix(node.options.dbInstance.node.node_type, node.options.dbInstance.node.type) + node.options.dbInstance.node.reference}
          </div>
          <div className="col pl-0 pr-2 text-right">
            {(node.options.dbInstance.node.is_default === false) ? (
              <div className="dropdown">
                <button className="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton"
                        data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                </button>
                <div className="dropdown-menu" aria-labelledby="dropdownMenuButton">
                  <a className="dropdown-item" href="#" onClick={() => this.editHealthCare()}>{I18n.t("edit")}</a>
                  <a className="dropdown-item" href="#" onClick={() => this.editHealthCareInstance()}>{I18n.t("drugs.edit_instance")}</a>
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
        </div>
      </div>
    );
  }
}

export default withDiagram(HealthCareNodeWidget);
