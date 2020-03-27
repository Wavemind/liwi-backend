import * as React from "react";
import I18n from "i18n-js";
import FadeIn from "react-fade-in";
import { Form } from "react-bootstrap";

import DisplayErrors from "../components/DisplayErrors";

export default class FormulationFields extends React.Component {
  constructor(props) {
    super(props);
    const { arrayHelpers: { form: { values } } } = this.props;
    const unity = ["suspension", "syrup"].includes(values.medication_form)
      ? "ml"
      : "mg";

    this.state = {
      unity
    };
  }

  // Push the formulation object to the container
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

  displayErrors(input) {
    const {
      index, arrayHelpers: { form: { errors } }
    } = this.props;

    return errors?.formulations !== undefined && errors?.formulations[index]?.[input];
  }

  isInvalid(input) {
    const {
      index, arrayHelpers: { form: { errors } }
    } = this.props;

    return errors?.formulations !== undefined && !!errors?.formulations[index]?.[input];
  }

  render() {
    const { unity } = this.state;
    const {
      breakables,
      administrationRoutes,
      arrayHelpers: {
        form: {
          handleChange,
          values,
        }
      },
      index
    } = this.props;

    let formulation = values.formulations[index];

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
              name={`formulations.${index}.administration_route_id`}
              value={formulation.administration_route_id}
              onChange={handleChange}
              isInvalid={this.isInvalid("administration_route_id")}
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
              {this.displayErrors("administration_route_id")}
            </Form.Control.Feedback>
          </Form.Group>

          <Form.Group controlId={`${index}-validationDosesPerDay`}>
            <Form.Label>{I18n.t("activerecord.attributes.formulation.doses_per_day")}</Form.Label>
            <Form.Control
              type="number"
              name={`formulations.${index}.doses_per_day`}
              value={formulation.doses_per_day}
              onChange={handleChange}
              isInvalid={this.isInvalid("doses_per_day")}
            />
            <Form.Control.Feedback type="invalid">
              {this.displayErrors("doses_per_day")}
            </Form.Control.Feedback>
          </Form.Group>
        </Form.Row>

        <Form.Row>
          <Form.Group controlId={`${index}-validationByAge`}>
            <Form.Label>{I18n.t("activerecord.attributes.formulation.by_age")}</Form.Label>
            <Form.Check
              type="checkbox"
              name={`formulations.${index}.by_age`}
              value={formulation.by_age}
              onChange={handleChange}
              isInvalid={this.isInvalid("by_age")}
            />
            <Form.Control.Feedback type="invalid">
              {this.displayErrors("by_age")}
            </Form.Control.Feedback>
          </Form.Group>

          {(formulation.medication_form === "capsule" && !formulation.by_age) ?
            <Form.Group>
            </Form.Group>
            : null}

          {(formulation.medication_form === "tablet" && !formulation.by_age) ?
            <Form.Group controlId={`${index}-validationBreakable`}>
              <Form.Label>{I18n.t("drugs.breakable.select")}</Form.Label>
              <Form.Control
                as="select"
                name={`formulations.${index}.breakable`}
                onChange={handleChange}
                value={formulation.breakable}
                isInvalid={this.isInvalid("breakable")}
              >
                <option value="">{I18n.t("select")}</option>
                {breakables.map(breakable => (
                  <option value={breakable[1]}>{breakable[0]}</option>
                ))}
              </Form.Control>
              <Form.Control.Feedback type="invalid">
                {this.displayErrors("breakable")}
              </Form.Control.Feedback>
            </Form.Group>
            : null}

          {(!["capsule", "tablet", "suspension", "syrup"].includes(formulation.medication_form) || formulation.by_age) ?
            <Form.Group controlId={`${index}-validationUniqueDose`}>
              <Form.Label>{I18n.t("activerecord.attributes.formulation.unique_dose")}</Form.Label>
              <Form.Control
                type="number"
                name={`formulations.${index}.unique_dose`}
                value={formulation.unique_dose}
                onChange={handleChange}
                isInvalid={this.isInvalid("unique_dose")}
              />
              <Form.Control.Feedback type="invalid">
                {this.displayErrors("unique_dose")}
              </Form.Control.Feedback>
            </Form.Group>
            : null}

          {(["suspension", "syrup"].includes(formulation.medication_form) && !formulation.by_age) ?
            <Form.Group controlId={`${index}-validationLiquidConcentration`}>
              <Form.Label>{I18n.t("activerecord.attributes.formulation.liquid_concentration")}</Form.Label>
              <Form.Control
                type="number"
                name={`formulations.${index}.liquid_concentration`}
                value={formulation.liquid_concentration}
                onChange={handleChange}
                isInvalid={this.isInvalid("liquid_concentration")}
              />
              <Form.Control.Feedback type="invalid">
                {this.displayErrors("liquid_concentration")}
              </Form.Control.Feedback>
            </Form.Group>
            : null}
        </Form.Row>

        {(["capsule", "tablet", "suspension", "syrup"].includes(formulation.medication_form) && !formulation.by_age) ?
          <>
            <Form.Row>
              <Form.Group controlId={`${index}-validationDoseForm`}>
                <Form.Label>{I18n.t("activerecord.attributes.formulation.dose_form", { unity })}</Form.Label>
                <Form.Control
                  type="number"
                  name={`formulations.${index}.dose_form`}
                  value={formulation.dose_form}
                  onChange={handleChange}
                  isInvalid={this.isInvalid("dose_form")}
                />
                <Form.Control.Feedback type="invalid">
                  {this.displayErrors("dose_form")}
                </Form.Control.Feedback>
              </Form.Group>

              <Form.Group controlId={`${index}-validationMaximalDose`}>
                <Form.Label>{I18n.t("activerecord.attributes.formulation.maximal_dose")}</Form.Label>
                <Form.Control
                  type="number"
                  name={`formulations.${index}.maximal_dose`}
                  value={formulation.maximal_dose}
                  onChange={handleChange}
                  isInvalid={this.isInvalid("maximal_dose")}
                />
                <Form.Control.Feedback type="invalid">
                  {this.displayErrors("maximal_dose")}
                </Form.Control.Feedback>
              </Form.Group>
            </Form.Row>

            <Form.Row>
              <Form.Group controlId={`${index}-validationMinimalDosePerKg`}>
                <Form.Label>{I18n.t("activerecord.attributes.formulation.minimal_dose_per_kg")}</Form.Label>
                <Form.Control
                  type="number"
                  name={`formulations.${index}.minimal_dose_per_kg`}
                  value={formulation.minimal_dose_per_kg}
                  onChange={handleChange}
                  isInvalid={this.isInvalid("minimal_dose_per_kg")}
                />
                <Form.Control.Feedback type="invalid">
                  {this.displayErrors("minimal_dose_per_kg")}
                </Form.Control.Feedback>
              </Form.Group>

              <Form.Group controlId={`${index}-validationMaximalDosePerKg`}>
                <Form.Label>{I18n.t("activerecord.attributes.formulation.maximal_dose_per_kg")}</Form.Label>
                <Form.Control
                  type="number"
                  name={`formulations.${index}.maximal_dose_per_kg`}
                  value={formulation.maximal_dose_per_kg}
                  onChange={handleChange}
                  isInvalid={this.isInvalid("maximal_dose_per_kg")}
                />
                <Form.Control.Feedback type="invalid">
                  {this.displayErrors("maximal_dose_per_kg")}
                </Form.Control.Feedback>
              </Form.Group>
            </Form.Row>
          </>
          : null}
      </FadeIn>
    );
  }
}
