import React from "react";
import { withDiagram } from "../../context/Diagram.context";

/**
 * @author Quentin Girard
 * Display flash message comming from props with bootstrap 4 design
 */
class Alert extends React.Component {

  /**
   * Map alert type and return it css class
   * @method alertClass
   * @param type - type of alert
   * @return css class
   */
  alertClass(type) {
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
      alert,
      removeMessage,
      index
    } = this.props;

    const alertClassName = `alert ${this.alertClass(alert.status)} alert-dismissible fade show`;

    return (
      <div className={alertClassName}>
        <button className='close' data-dismiss="alert" aria-label="Close"
                onClick={() => removeMessage(index)}>
          &times;
        </button>
        <ul>
          {alert.messages.map((message, key) =>
            <li key={key}><div dangerouslySetInnerHTML={{__html: message}} /></li>
          )}
        </ul>

      </div>
    );
  }
}

export default withDiagram(Alert);
