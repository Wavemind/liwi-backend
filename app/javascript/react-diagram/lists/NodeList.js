import * as React from "react";
import NodeListItem from "./NodeListItem";
import * as _ from "lodash";

class NodeList extends React.Component {

  state = {
    orderedNodes: {}
  };

  constructor(props) {
    super(props);
  }

  componentWillMount() {
    const { nodes } = this.props;

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
      finalDiagnostic: [],
    };

    // Assign node to correct array
    nodes.map((node) => {
      let category = '';

      if (node.type === 'Question') {
        category = _.camelCase(node.category_name);
      } else {
        category = _.camelCase(node.type);
      }

      orderedNodes[category].push(node);
    });

    this.setState({orderedNodes})
  }

  render = () => {
    const { orderedNodes } = this.state;

    return (
      <div className="accordion mt-5" id="accordionNodes">
        {Object.keys(orderedNodes).map( index => (
          <div className="card">
            <div className="card-header" id={`heading-${index}`}>
              <h2 className="mb-0">
                <button className="btn btn-link" type="button" data-toggle="collapse" data-target={`#collapse-${index}`}
                        aria-expanded="true" aria-controls={`collapse-${index}`}>
                  {_.startCase(index)}
                </button>
              </h2>
            </div>

            <div id={`collapse-${index}`} className={`collapse ${index === 0 ? `show` : ``}`} aria-labelledby={`heading-${index}`}
                 data-parent="#accordionNodes">
              <div className="card-body">
                {orderedNodes[index].map((node) => (
                  <NodeListItem node={node}/>
                ))}
              </div>
            </div>
          </div>
        ))}
      </div>
    );
  };
}

export default NodeList;
