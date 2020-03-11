import * as React from "react";
import { SmartLayerWidget, TransformLayerWidget } from "@projectstorm/react-canvas-core";

export default class AdvancedCanvasWidget extends React.Component {
  constructor(props) {
    super(props);

    this.keyUp = null;
    this.keyDown = null;
    this.canvasListener = null;
    this.ref = React.createRef();

    this.state = {
      action: null,
      diagramEngineListener: null
    };
  }

  componentWillUnmount() {
    const { engine } = this.props;
    engine.deregisterListener(this.canvasListener);
    engine.setCanvas(null);

    document.removeEventListener("keyup", this.keyUp);
    document.removeEventListener("keydown", this.keyDown);
  }

  registerCanvas() {
    const { engine } = this.props;
    engine.setCanvas(this.ref.current);
    engine.iterateListeners(list => {
      list.rendered && list.rendered();
    });
  }

  componentDidUpdate() {
    this.registerCanvas();
  }

  componentDidMount() {
    const { engine } = this.props;
    this.canvasListener = engine.registerListener({
      repaintCanvas: () => {
        this.forceUpdate();
      }
    });

    this.keyDown = event => {
      const { engine } = this.props;
      engine.getActionEventBus().fireAction({ event });
    };
    this.keyUp = event => {
      const { engine } = this.props;
      engine.getActionEventBus().fireAction({ event });
    };

    document.addEventListener("keyup", this.keyUp);
    document.addEventListener("keydown", this.keyDown);
    this.registerCanvas();
  }

  render() {
    const { engine, className } = this.props;
    const model = engine.getModel();

    return (
      <div
        className={className}
        ref={this.ref}
        onMouseDown={event => {
          engine.getActionEventBus().fireAction({ event });
        }}
        onMouseUp={event => {
          engine.getActionEventBus().fireAction({ event });
        }}
        onMouseMove={event => {
          engine.getActionEventBus().fireAction({ event });
        }}>
        {model.getLayers().map(layer => {
          return (
            <TransformLayerWidget layer={layer} key={layer.getID()}>
              <SmartLayerWidget layer={layer} engine={engine} key={layer.getID()}/>
            </TransformLayerWidget>
          );
        })}
      </div>
    );
  }
}
