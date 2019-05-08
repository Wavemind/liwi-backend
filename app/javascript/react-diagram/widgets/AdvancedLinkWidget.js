import * as React from "react";
import { DefaultLinkWidget } from "storm-react-diagrams";

import { withDiagram } from "../../context/Diagram.context";


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
