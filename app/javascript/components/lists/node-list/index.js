import NodeList from './NodeList';
import { withDiagram } from "../../../context/Diagram.context";
import { connect } from 'react-redux';
import { forceUpdate } from '../../../state-manager/creators.actions'

const mapStateToProps = (engine, ownProps) => {
  return {
    engine,
  };
};

const mapDispatchToProps = (dispatch, ownProps) => {
  return {
    forceUpdate: () => dispatch(forceUpdate(false)),
  };
};

export default connect(mapStateToProps, mapDispatchToProps)(withDiagram(NodeList));
