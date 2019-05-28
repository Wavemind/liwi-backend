export const initialState = {
  forceUpdate: false
};
import { actions } from "./types.actions";

export default function DiagramReducer(state = initialState, action) {

  switch (action.type) {

    // Set engine in redux store
    case actions.SET_ENGINE: {
      const { engine } = action.payload;

      return {
        ...engine,
        diagramModel: {
          ...engine.diagramModel,
          links: {
            ...engine.diagramModel.links,
          },
          nodes: {
            ...engine.diagramModel.nodes
          }
        },
        forceUpdate: state.forceUpdate,
      };
    }

    // Force updating diagram
    case actions.FORCE_UPDATE: {
      const { boolean } = action.payload;

      // console.log(action);

      return {
        ...state,
        diagramModel: {
          ...state.diagramModel,
          links: {
            ...state.diagramModel.links,
          },
          nodes: {
            ...state.diagramModel.nodes,
          },
        },
        forceUpdate: boolean
      };
    }

    // Remove link
    case actions.REMOVED_LINK_STATE: {
      const { link } = action.payload;

      let links = { ...state.diagramModel.links };
      delete links[link.id];

      return {
        ...state,
        diagramModel: {
          ...state.diagramModel,
          links: {
            ...links,
          },
          nodes: {
            ...state.diagramModel.nodes,
          },
        }
      };
    }

    // Remove node
    case actions.REMOVED_ENTITIES: {
      const { node, links } = action.payload;

      let nodes = { ...state.diagramModel.nodes };
      delete nodes[node.id];

      let originalLinks = { ...state.diagramModel.links };
      links.map(link => delete originalLinks[link.id]);

      return {
        ...state,
        diagramModel: {
          ...state.diagramModel,
          nodes: {
            ...nodes,
          },
          links: {
            ...originalLinks,
          },
        }
      };
    }

    default:
      return state;
  }
}
