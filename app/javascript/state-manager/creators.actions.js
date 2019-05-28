import { actions } from "./types.actions";

export const setEngine = (engine) => ({
  type: actions.SET_ENGINE,
  payload: {
    engine
  }
});

export const forceUpdate = (boolean) => ({
  type: actions.FORCE_UPDATE,
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

export const removedEntities = ( node, links ) => ({
  type: actions.REMOVED_ENTITIES,
  payload: {
    node, links
  }
});

