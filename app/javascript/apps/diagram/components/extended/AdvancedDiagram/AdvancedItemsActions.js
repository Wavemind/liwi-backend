import {Action, InputType} from '@projectstorm/react-canvas-core';
import * as _ from 'lodash';
import I18n from "i18n-js";

/**
 * Deletes all selected items
 */
export default class AdvancedItemsActionOptions extends Action {
  constructor(options = {}) {
    const keyCodes = options.keyCodes || [46, 8];
    const modifiers = {
      ctrlKey: false,
      shiftKey: false,
      altKey: false,
      metaKey: false,
      ...options.modifiers
    };

    super({
        type: InputType.KEY_DOWN,
        fire: (event) => {
          const {keyCode, ctrlKey, shiftKey, altKey, metaKey} = event.event;
          if (keyCodes.indexOf(keyCode) !== -1 && _.isEqual({ctrlKey, shiftKey, altKey, metaKey}, modifiers)) {
            let confirm = true;
            if (this.engine.getModel().getSelectedEntities().some((a) => a.options.type === "finalDiagnosis")) {
              confirm = window.confirm(I18n.t("final_diagnoses.confirmation"));
            }
            if (confirm) {
              _.forEach(this.engine.getModel().getSelectedEntities(), entity => {
                // only delete items which are not locked
                if (!entity.locked) {
                  entity.remove();
                }
              });
            }
            this.engine.repaintCanvas();
          }
        }
      }
    )
  }
}
