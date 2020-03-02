import * as React from "react";
import * as _ from "lodash";

import Category from "./Category";
import { withDiagram } from "../../engine/context/Diagram.context"

class AvailableNodes extends React.Component {

  state = {
    orderedNodes: {},
    availableNodes: {}
  };

  shouldComponentUpdate(nextProps) {
    return !_.isEqual(this.props.orderedNodes, nextProps.orderedNodes);
  }

  render = () => {
    const { orderedNodes } = this.props;

    return (
      <div className="col-md-2 px-0 liwi-sidebar">
        <div className="accordion" id="accordionNodes">
          {Object.keys(orderedNodes).map(index => <Category nodes={orderedNodes[index]} index={index} key={index} />)}
        </div>
      </div>
    );
  };
}

export default withDiagram(AvailableNodes);
