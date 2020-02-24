import { DefaultLinkModel } from '@projectstorm/react-diagrams';
import * as React from 'react';

export default class AdvancedLinkModel extends DefaultLinkModel {
  constructor() {
    super({
      type: 'advanced', // <-- here we give it a new type
      width: 10 // we specifically want this to also be width 10
    });
  }
}
