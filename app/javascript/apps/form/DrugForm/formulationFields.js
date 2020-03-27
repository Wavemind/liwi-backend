import * as React from "react";
import I18n from "i18n-js";
import FadeIn from "react-fade-in";
import { Form } from "react-bootstrap";
import { ErrorMessage, Formik } from "formik";

import DisplayErrors from "../components/DisplayErrors";
import { formulationSchema } from "../constants/schema";

export default class FormulationFields extends React.Component {
  constructor(props) {
    super(props);
    const { values } = this.props;
    const unity = ["suspension", "syrup"].includes(values.medication_form)
      ? "ml"
      : "mg";

    this.state = {
      unity
    };
  }

  // Push the answer object to the container
  // handleFormChange = (e) => {
  //   // Get the name and value by additional param for Select (can't get it in the usual way...)
  //   const name = event.target.name !== undefined ? event.target.name : e.target.name;
  //   let value = null;
  //   if (name === "by_age") {
  //     value = event.target.checked;
  //   } else if (name === "administration_route_id") {
  //     value = e.target.value;
  //   } else {
  //     value = event.target.value;
  //   }
  //
  //   const {
  //     index,
  //     formulations,
  //     setFormulation
  //   } = this.props;
  //
  //   let formulation = formulations[index];
  //   formulation[name] = value;
  //
  //   setFormulation(index, formulation);
  //   this.forceUpdate(); // Since there is no more state component does not rerender itself. I force it to make the form work. TODO better way to do so
  // };

  render() {
    const { unity } = this.state;
    const {
      breakables,
      administrationRoutes,
      handleChange,
      touched,
      errors,
      values,
      index,
      arrayHelpers: { form }
    } = this.props;

    console.log(form.values);
    console.log(form.errors);

    return (
      <FadeIn>
        <Form.Row>
          <Form.Group controlId={`${index}-validationAdministrationRouteId`}>
            <Form.Label>
              {I18n.t(
                "activerecord.attributes.formulation.administration_route_id"
              )}
            </Form.Label>
            <Form.Control
              as="select"
              name={`test.${index}.administration_route_id`}
              value={values.test[index].administration_route_id}
              onChange={form.handleChange}
              isInvalid={errors?.test !== undefined && !!errors?.test[index]?.administration_route_id}
            >
              <option value="">{I18n.t("select")}</option>
              {administrationRoutes.map(administrationRoute => (
                <>
                  <option
                    key={administrationRoute.value}
                    value={administrationRoute.value}
                    disabled
                    className="font-weight-bold"
                  >
                    {administrationRoute.label}
                  </option>
                  {administrationRoute.options.map(option => (
                    <option key={option.value} value={option.value}>
                      {option.label}
                    </option>
                  ))}
                </>
              ))}
            </Form.Control>
            <Form.Control.Feedback type="invalid">
              {errors?.test !== undefined && errors?.test[index]?.administration_route_id}}
            </Form.Control.Feedback>
          </Form.Group>
        </Form.Row>
      </FadeIn>
    );
  }
}
