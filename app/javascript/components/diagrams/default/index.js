import DefaultDiagram from './DefaultDiagram';
import { withDiagram } from "../../../context/Diagram.context";
import { connect } from 'react-redux';
import { setEngine, forceUpdate } from '../../../state-manager/creators.actions'
import { ActionCreators } from 'redux-undo';

const mapStateToProps = (engine, ownProps) => {
  return {
    engine,
  };
};

const mapDispatchToProps = (dispatch, ownProps) => {
  return {
    setEngine: (engine) => dispatch(setEngine(engine)),
    forceUpdate: (engine) => dispatch(forceUpdate(false)),
    undo: () => {
      dispatch(ActionCreators.undo());
      // TODO flag to know when inject state into diagram
      dispatch(forceUpdate(true));
    },
    redo: () => {
      dispatch(ActionCreators.redo());
      dispatch(forceUpdate(true));
    },
  };
};

export default connect(mapStateToProps, mapDispatchToProps)(withDiagram(DefaultDiagram));
