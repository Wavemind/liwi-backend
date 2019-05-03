import * as React from "react";
import {
  NodeLayerWidget,
} from "storm-react-diagrams";
import * as _ from "lodash";

import { withDiagram } from "../../context/Diagram.context";


class AdvancedNodeLayerWidget extends NodeLayerWidget {

  updateNodeDimensions = () => {
    if (!this.props.diagramEngine.nodesRendered) {
      const diagramModel = this.props.diagramEngine.getDiagramModel();
      _.map(diagramModel.getNodes(), node => {
        node.updateDimensions(this.props.diagramEngine.getNodeDimensions(node));
      });
    }
  };

  getNode = (nodes, question) => {
    return _.find(nodes, ["node.id", question.node_id]);
  };

  async componentDidMount() {
    await this.updateNodeDimensions();

    const {
      questions,
      finalDiagnostics,
      healthCares
    } = this.props;
    const diagramModel = this.props.diagramEngine.getDiagramModel();
    const diagramNodes = diagramModel.getNodes();
    const nodes = questions.concat([finalDiagnostics]).concat([healthCares])
    const HMargin = 80; // Horizontal Margin between boxes

    const VMargin = 210; // Vertical Margin between boxes
    let width = 1400;

    let x = 0;
    let y = 60;
    // Positionning questions
    nodes.map((level) => {
      let levelWidth = 0; // The width of each level

      level.map((question) => {
        let node = this.getNode(diagramNodes, question);
        console.log(question, node);
        levelWidth += node.width;
        console.log(node.width);
        levelWidth += HMargin;
      });
      x += width / 2 - levelWidth / 2;

      console.log(x);
      console.log(levelWidth);

      level.map((question) => {
        let node = this.getNode(diagramNodes, question);
        node.setPosition(x, y);
        x += node.width + HMargin;
      });

      x = 0;
      levelWidth = 0;
      if (level.length > 0) {
        y += VMargin;
      }
    });
  }
}

export default withDiagram(AdvancedNodeLayerWidget);
