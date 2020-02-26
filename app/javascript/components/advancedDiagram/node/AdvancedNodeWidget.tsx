import * as React from 'react';
import { DiagramEngine, PortWidget } from '@projectstorm/react-diagrams-core';
import AdvancedNodeModel from './AdvancedNodeModel';

export interface AdvancedNodeWidgetProps {
  node: AdvancedNodeModel;
  engine: DiagramEngine;
}

export interface TSCustomNodeWidgetState {}

export default class AdvancedNodeWidget extends React.Component<AdvancedNodeWidgetProps, TSCustomNodeWidgetState> {
  constructor(props: AdvancedNodeWidgetProps) {
    super(props);
    this.state = {};
  }

  render() {
    console.log(this.props);

    return (
      <div className="custom-node">
        <PortWidget engine={this.props.engine} port={this.props.node.getPort('in')}>
          <div className="circle-port" />
        </PortWidget>
        <PortWidget engine={this.props.engine} port={this.props.node.getPort('out')}>
          <div className="circle-port" />
        </PortWidget>
        <div className="custom-node-color" style={{ backgroundColor: this.props.node.color }} />
      </div>
    );

    // return (
    //   <div className="node">
    //     <div className="port py-2 node-category">
    //       {(inPort !== undefined) ? (
    //         <div className="port srd-port in-port" data-name={inPort.name} data-nodeid={inPort.parent.id}/>
    //       ) : null}
    //       <div className="col pl-2 pr-0 text-left">
    //         {getReferencePrefix(diagramNode.node.node_type, diagramNode.node.type) + diagramNode.node.reference}
    //       </div>
    //       <div className="col pl-0 pr-2 text-center">
    //         {(diagramNode.node.category_name === 'scored') ? diagramNode.node.min_score : ''}
    //       </div>
    //       <div className="col pl-0 pr-2 text-right">
    //         {(diagramNode.node.is_default === false) ? (
    //           <div className="dropdown">
    //             <button className="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
    //             </button>
    //             <div className="dropdown-menu" aria-labelledby="dropdownMenuButton">
    //               {(diagramNode.node.node_type === "QuestionsSequence") ? (<a className="dropdown-item" href="#" onClick={() => this.openDiagram(diagramNode.node.id)}>Open diagram</a>) : null}
    //               <a className="dropdown-item" href="#" onClick={() => this.editNode(diagramNode)}>Edit</a>
    //             </div>
    //           </div>
    //         ) : null}
    //       </div>
    //     </div>
    //     <div>
    //       <div className="py-2 node-label">
    //         <div className="col text-center">
    //           {diagramNode.node.label_translations["en"]}
    //         </div>
    //       </div>
    //       <div className="node-answers">
    //         {outPorts}
    //       </div>
    //     </div>
    //   </div>
    // )
  }
}
