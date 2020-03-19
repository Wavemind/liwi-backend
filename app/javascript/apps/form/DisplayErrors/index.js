import * as React from "react";
import { Alert } from "react-bootstrap";

export default class DisplayErrors extends React.Component {

  render() {
    const { errors } = this.props;

    return (
      <Alert variant="danger">
        <ul>
          {Object.keys(errors).map(index => (<li>{errors[index]}</li>))}
        </ul>
      </Alert>
    );
  }
}
