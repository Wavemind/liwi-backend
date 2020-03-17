import * as React from "react";
import I18n from "i18n-js";
import { Form, Button, Alert } from "react-bootstrap";
import { Formik } from "formik";

import { updateScoreSchema } from "../../engine/constants/form";
import Http from "../../engine/http";


export default class UpdateScoreForm extends React.Component {
  handleOnSubmit = async (values, actions) => {
    const { instanceId, answerId } = this.props;
    let http = new Http();

    let httpRequest = await http.createLink(instanceId, answerId, values.score);
    let result = await httpRequest.json();

    if (httpRequest.status === 200) {

    } else {
      actions.setStatus({ result });
    }
  };

  render() {
    return (
      <Formik
        validationSchema={updateScoreSchema}
        initialValues={{ score: "" }}
        onSubmit={(values, actions) => this.handleOnSubmit(values, actions)}
      >
        {({
            handleSubmit,
            handleChange,
            isSubmitting,
            values,
            errors,
            status
          }) => (
          <Form noValidate onSubmit={handleSubmit}>
            {status ?
              <Alert variant="danger">
                <ul>
                  {Object.keys(status).map(index => (<li>{status[index]}</li>))}
                </ul>
              </Alert>
              : null}
            <Form.Group controlId="validationFormik01">
              <Form.Label>{I18n.t("activerecord.attributes.condition.score")}</Form.Label>
              <Form.Control
                type="number"
                name="score"
                value={values.score}
                onChange={handleChange}
                isInvalid={!!errors.score}
              />
              <Form.Control.Feedback type="invalid">
                {errors.score}
              </Form.Control.Feedback>
            </Form.Group>
            <Button type="submit" disabled={isSubmitting}>
              {I18n.t("save")}
            </Button>
          </Form>
        )}
      </Formik>
    );
  }
}
