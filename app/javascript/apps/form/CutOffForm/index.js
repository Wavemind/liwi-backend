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

    let result = await httpRequest.json();

    // Set cut offs  + set label with infos + reload canvas + close modal
    if (httpRequest.status === 200) {
      diagramObject.options.cutOffStart = result.cut_off_start;
      diagramObject.options.cutOffEnd = result.cut_off_end;

      const label = I18n.t("conditions.cut_off_label", {start: result.cut_off_start, end: result.cut_off_end});
      if (diagramObject.getLabel() === undefined) {
        diagramObject.addLabel(label);
      } else {
        diagramObject.getLabel().setLabel(label);
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
    const {
      conditionCutOffStart,
      conditionCutOffEnd,
      diagnosisDeployed
    } = this.props;

    return (
      <FadeIn>
        <Formik
          validationSchema={cutOffSchema}
          initialValues={{
            cut_off_start: conditionCutOffStart != null ? conditionCutOffStart : "",
            cut_off_end: conditionCutOffEnd != null ? conditionCutOffEnd : "",
            cut_off_value_type: "days",

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
                <Form.Label>{I18n.t("activerecord.attributes.node.cut_off_start")}&nbsp;&#x2265;&nbsp;</Form.Label>
                <Form.Group controlId="validationCutOffStart">
                  <Form.Control
                    name="cut_off_start"
                    value={values.cut_off_start}
                    onChange={handleChange}
                    disabled={diagnosisDeployed}
                    isInvalid={touched.cut_off_start && !!errors.cut_off_start}
                  />
                  <Form.Control.Feedback type="invalid">
                    {errors.cut_off_start}
                  </Form.Control.Feedback>
                </Form.Group>
                <Form.Label>&nbsp;{I18n.t("to")}&nbsp;&#x3c;&nbsp;</Form.Label>

                <Form.Group controlId="validationCutOffEnd">
                  <Form.Control
                    name="cut_off_end"
                    value={values.cut_off_end}
                    onChange={handleChange}
                    disabled={diagnosisDeployed}
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
                    disabled={diagnosisDeployed}
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
