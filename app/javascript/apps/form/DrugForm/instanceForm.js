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

export default class InstanceForm extends React.Component {

  /**
   * Create or update value in database + update diagram if we're editting from diagram
   * @params [Object] values
   * @params [Object] actions
   */
  handleOnSubmit = async (values, actions) => {
    const { method, engine, diagramObject, addAvailableNode, drug, positions, removeAvailableNode, from, isFromAvailableNode } = this.props;
    let http = new Http();
    let httpRequest = {};

    if (method === "create") {
      httpRequest = await http.createInstance(drug.id, positions.x, positions.y, values.duration, values.description);
    } else {
      const drugInstance = diagramObject.options.dbInstance;
      httpRequest = await http.updateInstance(drugInstance.id, drugInstance.position_x, drugInstance.position_y, values.duration_en, values.description_en);
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

    return (
      <FadeIn>
        <Formik
          validationSchema={drugInstanceSchema}
          initialValues={{
            duration_en: method === "create" ? "" : diagramObject.options.dbInstance.duration_translations?.en || "",
            description_en: method === "create" ? drug?.description_translations?.en : diagramObject.options.dbInstance.description_translations?.en || ""
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
              <Form.Group controlId="validationDuration">
                <Form.Label>{I18n.t("activerecord.attributes.instance.duration")}</Form.Label>
                <Form.Control
                  name="duration_en"
                  value={values.duration_en}
                  onChange={handleChange}
                  isInvalid={touched.duration_en && !!errors.duration_en}
                />
                <Form.Control.Feedback type="invalid">
                  {errors.duration_en}
                </Form.Control.Feedback>
              </Form.Group>

              <Form.Group controlId="validationDescription">
                <Form.Label>{I18n.t("activerecord.attributes.instance.description")}</Form.Label>
                <Form.Control
                  name="description_en"
                  as="textarea"
                  value={values.descriptionv}
                  onChange={handleChange}
                  isInvalid={touched.description_en && !!errors.description_en}
                />
                <Form.Control.Feedback type="invalid">
                  {errors.description_en}
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
