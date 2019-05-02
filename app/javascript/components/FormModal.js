import React from "react";
import {
  Button,
  Modal,
  ListGroup,
  Row,
  Col,
  Form
} from "react-bootstrap";
import { withDiagram } from "../context/Diagram.context";
import Http from "../http";

class FormModal extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      instance: {
        conditions: []
      }
    };
  }

  async shouldComponentUpdate(nextProps, nextState) {
    return nextProps.currentNodeId !== this.props.currentNodeId && nextProps.modalIsOpen;
  }

  async componentWillReceiveProps(nextProps) {
    const { currentNodeId } = nextProps;
    const http = new Http();
    let instance = await http.getInstanceConditions(currentNodeId);
    await this.setState({ instance });
  }

  toggleModal = async () => {
    const { set, modalIsOpen } = this.props;
    await set("modalIsOpen", !modalIsOpen);
  };

  render() {
    const { modalIsOpen } = this.props;
    const { instance } = this.state;
    return (
      modalIsOpen && instance.conditions.length > 0 ? (
        <Modal show={modalIsOpen} onHide={() => this.toggleModal()} size="lg">
          <Modal.Header closeButton>
            <Modal.Title>{instance.instanceable_type}</Modal.Title>
          </Modal.Header>
          <Modal.Body>

            <h2>Conditions</h2>
            <ListGroup>
              {instance.conditions.map((condition, index) => (
                <ListGroup.Item key={index}>
                  <Row>
                    <Col>{condition.first_conditionable_type}: {condition.first_conditionable.node.reference}</Col>
                    <Col className="text-right"><Button variant="outline-danger">Remove</Button></Col>
                  </Row>
                </ListGroup.Item>
              ))}
            </ListGroup>

            <hr/>

            <Form>
              <Row>
                <Col>
                  <Form.Group controlId="exampleForm.ControlSelect1">
                    <Form.Control as="select">
                      <option>1</option>
                      <option>2</option>
                      <option>3</option>
                      <option>4</option>
                      <option>5</option>
                    </Form.Control>
                  </Form.Group>
                </Col>
                <Col>
                  <Form.Group controlId="exampleForm.ControlSelect1">
                    <Form.Control as="select">
                      <option>1</option>
                      <option>2</option>
                      <option>3</option>
                      <option>4</option>
                      <option>5</option>
                    </Form.Control>
                  </Form.Group>
                </Col>
                <Col>
                  <Form.Group controlId="exampleForm.ControlSelect1">
                    <Form.Control as="select">
                      <option>1</option>
                      <option>2</option>
                      <option>3</option>
                      <option>4</option>
                      <option>5</option>
                    </Form.Control>
                  </Form.Group>
                </Col>
                <Col className="text-right">
                  <Button variant="success">
                    Save
                  </Button>
                </Col>
              </Row>
            </Form>

            <hr/>

            <h2>Children</h2>
            <ListGroup>
              {instance.conditions.map((condition, index) => (
                <ListGroup.Item key={index}>
                  <Row>
                    <Col>{condition.first_conditionable_type}: {condition.first_conditionable.node.reference}</Col>
                    <Col className="text-right"><Button variant="outline-danger">Remove</Button></Col>
                  </Row>
                </ListGroup.Item>
              ))}
            </ListGroup>

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
