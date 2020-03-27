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
    const unity = ["suspension", "syrup"].includes(values.medication_form) ? "ml" : "mg";

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
      arrayHelpers,
    } = this.props;

    console.log(values);
    console.log(errors);

    return (
      <FadeIn>
        <Form.Row>
          <Form.Group controlId={`${index}-validationAdministrationRouteId`}>
            <Form.Label>{I18n.t("activerecord.attributes.formulation.administration_route_id")}</Form.Label>
            <Form.Control
              as="select"
              name={`${index}.administration_route_id`}
              value={values[index].administration_route_id}
              onChange={handleChange}
              isInvalid={!!errors?.administration_route_id}
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
                    <option key={option.value} value={option.value}>{option.label}</option>
                  ))}
                </>
              ))}
            </Form.Control>
            <Form.Control.Feedback type="invalid">
              <ErrorMessage name={`${index}.administration_route_id`} />
              {/*{errors?.administration_route_id}*/}
            </Form.Control.Feedback>
          </Form.Group>

          <Form.Group controlId={`${index}-validationDosesPerDay`}>
            <Form.Label>{I18n.t("activerecord.attributes.formulation.doses_per_day")}</Form.Label>
            <Form.Control
              type="number"
              name={`${index}.doses_per_day`}
              value={values[index].doses_per_day}
              onChange={handleChange}
              isInvalid={touched?.doses_per_day && !!errors?.doses_per_day}
            />
            <Form.Control.Feedback type="invalid">
              {errors?.doses_per_day}
            </Form.Control.Feedback>
          </Form.Group>
        </Form.Row>

        <Form.Row>
          <Form.Group controlId={`${index}-validationByAge`}>
            <Form.Label>{I18n.t("activerecord.attributes.formulation.by_age")}</Form.Label>
            <Form.Check
              type="checkbox"
              name={`${index}.by_age`}
              value={values[index].by_age}
              onChange={handleChange}
              isInvalid={touched?.by_age && !!errors?.by_age}
            />
            <Form.Control.Feedback type="invalid">
              {errors?.by_age}
            </Form.Control.Feedback>
          </Form.Group>

          {(values[index].medication_form === "capsule" && !values[index].by_age) ?
            <Form.Group>
            </Form.Group>
            : null}

          {(values[index].medication_form === "tablet" && !values[index].by_age) ?
            <Form.Group controlId={`${index}-validationBreakable`}>
              <Form.Label>{I18n.t("drugs.breakable.select")}</Form.Label>
              <Form.Control
                as="select"
                name={`${index}.breakable`}
                onChange={handleChange}
                value={values[index].breakable}
                isInvalid={touched?.breakable && !!errors?.breakable}>
                <option value="">{I18n.t("select")}</option>
                {breakables.map(breakable => (
                  <option value={breakable[1]}>{breakable[0]}</option>
                ))}
              </Form.Control>
              <Form.Control.Feedback type="invalid">
                {errors?.breakable}
              </Form.Control.Feedback>
            </Form.Group>
            : null}

          {(!["capsule", "tablet", "suspension", "syrup"].includes(values[index].medication_form) || values[index].by_age) ?
            <Form.Group controlId={`${index}-validationUniqueDose`}>
              <Form.Label>{I18n.t("activerecord.attributes.formulation.unique_dose")}</Form.Label>
              <Form.Control
                type="number"
                name={`${index}.unique_dose`}
                value={values[index].unique_dose}
                onChange={handleChange}
                isInvalid={touched?.unique_dose && !!errors?.unique_dose}
              />
              <Form.Control.Feedback type="invalid">
                {errors?.unique_dose}
              </Form.Control.Feedback>
            </Form.Group>
            : null}

          {(["suspension", "syrup"].includes(values[index].medication_form) && !values[index].by_age) ?
            <Form.Group controlId={`${index}-validationLiquidConcentration`}>
              <Form.Label>{I18n.t("activerecord.attributes.formulation.liquid_concentration")}</Form.Label>
              <Form.Control
                type="number"
                name={`${index}.liquid_concentration`}
                value={values[index].liquid_concentration}
                onChange={handleChange}
                isInvalid={touched?.liquid_concentration && !!errors?.liquid_concentration}
              />
              <Form.Control.Feedback type="invalid">
                {errors?.liquid_concentration}
              </Form.Control.Feedback>
            </Form.Group>
            : null}
        </Form.Row>

        {(["capsule", "tablet", "suspension", "syrup"].includes(values[index].medication_form) && !values[index].by_age) ?
          <>
            <Form.Row>
              <Form.Group controlId={`${index}-validationDoseForm`}>
                <Form.Label>{I18n.t("activerecord.attributes.formulation.dose_form", { unity })}</Form.Label>
                <Form.Control
                  type="number"
                  name={`${index}.dose_form`}
                  value={values[index].dose_form}
                  onChange={handleChange}
                  isInvalid={touched?.dose_form && !!errors?.dose_form}
                />
                <Form.Control.Feedback type="invalid">
                  {errors?.dose_form}
                </Form.Control.Feedback>
              </Form.Group>

              <Form.Group controlId={`${index}-validationMaximalDose`}>
                <Form.Label>{I18n.t("activerecord.attributes.formulation.maximal_dose")}</Form.Label>
                <Form.Control
                  type="number"
                  name={`${index}.maximal_dose`}
                  value={values[index].maximal_dose}
                  onChange={handleChange}
                  isInvalid={touched?.maximal_dose && !!errors?.maximal_dose}
                />
                <Form.Control.Feedback type="invalid">
                  {errors?.maximal_dose}
                </Form.Control.Feedback>
              </Form.Group>
            </Form.Row>

            <Form.Row>
              <Form.Group controlId={`${index}-validationMinimalDosePerKg`}>
                <Form.Label>{I18n.t("activerecord.attributes.formulation.minimal_dose_per_kg")}</Form.Label>
                <Form.Control
                  type="number"
                  name={`${index}.minimal_dose_per_kg`}
                  value={values[index].minimal_dose_per_kg}
                  onChange={handleChange}
                  isInvalid={touched?.minimal_dose_per_kg && !!errors?.minimal_dose_per_kg}
                />
                <Form.Control.Feedback type="invalid">
                  {errors?.minimal_dose_per_kg}
                </Form.Control.Feedback>
              </Form.Group>

              <Form.Group controlId={`${index}-validationMaximalDosePerKg`}>
                <Form.Label>{I18n.t("activerecord.attributes.formulation.maximal_dose_per_kg")}</Form.Label>
                <Form.Control
                  type="number"
                  name={`${index}.maximal_dose_per_kg`}
                  value={values[index].maximal_dose_per_kg}
                  onChange={handleChange}
                  isInvalid={touched?.maximal_dose_per_kg && !!errors?.maximal_dose_per_kg}
                />
                <Form.Control.Feedback type="invalid">
                  {errors?.maximal_dose_per_kg}
                </Form.Control.Feedback>
              </Form.Group>
            </Form.Row>
          </>
          : null}
      </FadeIn>
    );
  }
}
