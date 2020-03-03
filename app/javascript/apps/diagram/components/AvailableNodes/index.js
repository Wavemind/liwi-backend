import * as React from "react";
import * as _ from "lodash";
import FadeIn from 'react-fade-in';

import Category from "./Category";
import { withDiagram } from "../../engine/context/Diagram.context"

class AvailableNodes extends React.Component {

  state = {
    orderedNodes: {},
    availableNodes: {}
  };

  shouldComponentUpdate(nextProps) {
    console.log(this.props.orderedNodes, nextProps.orderedNodes)
    return !_.isEqual(this.props.orderedNodes, nextProps.orderedNodes);
  }

  render = () => {
    const { orderedNodes } = this.props;

    return (
      <div className="col-md-2 px-0 liwi-sidebar">
        <div className="accordion" id="accordionNodes">
          <FadeIn>
          {Object.keys(orderedNodes).map(index => <Category nodes={orderedNodes[index]} index={index} key={index} />)}
          </FadeIn>
        </div>
      </div>
    );
  };
}

export default withDiagram(AvailableNodes);
