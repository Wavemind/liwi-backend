import * as React from "react";
import I18n from "i18n-js";
import FadeIn from "react-fade-in";
import { Form, Button } from "react-bootstrap";
import { Formik } from "formik";
import Typography from "@material-ui/core/Typography";
import Slider from "@material-ui/core/Slider";

import DisplayErrors from "../components/DisplayErrors";
import Http from "../../diagram/engine/http";
import store from "../../diagram/engine/reducers/store";
import { finalDiagnosticSchema } from "../constants/schema";
import { closeModal } from "../../diagram/engine/reducers/creators.actions";
import { createNode } from "../../diagram/helpers/nodeHelpers";
import MediaForm from "../MediaForm/mediaForm";


export default class FinalDiagnosticForm extends React.Component {

  state = {
    toDeleteMedias: [],
  };

  /**
   * Suppress entry in media
   * @param id
   * @returns {Promise<void>}
   */
  setDeletedMedia = async (id) => {
    const { toDeleteMedias } = this.state;
    toDeleteMedias.push(id);
    this.setState({toDeleteMedias})
  };

  /**
   * Create or update value in database + update diagram if we're editing from diagram
   * @params [Object] values
   * @params [Object] actions
   */
  handleOnSubmit = async (values, actions) => {
    const { method, from, engine, diagramObject, addAvailableNode } = this.props;
    const { toDeleteMedias } = this.state
    let http = new Http();
    let httpRequest = {};

    if (method === "create") {
      httpRequest = await http.createFinalDiagnostic(values.label_translations, values.description_translations, values.medias_attributes, from);
    } else {
      if (toDeleteMedias.length > 0) {
        toDeleteMedias.map(media_id => {
          values.medias_attributes.push({id: media_id, _destroy: true});
        });
      }
      httpRequest = await http.updateFinalDiagnostic(values.id, values.label_translations, values.description_translations, values.medias_attributes, from);
    }

    let result = await httpRequest.json();

    if (httpRequest.status === 200) {
      if (from === "rails") {
        window.location.replace(result.url);
      } else {
        if (method === "create") {
          let diagramInstance = createNode(result, addAvailableNode, false, "Diagnostic", engine);
          engine.getModel().addNode(diagramInstance);
        } else {
          diagramObject.options.dbInstance.node = result;
        }

        engine.repaintCanvas();

        store.dispatch(
          closeModal()
        );
      }
    } else {
      actions.setStatus({ result });
    }
  };

  render() {
    const { finalDiagnostic } = this.props;

    return (
      <FadeIn>
        <Formik
          validationSchema={finalDiagnosticSchema}
          initialValues={{
            id: finalDiagnostic?.id || "",
            label_translations: finalDiagnostic?.label_translations?.en || "",
            description_translations: finalDiagnostic?.description_translations?.en || "",
            medias_attributes: finalDiagnostic?.medias?.map((media) => ({
              id: media.id || "",
              url: media.url || "",
              label_en: media.label_translations?.en || "",
            })) || []
          }}
          onSubmit={(values, actions) => this.handleOnSubmit(values, actions)}
        >
          {({
              handleSubmit,
              handleChange,
              isSubmitting,
              setFieldValue,
              touched,
              values,
              errors,
              status
            }) => (
            <Form noValidate onSubmit={handleSubmit}>
              {status ? <DisplayErrors errors={status}/> : null}
              <Form.Group controlId="validationLabel">
                <Form.Label>{I18n.t("activerecord.attributes.node.label_translations")}</Form.Label>
                <Form.Control
                  name="label_translations"
                  value={values.label_translations}
                  onChange={handleChange}
                  isInvalid={touched.label_translations && !!errors.label_translations}
                />
                <Form.Control.Feedback type="invalid">
                  {errors.label_translations}
                </Form.Control.Feedback>
              </Form.Group>

              <Form.Group controlId="validationDescription">
                <Form.Label>{I18n.t("activerecord.attributes.node.description_translations")}</Form.Label>
                <Form.Control
                  name="description_translations"
                  as="textarea"
                  value={values.description_translations}
                  onChange={handleChange}
                  isInvalid={touched.description_translations && !!errors.description_translations}
                />
                <Form.Control.Feedback type="invalid">
                  {errors.description_translations}
                </Form.Control.Feedback>
              </Form.Group>

              <Form.Group>
                <MediaForm values={values} setFieldValue={setFieldValue} setDeletedMedia={this.setDeletedMedia}/>
              </Form.Group>

              <Form.Group controlId="validationDescription">
                <Form.Label>{I18n.t("activerecord.attributes.node.description_translations")}</Form.Label>
                <Form.Control
                  name="description_translations"
                  as="textarea"
                  value={values.description_translations}
                  onChange={handleChange}
                  isInvalid={touched.description_translations && !!errors.description_translations}
                />
                <Form.Control.Feedback type="invalid">
                  {errors.description_translations}
                </Form.Control.Feedback>
              </Form.Group>

              <div style={{width: 300}}>
                <Typography id="discrete-slider" gutterBottom>
                  Temperature
                </Typography>
                <Slider
                  defaultValue={5}
                  min={1}
                  max={10}
                  step={1}
                  getAriaValueText={this.valuetext}
                  aria-labelledby="discrete-slider"
                  valueLabelDisplay="auto"
                  marks
                />
              </div>

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
