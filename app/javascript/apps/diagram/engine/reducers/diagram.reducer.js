export const initialState = {
  modal: {
    open: false,
    title: "",
    content: "",
  }
};
import { actions } from "../constants/actions.reducer";

export default function DiagramReducer(state, action) {

  switch (action.type) {
    // Open modal
    case actions.OPEN_MODAL: {
      const {title, content } = action.payload;

      return {
        ...state,
        modal: {
          ...state.modal,
          open: true,
          title,
          content,
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
        }
      };
    }

    default:
      return state;
  }
}
