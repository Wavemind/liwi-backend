import * as React from "react";
import I18n from "i18n-js";
import FadeIn from "react-fade-in";
import { Form } from "react-bootstrap";
import { Formik } from "formik";

import DisplayErrors from "../components/DisplayErrors";
import { formulationSchema } from "../constants/schema";

export default class FormulationFields extends React.Component {

  constructor(props) {
    super(props);
    const { formulation } = this.props;
    const unity = ["suspension", "syrup"].includes(formulation.medication_form) ? "ml" : "mg";

    this.state = {
      unity
    };
  }

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
    const { unity } = this.state;
    const {
      formulation,
      breakables,
      administrationRoutes,
      index
    } = this.props;

    return (
      <FadeIn>
        <Formik
          validationSchema={formulationSchema}
          initialValues={formulation}
          onSubmit={(values, actions) => this.handleOnSubmit(values, actions)}
        >
          {({
              handleSubmit,
              handleChange,
              isSubmitting,
              values,
              touched,
              errors,
              status
            }) => (
            <Form noValidate onSubmit={handleSubmit}>
              <Form.Row>
                <Form.Group controlId="validationAdministrationRouteId">
                  <Form.Label>Administration route</Form.Label>
                  <Form.Control
                    as="select"
                    name="administration_route_id"
                    value={values.administration_route_id}
                    onChange={handleChange}
                    isInvalid={touched.administration_route_id && !!errors.administration_route_id}
                  >
                    <option value="">{I18n.t("select")}</option>
                    {administrationRoutes.map(administrationRoute => (
                      <>
                        <option key={administrationRoute.value} value={administrationRoute.value} disabled className="font-weight-bold">{administrationRoute.label}</option>
                        {administrationRoute.options.map(option => (
                          <option key={option.value} value={option.value}>{option.label}</option>
                        ))}
                      </>
                    ))}
                  </Form.Control>
                  <Form.Control.Feedback type="invalid">
                    {errors.administration_route_id}
                  </Form.Control.Feedback>
                </Form.Group>

                <Form.Group controlId="validationDosesPerDay">
                  <Form.Label>{I18n.t("activerecord.attributes.formulation.doses_per_day")}</Form.Label>
                  <Form.Control
                    type="number"
                    name="doses_per_day"
                    value={values.doses_per_day}
                    onChange={handleChange}
                    isInvalid={touched.doses_per_day && !!errors.doses_per_day}
                  />
                  <Form.Control.Feedback type="invalid">
                    {errors.doses_per_day}
                  </Form.Control.Feedback>
                </Form.Group>
              </Form.Row>

              <Form.Row>
                <Form.Group controlId="validationByAge">
                  <Form.Label>{I18n.t("activerecord.attributes.formulation.by_age")}</Form.Label>
                  <Form.Check
                    type="checkbox"
                    name="by_age"
                    value={values.by_age}
                    onChange={handleChange}
                    isInvalid={touched.by_age && !!errors.by_age}
                  />
                  <Form.Control.Feedback type="invalid">
                    {errors.by_age}
                  </Form.Control.Feedback>
                </Form.Group>

                {(values.medication_form === "capsule" && !values.by_age) ?
                  <Form.Group>
                  </Form.Group>
                : null}

                {(values.medication_form === "tablet" && !values.by_age) ?
                  <Form.Group controlId="validationBreakable">
                    <Form.Label>{I18n.t("drugs.breakable.select")}</Form.Label>
                    <Form.Control
                      as="select"
                      name="breakable"
                      onChange={handleChange}
                      value={values.breakable}
                      isInvalid={touched.breakable && !!errors.breakable}>
                      <option value="">{I18n.t("select")}</option>
                      {breakables.map(breakable => (
                        <option value={breakable[1]}>{breakable[0]}</option>
                      ))}
                    </Form.Control>
                    <Form.Control.Feedback type="invalid">
                      {errors.breakable}
                    </Form.Control.Feedback>
                  </Form.Group>
                  : null}

                {(!["capsule", "tablet", "suspension", "syrup"].includes(values.medication_form) || values.by_age) ?
                  <Form.Group controlId="validationUniqueDose">
                    <Form.Label>{I18n.t("activerecord.attributes.formulation.unique_dose")}</Form.Label>
                    <Form.Control
                      type="number"
                      name="unique_dose"
                      value={values.unique_dose}
                      onChange={handleChange}
                      isInvalid={touched.unique_dose && !!errors.unique_dose}
                    />
                    <Form.Control.Feedback type="invalid">
                      {errors.unique_dose}
                    </Form.Control.Feedback>
                  </Form.Group>
                  : null}

                {(["suspension", "syrup"].includes(values.medication_form) && !values.by_age) ?
                  <Form.Group controlId="validationLiquidConcentration">
                    <Form.Label>{I18n.t("activerecord.attributes.formulation.liquid_concentration")}</Form.Label>
                    <Form.Control
                      type="number"
                      name="liquid_concentration"
                      value={values.liquid_concentration}
                      onChange={handleChange}
                      isInvalid={touched.liquid_concentration && !!errors.liquid_concentration}
                    />
                    <Form.Control.Feedback type="invalid">
                      {errors.liquid_concentration}
                    </Form.Control.Feedback>
                  </Form.Group>
                  : null}
              </Form.Row>

              {(["capsule", "tablet", "suspension", "syrup"].includes(values.medication_form) && !values.by_age) ?
                <>
                  <Form.Row>
                    <Form.Group controlId="validationDoseForm">
                      <Form.Label>{I18n.t("activerecord.attributes.formulation.dose_form", { unity })}</Form.Label>
                      <Form.Control
                        type="number"
                        name="dose_form"
                        value={values.dose_form}
                        onChange={handleChange}
                        isInvalid={touched.dose_form && !!errors.dose_form}
                      />
                      <Form.Control.Feedback type="invalid">
                        {errors.dose_form}
                      </Form.Control.Feedback>
                    </Form.Group>

                    <Form.Group controlId="validationMaximalDose">
                      <Form.Label>{I18n.t("activerecord.attributes.formulation.maximal_dose")}</Form.Label>
                      <Form.Control
                        type="number"
                        name="maximal_dose"
                        value={values.maximal_dose}
                        onChange={handleChange}
                        isInvalid={touched.maximal_dose && !!errors.maximal_dose}
                      />
                      <Form.Control.Feedback type="invalid">
                        {errors.maximal_dose}
                      </Form.Control.Feedback>
                    </Form.Group>
                  </Form.Row>

                  <Form.Row>
                    <Form.Group controlId="validationMinimalDosePerKg">
                      <Form.Label>{I18n.t("activerecord.attributes.formulation.minimal_dose_per_kg")}</Form.Label>
                      <Form.Control
                        type="number"
                        name="minimal_dose_per_kg"
                        value={values.minimal_dose_per_kg}
                        onChange={handleChange}
                        isInvalid={touched.minimal_dose_per_kg && !!errors.minimal_dose_per_kg}
                      />
                      <Form.Control.Feedback type="invalid">
                        {errors.minimal_dose_per_kg}
                      </Form.Control.Feedback>
                    </Form.Group>

                    <Form.Group controlId="validationMaximalDosePerKg">
                      <Form.Label>{I18n.t("activerecord.attributes.formulation.maximal_dose_per_kg")}</Form.Label>
                      <Form.Control
                        type="number"
                        name="maximal_dose_per_kg"
                        value={values.maximal_dose_per_kg}
                        onChange={handleChange}
                        isInvalid={touched.maximal_dose_per_kg && !!errors.maximal_dose_per_kg}
                      />
                      <Form.Control.Feedback type="invalid">
                        {errors.maximal_dose_per_kg}
                      </Form.Control.Feedback>
                    </Form.Group>
                  </Form.Row>
                </>
                : null}
            </Form>
          )}
        </Formik>
      </FadeIn>
    );
  }
}
