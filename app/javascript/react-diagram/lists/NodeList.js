import * as React from "react";
import * as _ from "lodash";
import NodeListItem from "./NodeListItem";
import { withDiagram } from "../../context/Diagram.context";

class NodeList extends React.Component {

  state = {
    orderedNodes: {}
  };

  constructor(props) {
    super(props);
  }

  componentWillMount() {
    this.orderNodes();
  }

  shouldComponentUpdate(nextProps, nextState) {
    // console.log('#######################################');
    // console.log(nextProps.orderedNodes);
    // console.log(this.state.orderedNodes);
    return nextProps.orderedNodes !== this.state.orderedNodes;
  }

  orderNodes = () => {
    const { availableNodes, set } = this.props;

    let orderedNodes = {
      exposure: [],
      symptom: [],
      assessmentTest: [],
      physicalExam: [],
      predefinedSyndrome: [],
      comorbidity: [],
      predefinedCondition: [],
      treatment: [],
      management: [],
      finalDiagnostic: []
    };

    // Assign node to correct array
    availableNodes.map((node) => {
      let category = "";

      if (node.type === "Question" || node.type === "PredefinedSyndrome") {
        category = _.camelCase(node.category_name);
      } else {
        category = _.camelCase(node.type);
      }
      orderedNodes[category].push(node);
    });

    this.setState({ orderedNodes });
    set('orderedNodes', orderedNodes);
  };

  render = () => {
    const { orderedNodes } = this.state;

    return (
      <div className="accordion" id="accordionNodes">
        {Object.keys(orderedNodes).map(index => (
          <div className="card" key={index}>
            <div className="card-header" id={`heading-${index}`}>
              <h2 className="mb-0">
                <button className="btn btn-link" type="button" data-toggle="collapse" data-target={`#collapse-${index}`}
                        aria-expanded="true" aria-controls={`collapse-${index}`}>
                  {_.startCase(index)}
                </button>
              </h2>
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
