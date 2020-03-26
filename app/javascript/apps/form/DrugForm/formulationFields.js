import * as React from "react";
import I18n from "i18n-js";
import FadeIn from "react-fade-in";
import { Form, Button, Accordion, Card } from "react-bootstrap";
import { Formik } from "formik";

import DisplayErrors from "../components/DisplayErrors";
import { drugSchema, questionSequencesSchema } from "../constants/schema";

export default class FormulationFields extends React.Component {


  // Push the answer object to the container
  handleFormChange = (e) => {
    // Get the name and value by additional param for Select (can't get it in the usual way...)
    const name = event.target.name !== undefined ? event.target.name : e.target.name;
    let value = null;
    if (name === "by_age") {
      value = event.target.checked;
    } else if (name === "administration_route_id") {
      value = e.target.value;
    } else {
      value = event.target.value;
    }

    const {
      index,
      formulations,
      setFormulation
    } = this.props;

    let formulation = formulations[index];
    formulation[name] = value;

    setFormulation(index, formulation);
    this.forceUpdate(); // Since there is no more state component does not rerender itself. I force it to make the form work. TODO better way to do so
  };


  render() {

    return (
      <h1>Coucou</h1>

    );
  }
}
