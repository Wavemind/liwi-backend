import React, { Component } from 'react';
import SortableTree from 'react-sortable-tree';
import 'react-sortable-tree/style.css';
import DualListBox from "../VersionComponents";
import Http from "../../../diagram/engine/http";

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

    global.alert(
      result.toString().replaceAll(',', '\n')
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
                rowInfo.className = "order-node";
                rowInfo.buttons = [
                  <button
                    className="btn btn-outline-success"
                    style={{
                      verticalAlign: "middle"
                    }}
                    onClick={() => this.alertNodeDependencies(rowInfo)}
                  >
                    ℹ
                  </button>
                ];
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
