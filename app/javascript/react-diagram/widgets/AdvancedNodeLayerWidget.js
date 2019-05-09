import * as React from "react";
import {
  NodeLayerWidget,
} from "storm-react-diagrams";
import * as _ from "lodash";

import { withDiagram } from "../../context/Diagram.context";

/**
 * @author Alain Fresco
 * Extended because we needed to position the node after the dimension of the node have been calculated
 */
class AdvancedNodeLayerWidget extends NodeLayerWidget {

  async componentDidMount() {
    await this.updateNodeDimensions();
    await this.positionNodes();
    this.props.diagramEngine.repaintCanvas();
  }

  /**
   * Finds the diagram node based on the question
   * @method getNode
   * @param question - the question we want to find the node for
   * @return the node linke the the question
   */
  getNode = (question) => {
    const diagramNodes = this.props.diagramEngine.getDiagramModel().getNodes();
    return _.find(diagramNodes, ["node.id", question.node_id]);
  };

  /**
   * Position all the nodes
   * @method positionNodes
   */
  positionNodes = () => {
    const {
      questions,
      finalDiagnostics,
      healthCares,
      type,
    } = this.props;

    const hMargin = 80; // Horizontal Margin between boxes
    const vMargin = 210; // Vertical Margin between boxes
    let nodes;

    // List of all the medical nodes dependency type of diagram displayed
    if (type === 'Diagnostic') {
      nodes = questions.concat([finalDiagnostics]);
    } else if (type === 'PredefinedSyndrome') {
      nodes = questions;
    } else {
      nodes = questions.concat([healthCares]);
    }

    let width = 1400; // Screen Width TODO Should be calculated not brut
    let x = 0;
    let y = 50;
    console.log(type);

    nodes.map((level) => {
      // Positioning questions
      console.log(level);
      let levelWidth = 0; // The width of each level

      // Calculating current level width
      level.map((question) => {
        let node = this.getNode(question);
        console.log(node);
        console.log(node.width);
        levelWidth += node.width;
        levelWidth += hMargin;
      });

      // Set X position for node in level
      x += width / 2 - levelWidth / 2;
      level.map((question) => {
        let node = this.getNode(question);
        node.setPosition(x, y);
        x += node.width + vMargin;
      });

      // Preparing next level
      x = 0;
      levelWidth = 0;
      if (level.length > 0) {
        y += vMargin;
      }
    });
  };
}

export default withDiagram(AdvancedNodeLayerWidget);
