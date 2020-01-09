import React from "react";
import {
  Button,
  Modal,
  Form,
  InputGroup,
  Col
} from "react-bootstrap";
import { withDiagram } from "../../../../context/Diagram.context";

/**
 * @author Emmanuel Barchichat
 * Modal content to create an health cares
 */
class CreateHealthCareForm extends React.Component {
  constructor(props) {
    super(props);
  }

  state = {
    reference: "",
    label: "",
    description: "",
    minimalDosePerKg: null,
    maximalDosePerKg: null,
    maximalDose: null,
    dosesPerDay: null,
    treatmentType: null,
    pillSize: null,
    errors: {}
  };

  // Update the score in DB then set score props in order to trigger listener in Diagram.js that will update diagram dynamically
  create = async () => {
    const {
      toggleModal,
      http,
      addMessage,
      set,
      currentHealthCareType
    } = this.props;

    const {
      reference,
      label,
      description,
      minimalDosePerKg,
      maximalDosePerKg,
      maximalDose,
      dosesPerDay,
      treatmentType,
      pillSize
    } = this.state;

    let result = await http.createHealthCare(currentHealthCareType, reference, label, description, minimalDosePerKg, maximalDosePerKg, maximalDose, dosesPerDay, treatmentType, pillSize);
    if (result.ok === undefined || result.ok) {
      toggleModal();
      await addMessage({ status: result.status, messages: result.messages });
      set("currentDbNode", result.node);
    } else {
      let newErrors = {};
      if (result.errors.reference !== undefined) {
        newErrors.reference = result.errors.reference[0];
      }

      if (result.errors.label_en !== undefined) {
        newErrors.label_en = result.errors.label_en[0];
      }
      this.setState({ errors: newErrors });
    }
  };

  // Set value of inputs in state
  updateState = (event) => {
    const key = event.target.name;
    const value = event.target.value;
    this.setState({ [key]: value });

    console.log(this.state.treatmentType);
  };

  render() {
    const {
      toggleModal,
      currentHealthCareType,
      treatmentTypes
    } = this.props;
    const {
      reference,
      label,
      description,
      minimalDosePerKg,
      maximalDosePerKg,
      maximalDose,
      dosesPerDay,
      treatmentType,
      pillSize,
      errors,
    } = this.state;

    return (
      <Form onSubmit={this.create}>
        <Modal.Header>
          <Modal.Title>Create an health cares</Modal.Title>
        </Modal.Header>
        <Modal.Body>
          <Form.Row>
            <Form.Group as={Col}>
              <Form.Label>Reference</Form.Label>
              <InputGroup>
                <InputGroup.Prepend>
                  <InputGroup.Text id="inputGroupPrepend">{(currentHealthCareType === 'treatments') ? 'T' : 'M'}</InputGroup.Text>
                </InputGroup.Prepend>
                <Form.Control
                  type="text"
                  aria-describedby="inputGroupPrepend"
                  name="reference"
                  value={reference}
                  onChange={this.updateState}
                  isInvalid={!!errors.reference}
                />
                <Form.Control.Feedback type="invalid">
                  {errors.reference}
                </Form.Control.Feedback>
              </InputGroup>
            </Form.Group>
          </Form.Row>

          <Form.Row>
            <Form.Group as={Col}>
              <Form.Label>Label</Form.Label>
              <InputGroup>
                <Form.Control
                  type="text"
                  aria-describedby="inputGroupPrepend"
                  name="label"
                  value={label}
                  onChange={this.updateState}
                  isInvalid={!!errors.label_en}
                />
                <Form.Control.Feedback type="invalid">
                  {errors.label_en}
                </Form.Control.Feedback>
              </InputGroup>
            </Form.Group>
          </Form.Row>

          {(currentHealthCareType === 'treatments') ? (
            <div>
              <Form.Row>
                <Form.Group as={Col}>
                  <Form.Label>Minimal dose per kg</Form.Label>
                  <InputGroup>
                    <Form.Control
                      type="number"
                      name="minimalDosePerKg"
                      value={minimalDosePerKg}
                      onChange={this.updateState}
                    />
                  </InputGroup>
                </Form.Group>
              </Form.Row>

              <Form.Row>
                <Form.Group as={Col}>
                  <Form.Label>Maximal dose per kg</Form.Label>
                  <InputGroup>
                    <Form.Control
                      type="number"
                      name="maximalDosePerKg"
                      value={maximalDosePerKg}
                      onChange={this.updateState}
                    />
                  </InputGroup>
                </Form.Group>
              </Form.Row>

              <Form.Row>
                <Form.Group as={Col}>
                  <Form.Label>Maximal dose</Form.Label>
                  <InputGroup>
                    <Form.Control
                      type="number"
                      name="maximalDose"
                      value={maximalDose}
                      onChange={this.updateState}
                    />
                  </InputGroup>
                </Form.Group>
              </Form.Row>

              <Form.Row>
                <Form.Group as={Col}>
                  <Form.Label>Doses per day</Form.Label>
                  <InputGroup>
                    <Form.Control
                      type="number"
                      name="dosesPerDay"
                      value={dosesPerDay}
                      onChange={this.updateState}
                    />
                  </InputGroup>
                </Form.Group>
              </Form.Row>

              <Form.Row>
                <Form.Group as={Col} controlId="stage">
                  <Form.Label>Treatment form</Form.Label>
                  <Form.Control as="select" name="treatmentType" onChange={this.updateState} value={treatmentType}>
                    <option value="">Select the stage</option>
                    {Object.keys(treatmentTypes).map(function(key) {
                      return <option value={treatmentTypes[key]}>{key.charAt(0).toUpperCase() + key.slice(1)}</option>;
                    })}
                  </Form.Control>
                  <Form.Control.Feedback type="invalid">
                    {errors.treatment_type}
                  </Form.Control.Feedback>
                </Form.Group>
              </Form.Row>

              <Form.Row>
                <Form.Group as={Col}>
                  <Form.Label>Pill size</Form.Label>
                  <InputGroup>
                    <Form.Control
                      type="number"
                      name="pillSize"
                      value={pillSize}
                      onChange={this.updateState}
                    />
                  </InputGroup>
                </Form.Group>
              </Form.Row>
            </div>
          ) : null}

          <Form.Row>
            <Form.Group as={Col}>
              <Form.Label>Description</Form.Label>
              <InputGroup>
                <Form.Control
                  type="text"
                  as="textarea"
                  rows="3"
                  name="description"
                  width="100%"
                  value={description}
                  onChange={this.updateState}
                />
              </InputGroup>
            </Form.Group>
          </Form.Row>

        </Modal.Body>
        <Modal.Footer>
          <Button variant="primary" onClick={this.create}>
            Create
          </Button>
          <Button variant="secondary" onClick={toggleModal}>
            Close
          </Button>
        </Modal.Footer>
      </Form>
    );
  }
}

export default withDiagram(CreateHealthCareForm);
