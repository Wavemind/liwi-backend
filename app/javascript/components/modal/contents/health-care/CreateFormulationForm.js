import React from "react";
import {
  Button,
  Modal,
  Form,
  InputGroup,
  ButtonGroup,
  ToggleButton,
  Col
} from "react-bootstrap";
import { withDiagram } from "../../../../context/Diagram.context";
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
  handleFormChange = () => {
    const value = event.target.value;
    const name = event.target.name;

    const {
      index
    } = this.props;

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
      medicationForm
    } = this.props;

    const {
      administrationRoute,
      minimalDosePerKg,
      maximalDosePerKg,
      maximalDosePerDay,
      dosesPerDay,
      doseForm,
      breakable,
      uniqueDose,
      concentration
    } = formulations[index];

    let unity = '';
    let tabletFields = {display: 'none'};
    let capsFields = {display: 'none'};
    let liquidFields = {display: 'none'};
    let pillOrLiquidFields = {display: 'none'};
    let simpleFields = {};

    if (["Tablet", "Capsule", "Syrup", "Suspension"].includes(medicationForm)) {
      simpleFields = {display: 'none'};
      pillOrLiquidFields = {};
      if (["Tablet"].includes(medicationForm)) {
        tabletFields = {};
        unity = 'mg';
      } else if (["Syrup", "Suspension"].includes(medicationForm)) {
        liquidFields = {};
        unity = 'ml';
      }
      else {
        capsFields = {};
        unity = 'mg';
      }
    }

    return (
      <Form onSubmit={() => this.create()}>
        <Modal.Body>

          <Form.Row>
            <Form.Group as={Col} controlId="administrationRoute">
              <Form.Label>Administration route</Form.Label>
              <Form.Control as="select" name="answerType" onChange={this.handleFormChange} value={administrationRoute} isInvalid={!!errors.administration_route }>
                <option value="">Select the administration route</option>
                {administrationRoutes.map((administrationRoute) => (
                  <option value={administrationRoute.id}>{administrationRoute.display_name}</option>
                ))}
              </Form.Control>

              <Form.Control.Feedback type="invalid">
                {errors.administration_route}
              </Form.Control.Feedback>
            </Form.Group>

            <Form.Group as={Col}>
              <Form.Label>Doses per day</Form.Label>
              <InputGroup>
                <Form.Control
                  type="number"
                  aria-describedby="inputGroupPrepend"
                  name="dosesPerDay"
                  value={dosesPerDay}
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
              <Form.Label>Treatment conditioned by </Form.Label>
              <ButtonGroup toggle>
                <ToggleButton type="radio" name="radio" defaultChecked value="1">
                  Weight
                </ToggleButton>
                <ToggleButton type="radio" name="radio" value="2">
                  Age
                </ToggleButton>
              </ButtonGroup>
            </Form.Group>

            <Form.Group as={Col} style={capsFields}>

            </Form.Group>

            <Form.Group as={Col} controlId="breakable" style={tabletFields}>
              <Form.Label>Breakable</Form.Label>
              <Form.Control as="select" name="breakable" onChange={this.handleFormChange} value={breakable} isInvalid={!!errors.breakable }>
                <option value="">Select the administration route</option>
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
                  name="uniqueDose"
                  value={uniqueDose}
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
                  name="concentration"
                  value={concentration}
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
              <Form.Label>Minimal dose per kg (mg)</Form.Label>
              <InputGroup>
                <Form.Control
                  type="number"
                  aria-describedby="inputGroupPrepend"
                  name="minimalDosePerKg"
                  value={minimalDosePerKg}
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
                  name="maximalDosePerKg"
                  value={maximalDosePerKg}
                  onChange={this.handleFormChange}
                  isInvalid={!!errors.maximal_dose_per_kg}
                />
                <Form.Control.Feedback type="invalid">
                  {errors.maximal_dose_per_kg}
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
                  name="doseForm"
                  value={doseForm}
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
                  name="maximalDosePerDay"
                  value={maximalDosePerDay}
                  onChange={this.handleFormChange}
                  isInvalid={!!errors.maximal_dose}
                />
                <Form.Control.Feedback type="invalid">
                  {errors.maximal_dose}
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
    );
  }
}

export default withDiagram(CreateFormulationForm);
