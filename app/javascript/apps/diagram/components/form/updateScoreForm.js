import * as React from "react";
import { Form, Button } from "react-bootstrap";
import { Formik } from 'formik';
import I18n from "i18n-js";
let yup = require('yup');

const schema = yup.object().shape({
  score: yup.number().required(I18n.t('errors.messages.required')),
});


export default class UpdateScoreForm extends React.Component {
  render() {
    return (
      <Formik
        validationSchema={schema}
        initialValues={{ score: '' }}
        onSubmit={console.log}
      >
        {({
            handleSubmit,
            handleChange,
            values,
            errors,
          }) => (
          <Form noValidate onSubmit={handleSubmit}>
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
            <Button type="submit">{I18n.t("save")}</Button>
          </Form>
        )}
      </Formik>
    );
  }
}
