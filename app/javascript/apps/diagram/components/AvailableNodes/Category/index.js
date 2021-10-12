import * as React from "react";
import * as _ from "lodash";
import Item from "../Item";
import { getStudyLanguage } from "../../../../utils";

export default class Category extends React.Component {

  shouldComponentUpdate(nextProps) {
    return this.props.nodes.length !== nextProps.nodes.length;
  }

  render() {
    const { nodes, index } = this.props;
    const l = getStudyLanguage();

    // Sort nodes by label
    nodes.sort((a,b) => (a.label_translations[l] > b.label_translations[l]) ? 1 : ((b.label_translations[l] > a.label_translations[l]) ? -1 : 0));

    return (
      <div className="card" key={index}>
        <div className="card-header p-0" id={`heading-${index}`}>
          <div className="row">
            <div className="col">
              <button className="btn btn-link" type="button" data-toggle="collapse"
                      data-target={`#collapse-${index}`}
                      aria-expanded="true" aria-controls={`collapse-${index}`}>
                {_.startCase(index)}
                <span className="badge badge-secondary float-right">
              {nodes.length}
            </span>
              </button>
            </div>
          </div>
        </div>

        <div id={`collapse-${index}`} className={`collapse ${index === 0 ? `show` : ``}`}
             aria-labelledby={`heading-${index}`}
             data-parent="#accordionNodes">
          <div className="card-body p-0">
            {nodes.map((node) => (
              <Item node={node} key={node.reference}/>
            ))}
          </div>
        </div>
      </div>
    );
  }
}
