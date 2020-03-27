import { actions } from "../constants/actions.reducer";
export const initialState = {
  modal: {
    open: false,
    title: "",
    content: "",
    params: {}
  }
};

export default function DiagramReducer(state, action) {

  switch (action.type) {
    // Open modal
    case actions.OPEN_MODAL: {
      const { title, content, params } = action.payload;

      return {
        ...state,
        modal: {
          ...state.modal,
          open: true,
          title,
          content,
          params
        }
      };
    }

    // Close modal
    case actions.CLOSE_MODAL: {
      return {
        ...state,
        modal: {
          ...state.modal,
          open: false,
          title: "",
          content: "",
          params: {}
        }
      };
    }

    default:
      return state;
  }
}
