import * as React from "react";
import AdvancedLinkSegmentWidget  from "./AdvancedLinkSegmentWidget";
import { DefaultLinkWidget } from "@projectstorm/react-diagrams";
import { LinkWidget } from "@projectstorm/react-diagrams-core";

import { AdvancedLinkArrowWidget } from "../../../../helpers/nodeHelpers";
import { withDiagram } from "../../../../engine/context/Diagram.context";

class AdvancedLinkWidget extends DefaultLinkWidget {
  generateArrow(point, previousPoint) {
    const { link } = this.props;

    return (
      <AdvancedLinkArrowWidget
        key={point.getID()}
        point={point}
        previousPoint={previousPoint}
        colorSelected={link.getOptions().selectedColor}
        color={link.getOptions().color}
      />
    );
  }

  generateLink(path, extraProps, id) {
    const ref = React.createRef();
    this.refPaths.push(ref);
    return (
      <AdvancedLinkSegmentWidget
        key={`link-${id}`}
        path={path}
        selected={this.state.selected}
        diagramEngine={this.props.diagramEngine}
        factory={this.props.diagramEngine.getFactoryForLink(this.props.link)}
        link={this.props.link}
        forwardRef={ref}
        onSelection={(selected) => {
          this.setState({ selected: selected });
        }}
        extras={extraProps}
      />
    );
  }

  render() {
    const { link } = this.props;
    // Ensure id is present for all points on the path
    let points = link.getPoints();
    let paths = [];
    this.refPaths = [];

    // Draw the multiple anchors and complex line instead
    for (let j = 0; j < points.length - 1; j++) {
      paths.push(
        this.generateLink(
          LinkWidget.generateLinePath(points[j], points[j + 1]),
          j
        )
      );
    }

    if (link.getTargetPort() !== null) {
      paths.push(this.generateArrow(points[points.length - 1], points[points.length - 2]));
    } else {
      paths.push(this.generatePoint(points[points.length - 1]));
    }

    return <g data-default-link-test={link.getOptions().testName}>{paths}</g>;
  }
}

export default withDiagram(AdvancedLinkWidget);
