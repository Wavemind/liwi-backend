import React from "react";
import Select from 'react-select';
import {
  Button,
  Modal,
  Form,
  InputGroup,
  ButtonGroup,
  ToggleButton,
  Col, Accordion, Card
} from "react-bootstrap";
import {withDiagram} from "../../../../context/Diagram.context";
import NodeListItem from "../../../lists/NodeList";

/**
 * @author Emmanuel Barchichat
 * Form of an answer
 */
class CreateFormulationForm extends React.Component {
  constructor(props) {
    super(props);
  }

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
      index,
      formulations,
      errors,
      removeFormulation,
      administrationRoutes,
      breakableOptions,
      medicationForm,
      setActiveAccordion,
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

    let unity = '';
    let tabletFields = {display: 'none'};
    let capsFields = {display: 'none'};
    let liquidFields = {display: 'none'};
    let pillOrLiquidFields = {display: 'none'};
    let simpleFields = {};

    if ((!by_age) && (["tablet", "capsule", "syrup", "suspension"].includes(medicationForm))) {
      simpleFields = {display: 'none'};
      pillOrLiquidFields = {};
      if (["tablet"].includes(medicationForm)) {
        tabletFields = {};
        unity = 'mg';
      } else if (["syrup", "suspension"].includes(medicationForm)) {
        liquidFields = {};
        unity = 'ml';
      } else {
        capsFields = {};
        unity = 'mg';
      }
    }

    return (
      <Card>
        <Accordion.Toggle onClick={() => setActiveAccordion(index)} as={Card.Header} variant="link" eventKey={index}>
          {medicationForm.charAt(0).toUpperCase() + medicationForm.slice(1)}
        </Accordion.Toggle>
        <Accordion.Collapse eventKey={index}>
          <Card.Body>
            <Form onSubmit={() => this.create()}>
              <Modal.Body>

                <Form.Row>
                  <Form.Group as={Col} controlId="administration_route_id">
                    <Form.Label>Administration route</Form.Label>

                    <Select
                      defaultValue={administration_route_id}
                      options={administrationRoutes}
                      isInvalid={!!errors.administration_route_id}
                      onChange={(val) => {
                        this.handleFormChange({target: {name: 'administration_route_id', value: val.value}})
                      }}
                    />

                    <Form.Control.Feedback type="invalid">
                      {errors.administration_route_id}
                    </Form.Control.Feedback>
                  </Form.Group>

                  <Form.Group as={Col}>
                    <Form.Label>Doses per day</Form.Label>
                    <InputGroup>
                      <Form.Control
                        type="number"
                        aria-describedby="inputGroupPrepend"
                        name="doses_per_day"
                        value={doses_per_day}
                        onChange={this.handleFormChange}
                        isInvalid={!!errors.doses_per_day}
                      />
                      <Form.Control.Feedback type="invalid">
                        {errors.doses_per_day}
                      </Form.Control.Feedback>
                    </InputGroup>
                  </Form.Group>
                </Form.Row>

                <Form.Row>
                  <Form.Group as={Col}>
                    <Form.Check
                      type="checkbox"
                      label="Treatment conditioned by age"
                      name="by_age"
                      value={by_age}
                      onChange={this.handleFormChange}
                    />
                  </Form.Group>

                  <Form.Group as={Col} style={capsFields}>

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
              </Modal.Body>
            </Form>
          </Card.Body>
        </Accordion.Collapse>
      </Card>
    );
  }
}

export default withDiagram(CreateFormulationForm);
