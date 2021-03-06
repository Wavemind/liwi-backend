import * as React from "react";
import store from "../../../../engine/reducers/store";
import { openModal } from "../../../../engine/reducers/creators.actions";
import I18n from "i18n-js";
import { withDiagram } from "../../../../engine/context/Diagram.context";

class QuestionsSequenceScoreLabelWidget extends React.Component {
  constructor(props) {
    super(props);
  }

  editScore = (score) => {
    const { model } = this.props;

    let diagramObject = model.parent;
    if (diagramObject.targetPort.parent.options.diagramType === "scored") {
      let engine = diagramObject.sourcePort.parent.options.engine;
      let instanceId = diagramObject.targetPort.options.id;
      let answerId = diagramObject.sourcePort.options.id;
      let method = 'update';
      diagramObject.options.selected = false;

      store.dispatch(
        openModal(I18n.t("questions_sequences.edit.title"), "ScoreForm", {
          answerId,
          instanceId,
          diagramObject,
          engine,
          score,
          method
        })
      );
    }
  };

  render() {
    const { model, readOnly } = this.props;

    let score = model.getOptions().label;

    return (
      <div className={`diagram-label ${readOnly ? 'disabled' : null}`} onClick={() => this.editScore(score)}>
        {score}
      </div>
    );
  }
}

export default withDiagram(QuestionsSequenceScoreLabelWidget);

