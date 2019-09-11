import {
  DefaultLinkModel,
  DiagramEngine,
  LabelModel,
  DefaultLabelModel
} from "storm-react-diagrams";
import * as _ from "lodash";
import Http from "../../http";

class AdvancedLinkModel extends DefaultLinkModel {
  width;
  color;
  curvyness;
  markers;
  arrow;
  separator;
  isReadOnly;

  constructor(isReadOnly, type = "default") {
    super(type);
    this.color = "rgba(255,255,255,0.5)";
    this.width = 2;
    this.curvyness = 0;
    this.markers = { startMarker: true, endMarker: false };
    this.arrow = true;
    this.separator = false;
    this.isReadOnly = isReadOnly;

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

  deSerialize(ob, engine) {
    super.deSerialize(ob, engine);
    this.color = ob.color;
    this.width = ob.width;
    this.curvyness = ob.curvyness;
  }

  addLabel(label) {
    if (label instanceof LabelModel) {
      return super.addLabel(label);
    }
    let labelOb = new DefaultLabelModel();
    labelOb.setLabel(label);
    return super.addLabel(labelOb);
  }

  setWidth(width) {
    this.width = width;
    this.iterateListeners((listener, event) => {
      if (listener.widthChanged) {
        listener.widthChanged({ ...event, width: width });
      }
    });
  }

  setColor(color) {
    this.color = color;
    this.iterateListeners((listener, event) => {
      if (listener.colorChanged) {
        listener.colorChanged({ ...event, color: color });
      }
    });
  }

  setMarkers(startMarker, endMarker) {
    this.markers = { startMarker: startMarker, endMarker: endMarker };
  }

  displayArrow(arrow) {
    this.arrow = arrow;
  }

  displaySeparator(separator) {
    this.separator = separator;
  }

  isLocked() {
    return this.isReadOnly;
  }
}

export default AdvancedLinkModel;
