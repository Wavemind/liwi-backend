import React from "react";
import {
  Button,
  Modal,
  Form,
  InputGroup,
  Col
} from "react-bootstrap";
import Autocomplete from '@material-ui/lab/Autocomplete';
import TextField from '@material-ui/core/TextField';
import { withDiagram } from "../../../../context/Diagram.context";
import * as _ from "lodash";

/**
 * @author Emmanuel Barchichat
 * Modal to update a question
 */
class UpdateQuestionForm extends React.Component {
  constructor(props) {
    super(props);
  }

  state = {
    id: "",
    reference: "",
    label: "",
    description: "",
    type: "",
    stage: "",
    system: "",
    is_mandatory: false,
    answerType: "",
    formula: "",
    snomedId: "",
    snomedLabel: "",
    snomedResults: [],
    errors: {}
  };

  async componentWillMount() {
    const {
      currentNode,
      questionStages,
      questionSystems,
    } = this.props;
    const newCurrentNode = _.cloneDeep(currentNode);

    let system = questionSystems.find((element) => {return element[1] === newCurrentNode.system});

    this.setState({
      id: newCurrentNode.id,
      reference: newCurrentNode.reference,
      label: newCurrentNode.label_translations["en"],
      type: newCurrentNode.type,
      description: newCurrentNode.description_translations === null ? "" : newCurrentNode.description_translations["en"],
      is_mandatory: newCurrentNode.is_mandatory,
      stage: questionStages[newCurrentNode.stage],
      system: system === null ? null : system[1],
      answerType: newCurrentNode.answer_type_id,
      formula: newCurrentNode.formula,
      snomedId: newCurrentNode.snomed_id,
      snomedLabel: newCurrentNode.snomed_label,
    });
  }

  updateAnswers = async () => {
    const { set, http } = this.props;
    const question = this.generateQuestionBody();


    let result = await http.validateQuestion(question);
    if (result.ok === undefined || result.ok) {
      set(
        ['currentQuestion', 'modalToOpen', 'modalIsOpen'],
        [question, 'UpdateAnswers', true]
      );
    } else {
      this.handleErrors(result);
    }
  };

  // Update the score in DB then set score props in order to trigger listener in Diagram.js that will update diagram dynamically
  update = async () => {
    const {
      toggleModal,
      http,
      addMessage,
      set,
      currentNode
    } = this.props;

    const { id } = this.state;
    let question = this.generateQuestionBody();

    let result = await http.updateQuestion(question);
    if (result.ok === undefined || result.ok) {
      toggleModal();
      await addMessage({ status: result.status, messages: result.messages });
      set("currentDbNode", result.node);
    } else {
      let newErrors = {};
      if (result.errors.reference !== undefined) {
        newErrors.reference = result.errors.reference[0];
      }

      if (result.errors.label !== undefined) {
        newErrors.label = result.errors.label[0];
      }
      this.setState({ errors: newErrors });
    }
  };

  // Display errors from response of the question validation from rails if there is any
  handleErrors = (result) => {
    let newErrors = {};

    if (result.errors.reference !== undefined) {
      newErrors.reference = result.errors.reference[0];
    }

    if (result.errors.label_en !== undefined) {
      newErrors.label_en = result.errors.label_en[0];
    }

    if (result.errors.formula !== undefined) {
      newErrors.formula = result.errors.formula[0];
    }
    this.setState({ errors: newErrors });
  };

  // Generate the body of the question
  generateQuestionBody = () => {
    const {
      id,
      reference,
      label,
      description,
      type,
      stage,
      system,
      is_mandatory,
      answerType,
      formula,
      snomedId,
      snomedLabel
    } = this.state;

    return {
      question: {
        id: id,
        reference: reference,
        label_en: label,
        description_en: description,
        type: type,
        stage: parseInt(stage),
        system: system,
        is_mandatory: is_mandatory,
        answer_type_id: parseInt(answerType),
        formula: formula,
        snomedId: parseInt(snomedId),
        snomedLabel: snomedLabel,
        answers_attributes: {}
      }
    };
  };

  // Handle change of inputs in the form
  handleFormChange = (event) => {
    const value = name === "isMandatory" ? event.target.checked : event.target.value;
    const name = event.target.name;

    this.setState({
      [name]: value
    });
  };

  /**
   * Search in snomed api to get results
   *
   * @param {Object} event
   */
  searchSnomed = async (event) => {
    const { http } = this.props;

    let response = await http.searchSnomed(event.target.value);
    this.setState({ snomedResults: response.items });
  };

  /**
   * Save id and value of snomed selected
   *
   * @param {Object} event
   */
  snomedChange = async (event, value) => {
    this.setState({
      snomedId: value.id,
      snomedLabel: value.fsn.term
    });
  };

  render() {
    const {
      toggleModal,
      questionCategories,
      questionAnswerTypes,
      questionStages,
      questionSystems,
      getReferencePrefix
    } = this.props;
    const {
      reference,
      label,
      description,
      errors,
      type,
      stage,
      system,
      is_mandatory,
      answerType,
      formula,
      snomedLabel,
      snomedResults
    } = this.state;

    let formulaStyle = answerType !== 5 ? {display: 'none'} : {};
    let systemStyle = !["Questions::Symptom", "Questions::PhysicalExam", "Questions::ObservedPhysicalSign"].includes(type) ? {display: 'none'} : {};

    return (
      <Form onSubmit={() => this.create()}>
        <Modal.Header>
          <Modal.Title>Update this question</Modal.Title>
        </Modal.Header>
        <Modal.Body>
          <Form.Row>
            <Form.Group as={Col} controlId="category">
              <Form.Label>Category</Form.Label>
              <Form.Control as="select" defaultValue={type} disabled>
                <option value="">Select a category</option>
                {questionCategories.map((category) => (
                  <option value={category.name}>{category.label}</option>
                ))}
              </Form.Control>
            </Form.Group>
          </Form.Row>

          <Form.Row style={systemStyle}>
            <Form.Group as={Col} controlId="system">
              <Form.Label>System</Form.Label>
              <Form.Control as="select" name="system" onChange={this.handleFormChange} value={system} isInvalid={!!errors.system } >
                <option value="">Select the system</option>
                {questionSystems.map((system) => (
                  <option value={system[1]}>{system[0]}</option>
                ))}
              </Form.Control>
            </Form.Group>
          </Form.Row>

          <Form.Row>
            <Form.Group as={Col} controlId="answerType">
              <Form.Label>Answer type</Form.Label>
              <Form.Control as="select" defaultValue={answerType} disabled>
                <option value="">Select a category</option>
                {questionAnswerTypes.map((answerType) => (
                  <option value={answerType.id}>{answerType.display_name}</option>
                ))}
              </Form.Control>
            </Form.Group>
          </Form.Row>

          <Form.Row>
            <Form.Group as={Col} controlId="stage">
              <Form.Label>Stage</Form.Label>
              <Form.Control as="select" name="stage" onChange={this.handleFormChange} defaultValue={stage} disabled>
                <option value="">Select a category</option>
                {Object.keys(questionStages).map(function(key) {
                  return <option value={questionStages[key]}>{key.charAt(0).toUpperCase() + key.slice(1)}</option>;
                })}
              </Form.Control>
            </Form.Group>
          </Form.Row>

          <Form.Row>
            <Form.Group as={Col}>
              <Form.Check
                type="checkbox"
                label="Is Mandatory"
                name="isMandatory"
                value={isMandatory}
                onChange={this.handleFormChange}
              />
            </Form.Group>
          </Form.Row>

          <Form.Row>
            <Form.Group as={Col}>
              <Form.Label>Reference</Form.Label>
              <InputGroup>
                <InputGroup.Prepend>
                  <InputGroup.Text id="inputGroupPrepend">{getReferencePrefix('Question', type)}</InputGroup.Text>
                </InputGroup.Prepend>
                <Form.Control
                  type="text"
                  aria-describedby="inputGroupPrepend"
                  name="reference"
                  value={reference}
                  onChange={this.handleFormChange}
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
                  onChange={this.handleFormChange}
                  isInvalid={!!errors.label_en}
                />
                <Form.Control.Feedback type="invalid">
                  {errors.label_en}
                </Form.Control.Feedback>
              </InputGroup>
            </Form.Group>
          </Form.Row>

          <Form.Row>
            <Form.Group as={Col}>
              <Form.Label>Snomed</Form.Label>
                <Autocomplete
                  options={snomedResults}
                  getOptionLabel={option => option.fsn.term}
                  autoComplete
                  includeInputInList
                  freeSolo
                  disableOpenOnFocus
                  defaultValue={{fsn: {term: snomedLabel}}}
                  onChange={this.snomedChange}
                  renderInput={params => (
                    <TextField {...params} label="Search a snomed label" variant="outlined" onChange={this.searchSnomed} fullWidth />
                  )}
                />
            </Form.Group>
          </Form.Row>

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
                  onChange={this.handleFormChange}
                />
              </InputGroup>
            </Form.Group>
          </Form.Row>

          <Form.Row style={formulaStyle}>
            <Form.Group as={Col}>
              <Form.Label>Formula</Form.Label>
              <InputGroup>
                <Form.Control
                  type="text"
                  name="formula"
                  value={formula}
                  onChange={this.handleFormChange}
                  isInvalid={!!errors.formula}
                />
                <Form.Control.Feedback type="invalid">
                  {errors.formula}
                </Form.Control.Feedback>
              </InputGroup>
            </Form.Group>
          </Form.Row>

        </Modal.Body>
        <Modal.Footer>
          {/*Save directly the question if it is a boolean*/}
          {(answerType === 1) ? (
            <Button variant="success" onClick={() => this.update()}>
              Save
            </Button>
          ) : (
            <Button variant="primary" onClick={() => this.updateAnswers()}>
              Save and create answers
            </Button>
          )}
          <Button variant="secondary" onClick={() => toggleModal()}>
            Close
          </Button>
        </Modal.Footer>
      </Form>
    );
  }
}

export default withDiagram(UpdateQuestionForm);
