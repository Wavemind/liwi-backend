import * as React from "react";
import { DefaultLinkWidget } from "storm-react-diagrams";

import { withDiagram } from "../../context/Diagram.context";

/**
 * @author Alain Fresco
 * Extended because we needed to handle the direction of the links
 */
class AdvancedLinkWidget extends DefaultLinkWidget {

  /**
   * Get direction of the link
   * Useful for animation
   * @method getDirection
   * @param source - source port
   * @param target - target port
   * @return true if direction should be reversed
   */
  getDirection(link: Object): boolean {
    const source = link.points[0];
    const target = link.points[link.points.length - 1];
    const difX = source.x - target.x,
          difY = source.y - target.y,
          isHorisontal = Math.abs(difX) > Math.abs(difY);
    return isHorisontal ? difX > 0 : difY > 0;
  }

  // Override the method from DefaultLinkWidget so it can calculate path from AdvancedLink
  calculateLabelPosition = (label, index: number) => {
    if (!this.refLabels[label.id]) {
      // no label? nothing to do here
      return;
    }

    const labelDimensions = {
      width: this.refLabels[label.id].offsetWidth,
      height: this.refLabels[label.id].offsetHeight
    };

    // Calcultate position from parent link
    const centerX = (label.parent.points[0].x + label.parent.points[1].x) / 2;
    const centerY = (label.parent.points[0].y + label.parent.points[1].y) / 2;

    const labelCoordinates = {
      x: centerX - labelDimensions.width / 2 + label.offsetX,
      y: centerY + label.offsetY
    };
    this.refLabels[label.id].setAttribute(
      "style",
      `transform: translate(${labelCoordinates.x}px, ${labelCoordinates.y}px);`
    );
  };

  /**
   * Generate link
   * @method generateLink
   * @param path - link path
   * @param extraProps - extra properties
   * @param id - link idea
   * @return Link path
   */
  generateLink(
    path: string,
    extraProps: any,
    id: string | number
  ): Element<"g"> {
    const { diagramEngine, link } = this.props;
    const { selected } = this.state;


    const Top = React.cloneElement(
      diagramEngine
        .getFactoryForLink(link)
        .generateLinkSegment(
          link,
          this,
          selected || link.isSelected(),
          path,
          this.getDirection(link)
        ),
      {
        ...extraProps,
        strokeLinecap: "round",
        "data-linkid": link.getID(),
        onContextMenu: event => {
          if (!this.props.diagramEngine.isModelLocked(link)) {
            event.preventDefault();
            link.remove();
          }
        }
      }
    );

    return (
      <g key={"link-" + id}>
        {Top}
      </g>
    );
  }
}

export default withDiagram(AdvancedLinkWidget);
