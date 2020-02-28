import * as React from "react";
import * as _ from "lodash";
// import NodeListItem from "./NodeListItem";
import { withDiagram } from "../../engine/context/Diagram.context"

class AvailableNodes extends React.Component {

  state = {
    orderedNodes: {},
    availableNodes: {}
  };

  constructor(props) {
    super(props);

    console.log(this.props);
  }

  render = () => {
    const { orderedNodes } = this.props;

    return (
      <div className="col-md-2 px-0 liwi-sidebar">
        <div className="accordion" id="accordionNodes">
          {Object.keys(orderedNodes).map(index => (
            <div className="card" key={index}>
              <div className="card-header p-0" id={`heading-${index}`}>
                <div className="row">
                  <div className="col">
                    <button className="btn btn-link" type="button" data-toggle="collapse"
                            data-target={`#collapse-${index}`}
                            aria-expanded="true" aria-controls={`collapse-${index}`}>
                      {_.startCase(index)}
                      <span className="badge badge-secondary float-right">
                    {orderedNodes[index].length}
                  </span>
                    </button>
                  </div>
                </div>
              </div>

              <div id={`collapse-${index}`} className={`collapse ${index === 0 ? `show` : ``}`}
                   aria-labelledby={`heading-${index}`}
                   data-parent="#accordionNodes">
                <div className="card-body p-0">
                  {orderedNodes[index].map((node) => (
                    node.reference
                    // <NodeListItem node={node} key={node.reference}/>
                  ))}
                </div>
              </div>
            </div>
          ))}
        </div>
      </div>
    );
  };
}

export default withDiagram(AvailableNodes);
