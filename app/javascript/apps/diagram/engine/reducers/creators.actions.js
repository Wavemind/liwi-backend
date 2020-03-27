import { actions } from "../constants/actions.reducer";

export const openModal = (title, content, params) => ({
  type: actions.OPEN_MODAL,
  payload: {
    title,
    content,
    params,
  }
});

export const closeModal = () => ({
  type: actions.CLOSE_MODAL,
  payload: {}
});
