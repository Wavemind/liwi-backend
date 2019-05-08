import React from "react";
import { withDiagram } from "../context/Diagram.context";

class Alert extends React.Component {

  alertClass (type) {
    let classes = {
      danger: "alert-danger",
      warning: "alert-warning",
      notice: "alert-info",
      success: "alert-success"
    };
    return classes[type] || classes.success;
  }

  render() {
    const {
      message,
      removeMessage,
      index,
    } = this.props;

    const alertClassName = `alert ${ this.alertClass(message.status) } alert-dismissible fade show`;

    return(
      <div className={ alertClassName }>
        <button className='close' data-dismiss="alert" aria-label="Close"
                onClick={ () => removeMessage(index) }>
          &times;
        </button>
        { message.message[0] }
      </div>
    );
  }
}

export default withDiagram(Alert);
