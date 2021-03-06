import * as React from "react";
import I18n from "i18n-js";
import FadeIn from "react-fade-in";
import { Form, Button } from "react-bootstrap";
import { Formik } from "formik";

import { scoreSchema } from "../constants/schema";
import { closeModal } from "../../diagram/engine/reducers/creators.actions";
import Http from "../../diagram/engine/http";
import store from "../../diagram/engine/reducers/store";
import DisplayErrors from "../components/DisplayErrors";


export default class ScoreForm extends React.Component {

  /**
   * Create or update value in database + update diagram if we're editting from diagram
   * @param [Object] values
   * @param [Object] actions
   */
  handleOnSubmit = async (values, actions) => {
    const { instanceId, answerId, diagramObject, engine, method } = this.props;
    const http = new Http();
    let httpRequest = {};

    if (method === "create") {
      httpRequest = await http.createLink(instanceId, answerId, values.score);
    } else {
      httpRequest = await http.updateConditionScore(diagramObject.options.dbConditionId, values.score);
    }

    const result = await httpRequest.json();

    // Set score to link + set label with score + reload canvas + close modal
    if (httpRequest.status === 200) {
      diagramObject.options.score = values.score;
      diagramObject.options.parentInstanceId = diagramObject.sourcePort.parent.options.dbInstance.id;
      diagramObject.options.dbConditionId = result.id;

      if (method === "create") {
        diagramObject.addLabel(values.score);
      } else {
        diagramObject.getLabel().setLabel(values.score);
      }

      engine.repaintCanvas();

      store.dispatch(
        closeModal()
      );
    } else {
      actions.setStatus({ result });
    }
  };

  render() {
    const { score } = this.props;

    return (
      <FadeIn>
        <Formik
          validationSchema={scoreSchema}
          initialValues={{ score: score }}
          onSubmit={(values, actions) => this.handleOnSubmit(values, actions)}
        >
          {({
              handleSubmit,
              handleChange,
              isSubmitting,
              touched,
              values,
              errors,
              status
            }) => (
            <Form noValidate onSubmit={handleSubmit}>
              {status ? <DisplayErrors errors={status}/> : null}
              <Form.Group controlId="validationScore">
                <Form.Label>{I18n.t("activerecord.attributes.condition.score")}</Form.Label>
                <Form.Control
                  type="number"
                  name="score"
                  value={values.score}
                  onChange={handleChange}
                  isInvalid={touched.score && !!errors.score}
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
      </FadeIn>
    );
  }
}
