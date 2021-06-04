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

  render() {
    const { selected } = this.props;
    return (
      <div style={{height: 1000}}>
        <SortableTree
          treeData={this.state.treeData}
          onChange={treeData => this.setState({ treeData })}
          onMoveNode={this.onChange}
          canDrag={treeData => {
            return treeData["node"]["subtitle"] !== "Step";
          }}
          canDrop={treeData => {
            return treeData['nextParent'] !== null && treeData['prevParent']['title'] === treeData['nextParent']['title']
          }}
          generateNodeProps={rowInfo => {
            if (rowInfo["node"]["subtitle"] === "Step") {
              rowInfo.className = "order-step";
            } else if (rowInfo["node"]["subtitle"] === "System"){
              rowInfo.className = "order-system";
            } else {
              if (selected.includes(rowInfo["node"]["id"])){
                rowInfo.className = "order-node";
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
