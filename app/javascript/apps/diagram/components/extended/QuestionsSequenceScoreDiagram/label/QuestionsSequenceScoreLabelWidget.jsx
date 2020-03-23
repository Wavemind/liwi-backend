import * as React from "react";
import store from "../../../../engine/reducers/store";
import { openModal } from "../../../../engine/reducers/creators.actions";
import I18n from "i18n-js";

export default class QuestionsSequenceScoreLabelWidget extends React.Component {
  constructor(props) {
    super(props);
  }

  editScore = (score) => {
    const { model } = this.props;

    let diagramObject = model.parent;
    let engine = diagramObject.sourcePort.parent.engine;
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
  };

  render() {
    const { model } = this.props;

    let score = model.getOptions().label;

    return (
      <div className="diagram-label" onClick={() => this.editScore(score)}>
        {score}
      </div>
    );
  }
}

