import React, { Component } from 'react';
import SortableTree from 'react-sortable-tree';
import 'react-sortable-tree/style.css';
import DualListBox from "../VersionComponents";
import Http from "../../../diagram/engine/http";
import I18n from "i18n-js";

export default class VersionOrders extends Component {
  constructor(props) {
    super(props);
    const { tree } = this.props;

    this.state = {
      http: new Http(),
      treeData: JSON.parse(tree),
    };
  }

  onChange = () => {
    const { http, treeData } = this.state;
    http.updateFullOrder(JSON.stringify(treeData));
  };

  // Display the dependencies of the node clicked on
  alertNodeDependencies = async (rowInfo) => {
    const { http } = this.state;

    let httpRequest = await http.getQuestionDependencies(rowInfo['node']['id']);
    let result = await httpRequest.json();
    const message = result.length === 0 ? I18n.t("version.full_order_tree.no_dependency") : result.toString().replaceAll(',', '\n')

    global.alert(
      message
    );
  };

  render() {
    const { selected } = this.props;
    return (
      <div style={{height: 1000}}>
        <SortableTree
          treeData={this.state.treeData}
          onChange={treeData => this.setState({ treeData })}
          onMoveNode={this.onChange}
          canDrag={treeData => {
            return !["attribute", "step"].includes(treeData["node"]["type"]);
          }}
          canDrop={treeData => {
            return treeData['nextParent'] !== null && treeData['prevParent']['title'] === treeData['nextParent']['title']
          }}
          generateNodeProps={rowInfo => {
            if (["attribute", "step"].includes(rowInfo["node"]["type"])) {
              rowInfo.className = "order-step";
            } else if (rowInfo["node"]["type"] === "system"){
              rowInfo.className = "order-system";
            } else {
              if (selected.includes(rowInfo["node"]["id"])){
                if (rowInfo["node"]["is_neonat"]){
                  rowInfo.className = "order-node-neonat";
                } else {
                  rowInfo.className = "order-node";
                }

                if (![0,1,3,8].includes(rowInfo["path"][0])) { // Don't display the dependencies button for the 4 steps in array (registration, fla, bm and referral)
                  rowInfo.buttons = [
                    <button
                      className="btn btn-outline-success"
                      style={{
                        verticalAlign: "middle"
                      }}
                      onClick={() => this.alertNodeDependencies(rowInfo)}
                      placeholder={I18n.t("version.full_order_tree.show_dependencies")}
                    >
                      ℹ
                    </button>
                  ];
                }
              } else {
                rowInfo.className = "order-node-disabled";
              }
            }

            return rowInfo;
          }}
        />
      </div>
    );
  }
};
