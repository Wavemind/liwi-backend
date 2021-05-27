import * as React from "react";
import I18n from "i18n-js";
import FadeIn from "react-fade-in";
import { Form, Button } from "react-bootstrap";
import { Formik } from "formik";

import { cutOffSchema } from "../constants/schema";
import { closeModal } from "../../diagram/engine/reducers/creators.actions";
import Http from "../../diagram/engine/http";
import store from "../../diagram/engine/reducers/store";
import DisplayErrors from "../components/DisplayErrors";


export default class CutOffForm extends React.Component {

  /**
   * Create or update value in database + update diagram if we're editting from diagram
   * @param [Object] values
   * @param [Object] actions
   */
  handleOnSubmit = async (values, actions) => {
    const { conditionId, diagramObject, engine, method } = this.props;
    let http = new Http();
    let httpRequest = {};

    httpRequest = await http.updateCutOffs(conditionId, values.cut_off_start, values.cut_off_end, values.cut_off_value_type);

    console.log(conditionId)
    console.log(values.cut_off_start)
    console.log(values.cut_off_end)
    console.log(values.cut_off_value_type)

    let result = await httpRequest.json();

    // Set score to link + set label with score + reload canvas + close modal
    if (httpRequest.status === 200) {
      // diagramObject.options.score = values.score;
      // diagramObject.options.parentInstanceId = diagramObject.sourcePort.parent.options.dbInstance.id;
      // diagramObject.options.dbConditionId = result.id;
      //
      // if (method === "create") {
      //   diagramObject.addLabel(values.score);
      // } else {
      //   diagramObject.getLabel().setLabel(values.score);
      // }
      //
      // engine.repaintCanvas();
      //
      // store.dispatch(
      //   closeModal()
      // );
    } else {
      actions.setStatus({ result });
    }
  };

  render() {
    const {
      conditionCutOffStart,
      conditionCutOffEnd,
      diagnosticDeployed
    } = this.props;

    return (
      <FadeIn>
        <Formik
          validationSchema={cutOffSchema}
          initialValues={{
            cut_off_start: conditionCutOffStart || "",
            cut_off_end: conditionCutOffEnd || "",
            cut_off_value_type: "months",

          }}
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
              <Form.Row>
                <Form.Label>{I18n.t("activerecord.attributes.node.cut_off_start")}</Form.Label>
                <Form.Group controlId="validationCutOffStart">
                  <Form.Control
                    name="cut_off_start"
                    value={values.cut_off_start}
                    onChange={handleChange}
                    disabled={diagnosticDeployed}
                    isInvalid={touched.cut_off_start && !!errors.cut_off_start}
                  />
                  <Form.Control.Feedback type="invalid">
                    {errors.cut_off_start}
                  </Form.Control.Feedback>
                </Form.Group>
                <Form.Label>{I18n.t("to")}</Form.Label>

                <Form.Group controlId="validationCutOffEnd">
                  <Form.Control
                    name="cut_off_end"
                    value={values.cut_off_end}
                    onChange={handleChange}
                    disabled={diagnosticDeployed}
                    isInvalid={touched.cut_off_end && !!errors.cut_off_end}
                  />
                  <Form.Control.Feedback type="invalid">
                    {errors.cut_off_end}
                  </Form.Control.Feedback>
                </Form.Group>

                <Form.Group controlId="validationCutOffValueType">
                  <Form.Control
                    as="select"
                    name="cut_off_value_type"
                    value={values.cut_off_value_type}
                    onChange={handleChange}
                    disabled={diagnosticDeployed}
                    isInvalid={touched.cut_off_value_type && !!errors.cut_off_value_type}
                  >
                    <option value="months">{I18n.t("months")}</option>
                    <option value="days">{I18n.t("days")}</option>
                  </Form.Control>
                  <Form.Control.Feedback type="invalid">
                    {errors.cut_off_value_type}
                  </Form.Control.Feedback>
                </Form.Group>
              </Form.Row>

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
