import { actions } from "./types.actions";

export const setEngine = (engine) => ({
  type: actions.SET_ENGINE,
  payload: {
    engine
  }
});

export const setDiagram = (boolean) => ({
  type: actions.SET_DIAGRAM,
  payload: {
    boolean
  }
});

export const removedLinkState = (link) => ({
  type: actions.REMOVED_LINK_STATE,
  payload: {
    link
  }
});

export const removedNodeState = ( node ) => ({
  type: actions.REMOVED_NODE_STATE,
  payload: {
    node
  }
});

