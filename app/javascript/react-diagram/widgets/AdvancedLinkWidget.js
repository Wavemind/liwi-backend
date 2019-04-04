import * as React from "react";
import { DefaultLinkWidget } from "storm-react-diagrams";


class AdvancedLinkWidget extends DefaultLinkWidget {
  /**
   * Get direction of the link
   * Useful for animation
   * @method getDirection
   * @param source - source port
   * @param target - target port
   * @return true if direction should be reversed
   */
  getDirection(source: Object, target: Object): boolean {
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
    const { diagramEngine, link } = this.props,
      { selected } = this.state;

    let inversed = this.getDirection(link.sourcePort, link.targetPort);

    const Link = React.cloneElement(
      diagramEngine
        .getFactoryForLink(link)
        .generateLinkSegment(
          link,
          this,
          selected || link.isSelected(),
          path,
          inversed,
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

    // Needed for the creating Labels
    const LinkClone = (
      <path
        strokeWidth={1}
        stroke="rgba(0,0,0,0)"
        d={path}
        ref={ref => ref && this.refPaths.push(ref)}
      />
    );

    return (
      <g key={"link-" + id}>
        {LinkClone}
        {Link}
      </g>
    );
  }
}

export default AdvancedLinkWidget;
