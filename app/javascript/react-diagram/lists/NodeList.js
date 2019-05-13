import * as React from "react";
import * as _ from "lodash";
import NodeListItem from "./NodeListItem";
import { withDiagram } from "../../context/Diagram.context";

class NodeList extends React.Component {

  state = {
    orderedNodes: {},
    availableNodes: {}
  };

  constructor(props) {
    super(props);
  }

  render = () => {
    const { orderedNodes } = this.props;

    return (
      <div className="accordion" id="accordionNodes">
        {Object.keys(orderedNodes).map(index => (
          <div className="card" key={index}>
            <div className="card-header" id={`heading-${index}`}>
              <div className="row">
                <div className="col">
                  <button className="btn btn-link p-0" type="button" data-toggle="collapse"
                          data-target={`#collapse-${index}`}
                          aria-expanded="true" aria-controls={`collapse-${index}`}>
                    {_.startCase(index)}
                  </button>
                </div>
                <div className="col text-right">
                     <span className="badge badge-secondary text-right">
                  {orderedNodes[index].length}
                </span>
                </div>
              </div>
            </div>

            <div id={`collapse-${index}`} className={`collapse ${index === 0 ? `show` : ``}`}
                 aria-labelledby={`heading-${index}`}
                 data-parent="#accordionNodes">
              <div className="card-body p-0">
                {orderedNodes[index].map((node) => (
                  <NodeListItem node={node} key={node.reference}/>
                ))}
              </div>
            </div>
          </div>
        ))}
      </div>
    );
  };
}

export default withDiagram(NodeList);
