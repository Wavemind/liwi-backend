export const initialState = {
  setDiagram: false
};
import { actions } from "./types.actions";

export default function DiagramReducer(state = initialState, action) {

  console.log(action)

  switch (action.type) {
    case actions.SET_ENGINE: {
      const { engine } = action.payload;

      console.log(action)

      return {
        setDiagram: state.setDiagram,
        ...engine,
        diagramModel: {
          ...engine.diagramModel,
          links: {
            ...engine.diagramModel.links,
          },
          nodes: {
            ...engine.diagramModel.nodes
          }
        }
      };
    }

    case actions.SET_DIAGRAM: {
      const { boolean } = action.payload;

      return {
        ...state,
        setDiagram: boolean
      };
    }

    case actions.REMOVED_LINK_STATE: {
      const { link } = action.payload;

      let links = state.diagramModel.links;
      delete links[link.entity.id];

      return {
        ...state,
        diagramModel: {
          ...state.diagramModel,
          links: {
            ...links,
          },
        }
      };
    }

    case actions.REMOVED_NODE_STATE: {
      const { node } = action.payload;

      let nodes = state.diagramModel.nodes;
      delete nodes[node.entity.id];

      return {
        ...state,
        diagramModel: {
          ...state.diagramModel,
          nodes: {
            ...nodes,
          },
        }
      };
    }

    case 'UNDO': {
      const {  } = action.payload;

     console.log(action)

      return {
        ...state,
      };
    }

    default:
      return state;
  }
}
