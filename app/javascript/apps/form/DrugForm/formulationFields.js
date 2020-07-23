import * as React from "react";
import I18n from "i18n-js";
import FadeIn from "react-fade-in";
import { Form, Col } from "react-bootstrap";
import { INJECTION_ADMINISTRATION_ROUTES } from "../constants/constants";


export default class FormulationFields extends React.Component {
  constructor(props) {
    super(props);
    const { index, arrayHelpers: { form: { values } } } = this.props;
    const unity = ["suspension", "syrup", "solution", "powder_for_injection"].includes(values.formulations_attributes[index].medication_form)
      ? "ml"
      : "mg";

    this.state = {
      unity
    };
  }

  /**
   * Display label error
   * @params [String] input
   * @return [String] label
   */
  displayErrors(input) {
    const {
      index, arrayHelpers: { form: { errors } }
    } = this.props;

    return errors?.formulations_attributes !== undefined && errors?.formulations_attributes[index]?.[input];
  }

  /**
   * Test if input has an error
   * @params [String] input
   * @return [Boolean] error ?
   */
  isInvalid(input) {
    const {
      index, arrayHelpers: { form: { errors } }
    } = this.props;

    return errors?.formulations_attributes !== undefined && !!errors?.formulations_attributes[index]?.[input];
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

    let formulation = values.formulations_attributes[index];

    let uniqueDoseTrad = "";
    switch(formulation.medication_form) {
      case "capsule":
      case "tablet":
        uniqueDoseTrad = "unique_dose_solid";
        break;
      case "suppository":
        uniqueDoseTrad = "unique_dose_suppository";
        break;
      case "suspension":
      case "syrup":
      case "solution":
      case "powder_for_injection":
        uniqueDoseTrad = "unique_dose_liquid";
        break;
      default:
        uniqueDoseTrad = "unique_dose_general";
    }

    return (
      <FadeIn>
        <Form.Row>
          <Form.Group as={Col} controlId={`${index}-validationAdministrationRouteId`}>
            <Form.Label>
              {I18n.t(
                "activerecord.attributes.formulation.administration_route_id"
              )}
            </Form.Label>
            <Form.Control
              as="select"
              name={`formulations_attributes.${index}.administration_route_id`}
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

          <Form.Group as={Col} controlId={`${index}-validationDosesPerDay`}>
            <Form.Label>{I18n.t("activerecord.attributes.formulation.doses_per_day")}</Form.Label>
            <Form.Control
              type="number"
              name={`formulations_attributes.${index}.doses_per_day`}
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
          <Form.Group as={Col} controlId={`${index}-validationByAge`}>
            <Form.Label>{I18n.t("activerecord.attributes.formulation.by_age")}</Form.Label>
            <Form.Check
              checked={formulation.by_age}
              name={`formulations_attributes.${index}.by_age`}
              value={formulation.by_age}
              onChange={handleChange}
              isInvalid={this.isInvalid("by_age")}
            />
            <Form.Control.Feedback type="invalid">
              {this.displayErrors("by_age")}
            </Form.Control.Feedback>
          </Form.Group>

          {(formulation.medication_form === "capsule" && !formulation.by_age) ?
            <Form.Group as={Col}>
            </Form.Group>
            : null}

          {(formulation.medication_form === "tablet" && !formulation.by_age) ?
            <Form.Group as={Col} controlId={`${index}-validationBreakable`}>
              <Form.Label>{I18n.t("drugs.breakable.select")}</Form.Label>
              <Form.Control
                as="select"
                name={`formulations_attributes.${index}.breakable`}
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

          {(!["capsule", "tablet", "suspension", "syrup", "solution", "powder_for_injection"].includes(formulation.medication_form) || formulation.by_age) ?
            <Form.Group as={Col} controlId={`${index}-validationUniqueDose`}>
              <Form.Label>{I18n.t(`activerecord.attributes.formulation.${uniqueDoseTrad}`)}</Form.Label>
              <Form.Control
                type="number"
                name={`formulations_attributes.${index}.unique_dose`}
                value={formulation.unique_dose}
                onChange={handleChange}
                isInvalid={this.isInvalid("unique_dose")}
              />
              <Form.Control.Feedback type="invalid">
                {this.displayErrors("unique_dose")}
              </Form.Control.Feedback>
            </Form.Group>
            : null}

          {(["suspension", "syrup", "solution", "powder_for_injection"].includes(formulation.medication_form) && !formulation.by_age) ?
            <Form.Group as={Col} controlId={`${index}-validationLiquidConcentration`}>
              <Form.Label>{I18n.t("activerecord.attributes.formulation.liquid_concentration")}</Form.Label>
              <Form.Control
                type="number"
                name={`formulations_attributes.${index}.liquid_concentration`}
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


        {(["capsule", "tablet", "suspension", "syrup", "solution", "powder_for_injection"].includes(formulation.medication_form) && !formulation.by_age) ?
          <>
            <Form.Row>
              <Form.Group as={Col} controlId={`${index}-validationDoseForm`}>
                <Form.Label>{I18n.t("activerecord.attributes.formulation.dose_form", { unity })}</Form.Label>
                <Form.Control
                  type="number"
                  name={`formulations_attributes.${index}.dose_form`}
                  value={formulation.dose_form}
                  onChange={handleChange}
                  isInvalid={this.isInvalid("dose_form")}
                />
                <Form.Control.Feedback type="invalid">
                  {this.displayErrors("dose_form")}
                </Form.Control.Feedback>
              </Form.Group>

              <Form.Group as={Col} controlId={`${index}-validationMaximalDose`}>
                <Form.Label>{I18n.t("activerecord.attributes.formulation.maximal_dose")}</Form.Label>
                <Form.Control
                  type="number"
                  name={`formulations_attributes.${index}.maximal_dose`}
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
              <Form.Group as={Col} controlId={`${index}-validationMinimalDosePerKg`}>
                <Form.Label>{I18n.t("activerecord.attributes.formulation.minimal_dose_per_kg")}</Form.Label>
                <Form.Control
                  type="number"
                  name={`formulations_attributes.${index}.minimal_dose_per_kg`}
                  value={formulation.minimal_dose_per_kg}
                  onChange={handleChange}
                  isInvalid={this.isInvalid("minimal_dose_per_kg")}
                />
                <Form.Control.Feedback type="invalid">
                  {this.displayErrors("minimal_dose_per_kg")}
                </Form.Control.Feedback>
              </Form.Group>

              <Form.Group as={Col} controlId={`${index}-validationMaximalDosePerKg`}>
                <Form.Label>{I18n.t("activerecord.attributes.formulation.maximal_dose_per_kg")}</Form.Label>
                <Form.Control
                  type="number"
                  name={`formulations_attributes.${index}.maximal_dose_per_kg`}
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
        {INJECTION_ADMINISTRATION_ROUTES.includes(parseInt(formulation.administration_route_id)) ?
          <Form.Row>
            <Form.Group as={Col} controlId={`${index}-validationInjectionInstructions`}>
              <Form.Label>{I18n.t("activerecord.attributes.formulation.injection_instructions_translations")}</Form.Label>
              <Form.Control
                as="textarea"
                name={`formulations_attributes.${index}.injection_instructions_en`}
                value={formulation.injection_instructions_en}
                onChange={handleChange}
                isInvalid={this.isInvalid("injection_instructions_en")}
              />
              <Form.Control.Feedback type="invalid">
                {this.displayErrors("injection_instructions_en")}
              </Form.Control.Feedback>
            </Form.Group>
          </Form.Row>
        : null}

        <Form.Row>
          <Form.Group as={Col} controlId={`${index}-validationDescription`}>
            <Form.Label>{I18n.t("activerecord.attributes.formulation.description_translations")}</Form.Label>
            <Form.Control
              as="textarea"
              name={`formulations_attributes.${index}.description_en`}
              value={formulation.description_en}
              onChange={handleChange}
              isInvalid={this.isInvalid("description_en")}
            />
            <Form.Control.Feedback type="invalid">
              {this.displayErrors("description_en")}
            </Form.Control.Feedback>
          </Form.Group>
        </Form.Row>
      </FadeIn>
    );
  }
}
