import { NodeModel, DefaultPortModel } from '@projectstorm/react-diagrams';
import { BaseModelOptions } from '@projectstorm/react-canvas-core';

export interface AdvancedNodeModelOptions extends BaseModelOptions {
  color?: string;
  dbNode?: object;
}

export default class AdvancedNodeModel extends NodeModel {
  color: string;
  node: object;

  constructor(options: AdvancedNodeModelOptions = {}) {
    super({
      ...options,
      type: 'advanced'
    });
    this.color = options.color || 'red';
    this.node = options.dbNode || {};

    // setup an in and out port
    this.addPort(
      new DefaultPortModel({
        in: true,
        name: 'in'
      })
    );
    this.addPort(
      new DefaultPortModel({
        in: false,
        name: 'out'
      })
    );
  }

  serialize() {
    return {
      ...super.serialize(),
      color: this.color
    };
  }

  deserialize(event): void {
    super.deserialize(event);
    this.color = event.data.color;
  }
}
