import * as React from "react";
import I18n from "i18n-js";
import FadeIn from "react-fade-in";
import {Form, Button, Accordion, Card} from "react-bootstrap";
import {Formik} from "formik";

import DisplayErrors from "../DisplayErrors";
import {drugSchema, questionSequencesSchema} from "../schema";

export default class FormulationFields extends React.Component {


  // Push the answer object to the container
  handleFormChange = (e) => {
    // Get the name and value by additional param for Select (can't get it in the usual way...)
    const name = event.target.name !== undefined ? event.target.name : e.target.name;
    let value = null;
    if (name === 'by_age') {
      value = event.target.checked
    } else if (name === 'administration_route_id') {
      value = e.target.value
    } else {
      value = event.target.value
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
      medicationForm,
      removeFormulation,
      formulations
    } = this.props;

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
      by_age
    } = formulations[index];

    return (

      <Card>
        <Accordion.Toggle onClick={() => setActiveAccordion(index)} as={Card.Header} variant="link" eventKey={index}>
          {medicationForm.charAt(0).toUpperCase() + medicationForm.slice(1)}
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
                      <Form.Group as={Col} controlId="administration_route_id">
                        <Form.Label>Administration route</Form.Label>

                        <Select
                          value={administrationRoutes.map((ar) => ar.options).flat()[administration_route_id - 1]}
                          options={administrationRoutes}
                          onChange={(val) => {
                            this.handleFormChange({target: {name: 'administration_route_id', value: val.value}})
                          }}
                        />
                        <span style={administrationRouteErrorsStyle}>
                          {errors.administration_route}
                        </span>
                      </Form.Group>

                      <Form.Group controlId="validationDosesPerDay">
                        <Form.Label>Doses per day</Form.Label>
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
                        <Form.Control
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

                      <Form.Group style={capsFields}>

                      </Form.Group>

                      <Form.Group as={Col} controlId="breakable" style={tabletFields}>
                        <Form.Label>Breakable</Form.Label>
                        <Form.Control as="select" name="breakable" onChange={this.handleFormChange} value={breakable}
                                      isInvalid={!!errors.breakable}>
                          <option value="">Is the tablet breakable ?</option>
                          {breakableOptions.map((breakable) => (
                            <option value={breakable[1]}>{breakable[0]}</option>
                          ))}
                        </Form.Control>

                        <Form.Control.Feedback type="invalid">
                          {errors.breakable}
                        </Form.Control.Feedback>
                      </Form.Group>


                      <Form.Group controlId="validationBreakable">
                        <Form.Label>{I18n.t("activerecord.attributes.formulation.breakable")}</Form.Label>
                        <Form.Control as="select" name="breakable" onChange={this.handleFormChange} value={breakable}
                                      isInvalid={!!errors.breakable}>
                          <option value="">Is the tablet breakable ?</option>
                          {breakableOptions.map((breakable) => (
                            <option value={breakable[1]}>{breakable[0]}</option>
                          ))}
                        </Form.Control>
                        <Form.Control.Feedback type="invalid">
                          {errors.breakable}
                        </Form.Control.Feedback>
                      </Form.Group>




                      <Form.Group as={Col} style={simpleFields}>
                        <Form.Label>Number of elements per dose</Form.Label>
                        <InputGroup>
                          <Form.Control
                            type="number"
                            aria-describedby="inputGroupPrepend"
                            name="unique_dose"
                            value={unique_dose}
                            onChange={this.handleFormChange}
                            isInvalid={!!errors.unique_dose}
                          />
                          <Form.Control.Feedback type="invalid">
                            {errors.unique_dose}
                          </Form.Control.Feedback>
                        </InputGroup>
                      </Form.Group>

                      <Form.Group as={Col} style={liquidFields}>
                        <Form.Label>Concentration (mg in dose)</Form.Label>
                        <InputGroup>
                          <Form.Control
                            type="number"
                            aria-describedby="inputGroupPrepend"
                            name="liquid_concentration"
                            value={liquid_concentration}
                            onChange={this.handleFormChange}
                            isInvalid={!!errors.liquid_concentration}
                          />
                          <Form.Control.Feedback type="invalid">
                            {errors.liquid_concentration}
                          </Form.Control.Feedback>
                        </InputGroup>
                      </Form.Group>
                    </Form.Row>

                    <Form.Row style={pillOrLiquidFields}>
                      <Form.Group as={Col}>
                        <Form.Label>Dose form ({unity})</Form.Label>
                        <InputGroup>
                          <Form.Control
                            type="number"
                            aria-describedby="inputGroupPrepend"
                            name="dose_form"
                            value={dose_form}
                            onChange={this.handleFormChange}
                            isInvalid={!!errors.dose_form}
                          />
                          <Form.Control.Feedback type="invalid">
                            {errors.dose_form}
                          </Form.Control.Feedback>
                        </InputGroup>
                      </Form.Group>

                      <Form.Group as={Col}>
                        <Form.Label>Maximal dose per day (mg)</Form.Label>
                        <InputGroup>
                          <Form.Control
                            type="number"
                            aria-describedby="inputGroupPrepend"
                            name="maximal_dose"
                            value={maximal_dose}
                            onChange={this.handleFormChange}
                            isInvalid={!!errors.maximal_dose}
                          />
                          <Form.Control.Feedback type="invalid">
                            {errors.maximal_dose}
                          </Form.Control.Feedback>
                        </InputGroup>
                      </Form.Group>
                    </Form.Row>

                    <Form.Row style={pillOrLiquidFields}>
                      <Form.Group as={Col}>
                        <Form.Label>Minimal dose per kg (mg)</Form.Label>
                        <InputGroup>
                          <Form.Control
                            type="number"
                            aria-describedby="inputGroupPrepend"
                            name="minimal_dose_per_kg"
                            value={minimal_dose_per_kg}
                            onChange={this.handleFormChange}
                            isInvalid={!!errors.minimal_dose_per_kg}
                          />
                          <Form.Control.Feedback type="invalid">
                            {errors.minimal_dose_per_kg}
                          </Form.Control.Feedback>
                        </InputGroup>
                      </Form.Group>

                      <Form.Group as={Col}>
                        <Form.Label>Maximal dose per kg (mg)</Form.Label>
                        <InputGroup>
                          <Form.Control
                            type="number"
                            aria-describedby="inputGroupPrepend"
                            name="maximal_dose_per_kg"
                            value={maximal_dose_per_kg}
                            onChange={this.handleFormChange}
                            isInvalid={!!errors.maximal_dose_per_kg}
                          />
                          <Form.Control.Feedback type="invalid">
                            {errors.maximal_dose_per_kg}
                          </Form.Control.Feedback>
                        </InputGroup>
                      </Form.Group>
                    </Form.Row>

                    <Form.Row>
                      <Form.Group as={Col}>
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
