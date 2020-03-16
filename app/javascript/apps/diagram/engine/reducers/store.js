import { createStore } from "redux";
import DiagramReducer from "./diagram.reducer";
import { initialState } from "./diagram.reducer";

export default createStore(
  DiagramReducer,
  { ...initialState },
  window.__REDUX_DEVTOOLS_EXTENSION__ && window.__REDUX_DEVTOOLS_EXTENSION__()
);

