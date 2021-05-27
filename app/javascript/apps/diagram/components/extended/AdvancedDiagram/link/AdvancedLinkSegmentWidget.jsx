import * as React from 'react';
import I18n from "i18n-js";
import {openModal} from "../../../../engine/reducers/creators.actions";
import {DefaultLinkSegmentWidget} from "@projectstorm/react-diagrams";
import store from "../../../../engine/reducers/store";
import {withDiagram} from "../../../../engine/context/Diagram.context";

class AdvancedLinkSegmentWidget extends DefaultLinkSegmentWidget {

  constructor() {
    super('advanced');
  }

  render() {
    const Bottom = React.cloneElement(
      this.props.factory.generateLinkSegment(
        this.props.link,
        this.props.selected || this.props.link.isSelected(),
        this.props.path
      ),
      {
        ref: this.props.forwardRef
      }
    );

    const Top = React.cloneElement(Bottom, {
      strokeLinecap: 'round',
      onMouseLeave: () => {
        this.props.onSelection(false);
      },
      onMouseEnter: () => {
        this.props.onSelection(true);
      },
      ...this.props.extras,
      ref: null,
      'data-linkid': this.props.link.getID(),
      strokeOpacity: this.props.selected ? 0.1 : 0,
      strokeWidth: 20,
      fill: 'none',
      onContextMenu: () => {
        if (!this.props.link.isLocked()) {
          event.preventDefault();
          const { link, diagnosticDeployed } = this.props;
          const engine = link.sourcePort.parent.options.engine;
          const conditionId = link.options.dbConditionId;
          const conditionCutOffStart = link.options.cutOffStart;
          const conditionCutOffEnd = link.options.cutOffEnd;
          store.dispatch(
            openModal(I18n.t("conditions.cut_off_modal"), "CutOffForm", {
              engine,
              diagramObject: link,
              diagnosticDeployed,
              conditionId,
              conditionCutOffStart,
              conditionCutOffEnd
            })
          );

        }
      }
    });

    return (
      <g>
        {Bottom}
        {Top}
      </g>
    );
  }
}

export default withDiagram(AdvancedLinkSegmentWidget)
