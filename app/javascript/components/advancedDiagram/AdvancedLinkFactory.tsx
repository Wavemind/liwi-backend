import * as React from "react";
import { DefaultLinkFactory } from "@projectstorm/react-diagrams";

import AdvancedLinkModel from "./AdvancedLinkModel";
import AdvancedLinkSegment from "./AdvancedLinkSegment";

export default class AdvancedLinkFactory extends DefaultLinkFactory {
  constructor() {
    super("advanced"); // <-- this matches with the link model above
  }

  generateModel(): AdvancedLinkModel {
    return new AdvancedLinkModel(); // <-- this is how we get new instances
  }

  /**
   * @override the DefaultLinkWidget makes use of this, and it normally renders that
   * familiar gray line, so in this case we simply make it return a new advanced segment.
   */
  generateLinkSegment(model: AdvancedLinkModel, selected: boolean, path: string) {
    return (
      <g>
        <AdvancedLinkSegment model={model} path={path}/>
      </g>
    );
  }
}
