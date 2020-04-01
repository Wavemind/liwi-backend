import * as React from "react";
import I18n from "i18n-js";
import FadeIn from "react-fade-in";
import { Form, Button } from "react-bootstrap";
import { Formik } from "formik";

import {drugInstanceSchema} from "../constants/schema";
import Http from "../../diagram/engine/http";
import {createNode} from "../../diagram/helpers/nodeHelpers";
import store from "../../diagram/engine/reducers/store";
import {closeModal} from "../../diagram/engine/reducers/creators.actions";

export default class InstanceForm extends React.Component {

  handleOnSubmit = async (values, actions) => {
    const { method, engine, diagramObject, addAvailableNode, drug, positions, removeAvailableNode, from } = this.props;
    let http = new Http();
    let httpRequest = {};

    console.log(positions);

    if (method === "create") {
      httpRequest = await http.createInstance(drug.id, positions.x, positions.y, values.duration, values.description);
    } else {
      httpRequest = await http.updateInstance(drug.id, 100, 100, values.duration, values.description);
    }

    let result = await httpRequest.json();

    if (httpRequest.status === 200) {
      if (method === "create") {
        let diagramInstance = createNode(result, addAvailableNode, false, result.node.category_name, engine);
        engine.getModel().addNode(diagramInstance);

        // If the instance is created from available nodes (and not from the drug creation form)
        if (from !== "react") {
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

    console.log(drug);
    console.log(method);


    return (
      <FadeIn>
        <Formik
          validationSchema={drugInstanceSchema}
          initialValues={{
            duration: method === "create" ? "" : diagramObject.options.dbInstance.duration || "",
            description: method === "create" ? drug?.description_translations?.en : diagramObject.options.dbInstance.description || ""
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
              <Form.Group controlId="validationDuration">
                <Form.Label>{I18n.t("activerecord.attributes.instance.duration")}</Form.Label>
                <Form.Control
                  name="duration"
                  value={values.duration}
                  onChange={handleChange}
                  isInvalid={touched.duration && !!errors.duration}
                />
                <Form.Control.Feedback type="invalid">
                  {errors.duration}
                </Form.Control.Feedback>
              </Form.Group>

              <Form.Group controlId="validationDescription">
                <Form.Label>{I18n.t("activerecord.attributes.instance.description")}</Form.Label>
                <Form.Control
                  name="description"
                  as="textarea"
                  value={values.description}
                  onChange={handleChange}
                  isInvalid={touched.description && !!errors.description}
                />
                <Form.Control.Feedback type="invalid">
                  {errors.description}
                </Form.Control.Feedback>
              </Form.Group>

              <Button type="submit">
                {I18n.t("save")}
              </Button>
            </Form>
          )}
        </Formik>
      </FadeIn>
    );
  }
}
