import React from "react";
import {
  Button,
  Modal,
  ListGroup,
  Row,
  Col,
  Form,
  Alert
} from "react-bootstrap";
import * as _ from "lodash";
import { withDiagram } from "../context/Diagram.context";
import Http from "../http";

class FormModal extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      instance: {
        conditions: null
      },
      available_conditions: [],
      operators: []
    };
  }

  async shouldComponentUpdate(nextProps, nextState) {
    return nextProps.currentNodeId !== this.props.currentNodeId && nextProps.modalIsOpen;
  }

  async componentWillReceiveProps(nextProps) {
    const { currentNodeId } = nextProps;
    const http = new Http();
    const json = await http.getInstanceConditions(currentNodeId);
    await this.setState({
      instance: json.instance,
      available_conditions: json.available_conditions,
      operators: json.operators
    });
  }

  toggleModal = async () => {
    const { set, modalIsOpen } = this.props;
    await set("modalIsOpen", !modalIsOpen);
  };

  removeCondition = async (id) => {
    const http = new Http();
    await http.removeCondition(this.state.instance.id, id);

    let newInstance = {
      ...this.state.instance,
      conditions: [...this.state.instance.conditions],
    };

    _.remove(newInstance.conditions, function(condition) {
      return condition.id === id;
    });

    await this.setState({
      instance: newInstance,
    });
  };

  render() {
    const { modalIsOpen } = this.props;
    const { instance, available_conditions, operators } = this.state;

    return (
      modalIsOpen && instance.conditions !== null ? (
        <Modal show={modalIsOpen} onHide={() => this.toggleModal()} size="lg">
          <Modal.Header closeButton>
            <Modal.Title>{instance.instanceable_type}</Modal.Title>
          </Modal.Header>
          <Modal.Body>
            {instance.conditions.length > 0 ? (
            <ListGroup>
              {instance.conditions.map((condition, index) => (
                <ListGroup.Item key={index}>
                  <Row>
                    <Col>{condition.display_condition}</Col>
                    <Col className="text-right"><Button onClick={() => this.removeCondition(condition.id)} variant="outline-danger">Remove</Button></Col>
                  </Row>
                </ListGroup.Item>
              ))}
            </ListGroup>
            ) : (
              <Alert variant="info">
                there are no conditions
              </Alert>
            )}

            <hr/>

            <Form>
              <Row>
                <Col>
                  <Form.Group controlId="exampleForm.ControlSelect1">
                    <Form.Control as="select">
                      <option>Select</option>
                      {
                        available_conditions.map((cond) => (
                          <option value={cond.id}>{cond.display_condition}</option>
                        ))
                      }
                    </Form.Control>
                  </Form.Group>
                </Col>
                <Col>
                  <Form.Group controlId="exampleForm.ControlSelect1">
                    <Form.Control as="select">
                      <option>Select</option>
                      {
                        operators.map((operator) => (
                          <option>{operator[0]}</option>
                        ))
                      }
                    </Form.Control>
                  </Form.Group>
                </Col>
                <Col>
                  <Form.Group controlId="exampleForm.ControlSelect1">
                    <Form.Control as="select">
                      <option>Select</option>
                      {
                        available_conditions.map((cond) => (
                          <option value={cond.id}>{cond.display_condition}</option>
                        ))
                      }
                    </Form.Control>
                  </Form.Group>
                </Col>
                <Col className="text-right">
                  <Button variant="success">
                    Add
                  </Button>
                </Col>
              </Row>
            </Form>
          </Modal.Body>
          <Modal.Footer>
            <Button variant="secondary" onClick={() => this.toggleModal()}>
              Close
            </Button>
          </Modal.Footer>
        </Modal>
      ) : null
    );
  }
}

export default withDiagram(FormModal);
