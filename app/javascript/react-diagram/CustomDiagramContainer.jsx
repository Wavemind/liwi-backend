// @flow
import React, {PureComponent} from "react";

import type {Node, ChildrenArray} from "react";

export const markerHead = "markerHead",
  markerHeadInversed = "markerHeadInversed";

/**
 * Create container wrapper for the bot edit flow diagram
 * @function BotDetailEditFlowDiagramContainer
 * @return wrapper container
 */
class CustomDiagramContainer extends PureComponent<Props> {

  // eslint-disable-next-line require-jsdoc
  render() {
    const {handleAddStep, handleZoomToFit, handleAutoDistribute, children} = this.props;

    return (
      <div className="bot-diagram">
        <div className="bot-diagram__content">{children}</div>
        <svg>
          <defs>
            <marker id={markerHead} markerWidth="6" markerHeight="4" refX="5" refY="2" orient="auto">
              <path d="M0,0 L0,4 L4,2 Z" style={{fill: "#b5d9fd"}} />
            </marker>

            <marker id={markerHeadInversed} markerWidth="6" markerHeight="4" refX="-1" refY="2" orient="auto">
              <path d="M4,0 L4,4 L0,2 Z" style={{fill: "#b5d9fd"}} />
            </marker>
          </defs>
        </svg>
      </div>
    )
  }
}

export default CustomDiagramContainer;
