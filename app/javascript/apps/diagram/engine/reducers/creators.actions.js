import { actions } from "../constants/actions.reducer";

export const openModal = (title, content) => ({
  type: actions.OPEN_MODAL,
  payload: {
    title,
    content,
  }
});

export const closeModal = () => ({
  type: actions.CLOSE_MODAL,
  payload: {}
});
