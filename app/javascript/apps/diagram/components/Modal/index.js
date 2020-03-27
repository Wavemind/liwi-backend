import { connect } from "react-redux";
import AdvancedModal from "./AdvancedModal";
import { withDiagram } from "../../engine/context/Diagram.context";
import { closeModal } from "../../engine/reducers/creators.actions";

const mapStateToProps = (state) => {
  return { state };
};

const mapDispatchToProps = (dispatch) => {
  return {
    closeModal: (title, content) => dispatch(closeModal(title, content))
  };
};

export default connect(mapStateToProps, mapDispatchToProps)(withDiagram(AdvancedModal));
