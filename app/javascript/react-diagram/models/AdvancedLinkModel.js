import { DefaultLinkModel, DiagramEngine } from "storm-react-diagrams";
import * as _ from "lodash";
import Http from "../../http";

class AdvancedLinkModel extends DefaultLinkModel {
  width: number;
  color: string;
  curvyness: number;
  markers: any;
  arrow: boolean;
  separator: boolean;

  constructor(type: string = "default") {
    super(type);
    this.color = "rgba(255,255,255,0.5)";
    this.width = 2;
    this.curvyness = 110;
    this.markers = { startMarker: true, endMarker: false };
    this.arrow = true;
    this.separator = false;

    const http = new Http();

    this.addListener({
      entityRemoved: function(removedLink) {

        // Don't trigger automatic removing link since node does it already
        if (removedLink.entity.selected) {
          if (removedLink.entity.sourcePort.parent.node.type === "FinalDiagnostic") {
            http.removeExcluding(removedLink.entity.sourcePort.parent.node.id);
          } else {
            let nodeId = removedLink.entity.targetPort.parent.node.id;
            let answerId = removedLink.entity.sourcePort.dbId;

            http.removeLink(nodeId, answerId);
          }
        }
      },
    });
  }

  serialize() {
    return _.merge(super.serialize(), {
      width: this.width,
      color: this.color,
      curvyness: this.curvyness,
      arrow: this.arrow,
      separator: this.separator,
    });
  }

  deSerialize(ob, engine: DiagramEngine) {
    super.deSerialize(ob, engine);
    this.color = ob.color;
    this.width = ob.width;
    this.curvyness = ob.curvyness;
  }

  addLabel(label: LabelModel | string) {
    if (label instanceof LabelModel) {
      return super.addLabel(label);
    }
    let labelOb = new DefaultLabelModel();
    labelOb.setLabel(label);
    return super.addLabel(labelOb);
  }

  setWidth(width: number) {
    this.width = width;
    this.iterateListeners((listener: DefaultLinkModelListener, event: BaseEvent) => {
      if (listener.widthChanged) {
        listener.widthChanged({ ...event, width: width });
      }
    });
  }

  setColor(color: string) {
    this.color = color;
    this.iterateListeners((listener: DefaultLinkModelListener, event: BaseEvent) => {
      if (listener.colorChanged) {
        listener.colorChanged({ ...event, color: color });
      }
    });
  }

  setMarkers(startMarker: boolean, endMarker: boolean) {
    this.markers = { startMarker: startMarker, endMarker: endMarker };
  }

  displayArrow(arrow: boolean) {
    this.arrow = arrow;
  }

  displaySeparator(separator: boolean) {
    this.separator = separator;
  }
}

export default AdvancedLinkModel;
