import * as React from "react";
import I18n from "i18n-js";
import FadeIn from "react-fade-in";
import { Form, Button } from "react-bootstrap";
import { Formik } from "formik";

import Http from "../../diagram/engine/http";
import store from "../../diagram/engine/reducers/store";
import DisplayErrors from "../components/DisplayErrors";
import { drugInstanceSchema } from "../constants/schema";
import { createNode } from "../../diagram/helpers/nodeHelpers";
import { closeModal } from "../../diagram/engine/reducers/creators.actions";
import { getStudyLanguage } from "../../utils";

export default class InstanceForm extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      language: getStudyLanguage()
    };

  }

  /**
   * Create or update value in database + update diagram if we're editting from diagram
   * @params [Object] values
   * @params [Object] actions
   */
  handleOnSubmit = async (values, actions) => {
    const l = getStudyLanguage();
    const { method, engine, diagramObject, addAvailableNode, drug, positions, removeAvailableNode, from, isFromAvailableNode } = this.props;
    let http = new Http();
    let httpRequest = {};

    if (method === "create") {
      httpRequest = await http.createInstance(drug.id, positions.x, positions.y, values[`duration_${l}`], values[`description_${l}`]);
    } else {
      const drugInstance = diagramObject.options.dbInstance;
      httpRequest = await http.updateInstance(drugInstance.id, drugInstance.position_x, drugInstance.position_y, values[`duration_${l}`], values[`description_${l}`]);
    }

    let result = await httpRequest.json();

    if (httpRequest.status === 200) {
      if (method === "create") {
        let diagramInstance = createNode(result, addAvailableNode, false, result.node.category_name, engine);
        engine.getModel().addNode(diagramInstance);

        // If the instance is created from available nodes (and not from the drug creation form)
        if (isFromAvailableNode) {
          removeAvailableNode(drug);
        }
      } else {
        diagramObject.options.dbInstance = result;
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
      diagramObject,
      method,
      drug
    } = this.props;

    const { language } = this.state;
    const body = {
      is_pre_referral: diagramObject.options.dbInstance?.is_pre_referral || false,
    };
    body[`duration_${language}`] = method === "create" ? "" : diagramObject.options.dbInstance.duration_translations?.send(language) || "",
    body[`description_${language}`] = method === "create" ? drug?.description_translations?.send(language) : diagramObject.options.dbInstance.description_translations?.send(language) || ""

    return (
      <FadeIn>
        <Formik
          validationSchema={drugInstanceSchema}
          initialValues={body}
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

              <Form.Group controlId="validationIsPreReferral">
                <Form.Check
                  name="is_pre_referral"
                  label={I18n.t("activerecord.attributes.instance.is_pre_referral")}
                  value={values.is_pre_referral}
                  checked={values.is_pre_referral}
                  onChange={handleChange}
                  isInvalid={touched.is_pre_referral && !!errors.is_pre_referral}
                />
                <Form.Control.Feedback type="invalid">
                  {errors.is_pre_referral}
                </Form.Control.Feedback>
              </Form.Group>

              <Form.Group controlId="validationDuration">
                <Form.Label>{I18n.t("activerecord.attributes.instance.duration")}</Form.Label>
                <Form.Control
                  name={`duration_${language}`}
                  value={values[`duration_${language}`]}
                  onChange={handleChange}
                  disabled={values[`duration_${language}`]}
                  isInvalid={touched[`duration_${language}`] && !!errors[`duration_${language}`]}
                />
                <Form.Control.Feedback type="invalid">
                  {errors[`duration_${language}`]}
                </Form.Control.Feedback>
              </Form.Group>

              <Form.Group controlId="validationDescription">
                <Form.Label>{I18n.t("activerecord.attributes.instance.description")}</Form.Label>
                <Form.Control
                  name={`description_${language}`}
                  as="textarea"
                  value={values[`description_${language}`]}
                  onChange={handleChange}
                  isInvalid={touched[`description_${language}`] && !!errors[`description_${language}`]}
                />
                <Form.Control.Feedback type="invalid">
                  {errors[`description_${language}`]}
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
