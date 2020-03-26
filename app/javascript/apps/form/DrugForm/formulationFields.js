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
    const {
      setActiveAccordion,
      index,
      removeFormulation,
      formulations,
      lists: {
        administration_routes,
        breakables
      }
    } = this.props;

    console.log(this.props);

    const {
      administration_route_id,
      minimal_dose_per_kg,
      maximal_dose_per_kg,
      maximal_dose,
      doses_per_day,
      dose_form,
      breakable,
      unique_dose,
      liquid_concentration,
      by_age,
      medication_form
    } = formulations[index];


    return (

      <Card>
        <Accordion.Toggle onClick={() => setActiveAccordion(index)} as={Card.Header} variant="link" eventKey={index}>
          {medication_form.charAt(0).toUpperCase() + medication_form.slice(1)}
        </Accordion.Toggle>
        <Accordion.Collapse eventKey={index}>
          <Card.Body>
            <FadeIn>
              <Formik
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
                      <Form.Group controlId="administration_route_id">
                        {/*<Form.Label>Administration route</Form.Label>*/}

                        {/*<Select*/}
                        {/*value={administrationRoutes.map((ar) => ar.options).flat()[administration_route_id - 1]}*/}
                        {/*options={administrationRoutes}*/}
                        {/*onChange={(val) => {*/}
                        {/*this.handleFormChange({target: {name: 'administration_route_id', value: val.value}})*/}
                        {/*}}*/}
                        {/*/>*/}
                        {/*<span style={administrationRouteErrorsStyle}>*/}
                        {/*{errors.administration_route}*/}
                        {/*</span>*/}
                      </Form.Group>

                      <Form.Group controlId="validationDosesPerDay">
                        <Form.Label>{I18n.t("activerecord.attributes.formulation.doses_per_day")}</Form.Label>
                        <Form.Control
                          type="number"
                          name="doses_per_day"
                          value={doses_per_day}
                          onChange={this.handleFormChange}
                          isInvalid={!!errors.doses_per_day}
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
                          value={by_age}
                          onChange={this.handleFormChange}
                          isInvalid={!!errors.by_age}
                        />
                        <Form.Control.Feedback type="invalid">
                          {errors.by_age}
                        </Form.Control.Feedback>
                      </Form.Group>

                      {medication_form === "capsule" ?
                        <Form.Group>
                        </Form.Group>
                        : null}

                      {medication_form === "tablet" ?
                        <Form.Group controlId="validationBreakable">
                          <Form.Label>{I18n.t("drugs.breakable.select")}</Form.Label>
                          <Form.Control as="select" name="breakable" onChange={this.handleFormChange} value={breakable}
                                        isInvalid={!!errors.breakable}>
                            <option value="">{I18n.t('select')}</option>
                            {breakables.map((breakable) => (
                              <option value={breakable[1]}>{breakable[0]}</option>
                            ))}
                          </Form.Control>
                          <Form.Control.Feedback type="invalid">
                            {errors.breakable}
                          </Form.Control.Feedback>
                        </Form.Group>
                        : null}

                      {!["capsule", "tablet", "suspension", "syrup"].includes(medication_form) ?
                        <Form.Group controlId="validationUniqueDose">
                          <Form.Label>{I18n.t('activerecord.attributes.formulation.unique_dose')}</Form.Label>
                          <Form.Control
                            type="number"
                            name="unique_dose"
                            value={unique_dose}
                            onChange={this.handleFormChange}
                            isInvalid={!!errors.unique_dose}
                          />
                          <Form.Control.Feedback type="invalid">
                            {errors.unique_dose}
                          </Form.Control.Feedback>
                        </Form.Group>
                        : null}

                      {["suspension", "syrup"].includes(medication_form) ?
                        <Form.Group controlId="validationLiquidConcentration">
                          <Form.Label>{I18n.t('activerecord.attributes.formulation.liquid_concentration')}</Form.Label>
                          <Form.Control
                            type="number"
                            name="liquid_concentration"
                            value={liquid_concentration}
                            onChange={this.handleFormChange}
                            isInvalid={!!errors.liquid_concentration}
                          />
                          <Form.Control.Feedback type="invalid">
                            {errors.liquid_concentration}
                          </Form.Control.Feedback>
                        </Form.Group>
                        : null}
                    </Form.Row>

                    {["capsule", "tablet", "suspension", "syrup"].includes(medication_form) ?
                      <>
                        <Form.Row>
                          <Form.Group controlId="validationDoseForm">
                            <Form.Label>{I18n.t('activerecord.attributes.formulation.dose_form', { unity: 'mg' })}</Form.Label>
                            <Form.Control
                              type="number"
                              name="dose_form"
                              value={dose_form}
                              onChange={this.handleFormChange}
                              isInvalid={!!errors.dose_form}
                            />
                            <Form.Control.Feedback type="invalid">
                              {errors.dose_form}
                            </Form.Control.Feedback>
                          </Form.Group>

                          <Form.Group controlId="validationMaximalDose">
                            <Form.Label>{I18n.t('activerecord.attributes.formulation.maximal_dose')}</Form.Label>
                            <Form.Control
                              type="number"
                              name="maximal_dose"
                              value={maximal_dose}
                              onChange={this.handleFormChange}
                              isInvalid={!!errors.maximal_dose}
                            />
                            <Form.Control.Feedback type="invalid">
                              {errors.maximal_dose}
                            </Form.Control.Feedback>
                          </Form.Group>
                        </Form.Row>

                        <Form.Row>
                          <Form.Group controlId="validationMinimalDosePerKg">
                            <Form.Label>{I18n.t('activerecord.attributes.formulation.minimal_dose_per_kg')}</Form.Label>
                            <Form.Control
                              type="number"
                              name="minimal_dose_per_kg"
                              value={minimal_dose_per_kg}
                              onChange={this.handleFormChange}
                              isInvalid={!!errors.minimal_dose_per_kg}
                            />
                            <Form.Control.Feedback type="invalid">
                              {errors.minimal_dose_per_kg}
                            </Form.Control.Feedback>
                          </Form.Group>

                          <Form.Group controlId="validationMaximalDosePerKg">
                            <Form.Label>{I18n.t('activerecord.attributes.formulation.maximal_dose_per_kg')}</Form.Label>
                            <Form.Control
                              type="number"
                              name="maximal_dose_per_kg"
                              value={maximal_dose_per_kg}
                              onChange={this.handleFormChange}
                              isInvalid={!!errors.maximal_dose_per_kg}
                            />
                            <Form.Control.Feedback type="invalid">
                              {errors.maximal_dose_per_kg}
                            </Form.Control.Feedback>
                          </Form.Group>
                        </Form.Row>
                      </>
                    : null}

                    <Form.Row>
                      <Form.Group>
                        <Button variant="danger" onClick={() => removeFormulation(index)}>
                          Remove
                        </Button>
                      </Form.Group>
                    </Form.Row>
                  </Form>
                )}
              </Formik>
            </FadeIn>
          </Card.Body>
        </Accordion.Collapse>
      </Card>
    );
  }
}
