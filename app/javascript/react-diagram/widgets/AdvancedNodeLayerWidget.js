import * as React from "react";
import {
  NodeLayerWidget,
} from "storm-react-diagrams";
import * as _ from "lodash";

import { withDiagram } from "../../context/Diagram.context";

/**
 * @author Alain Fresco
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
      healthCares
    } = this.props;
    const HMargin = 80; // Horizontal Margin between boxes
    const VMargin = 210; // Vertical Margin between boxes
    const nodes = questions.concat([finalDiagnostics]).concat([healthCares]); // List of all the medical nodes

    let width = 1400; // Screen Width TODO Should be calculated not brut
    let x = 0;
    let y = 0;

    // Positioning questions
    nodes.map((level) => {
      let levelWidth = 0; // The width of each level

      // Calculating current level width
      level.map((question) => {
        let node = this.getNode(question);
        levelWidth += node.width;
        levelWidth += HMargin;
      });

      // Set X position for node in level
      x += width / 2 - levelWidth / 2;
      level.map((question) => {
        let node = this.getNode(question);
        node.setPosition(x, y);
        x += node.width + HMargin;
      });

      // Preparing next level
      x = 0;
      levelWidth = 0;
      if (level.length > 0) {
        y += VMargin;
      }
    });
  };
}

export default withDiagram(AdvancedNodeLayerWidget);
