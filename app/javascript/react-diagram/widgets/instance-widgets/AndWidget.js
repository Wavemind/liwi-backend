import * as React from "react";

/**
 * @author Manu Barchchat with <3
 */
class AndWidget extends React.Component {
  constructor(props) {
    super(props);
    this.state = {};
  }

  render() {
    const { diagramNode } = this.props;
    let inPort = diagramNode.getInPort();

    return (
      <div className="node and">
        <div className="port py-2 node-category">
          <div className="port srd-port in-port" data-name={inPort.name} data-nodeid={inPort.parent.id}/>
          <div className="col pl-2 pr-0 text-left">
            AND
          </div>
        </div>
        <div>
          <div className="node-answers">
            <div className="port srd-port" style={{top: 28, left: 8}} data-name={diagramNode.getOutPort().name}
                 data-nodeid={diagramNode.getOutPort().parent.id}/>
          </div>
        </div>
      </div>
    );
  }
}

export default AndWidget;
