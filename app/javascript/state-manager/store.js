import { createStore } from 'redux';
import DiagramReducer from './diagram.reducer';
import undoable, { excludeAction, combineFilters } from 'redux-undo';
import { actions } from './types.actions'

export const store = createStore(undoable(DiagramReducer, {
  ignoreInitialState: true,
  filter: excludeAction(actions.FORCE_UPDATE)
}), window.__REDUX_DEVTOOLS_EXTENSION__ && window.__REDUX_DEVTOOLS_EXTENSION__());

