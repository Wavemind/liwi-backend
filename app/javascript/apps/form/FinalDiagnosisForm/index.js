import * as React from "react";
import I18n from "i18n-js";
import FadeIn from "react-fade-in";
import { Form, Button } from "react-bootstrap";
import { Formik } from "formik";

import DisplayErrors from "../components/DisplayErrors";
import Http from "../../diagram/engine/http";
import store from "../../diagram/engine/reducers/store";
import { finalDiagnosesSchema } from "../constants/schema";
import { closeModal } from "../../diagram/engine/reducers/creators.actions";
import { createNode } from "../../diagram/helpers/nodeHelpers";
import MediaForm from "../MediaForm/mediaForm";
import SliderComponent from "../components/Slider";
import Autocomplete from "../QuestionsSequenceForm";
import {getStudyLanguage, getTranslatedText} from "../../utils";

export default class FinalDiagnosisForm extends React.Component {

  state = {
    toDeleteMedias: [],
    language: getStudyLanguage()
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
    const { method, from, engine, diagramObject, addAvailableNode, source } = this.props;
    const { toDeleteMedias } = this.state;
    let http = new Http();
    let httpRequest = {};

    if (method === "create") {
      httpRequest = await http.createFinalDiagnosis(values.label_translations, values.description_translations, values.level_of_urgency, values.medias_attributes, from);
    } else {
      if (toDeleteMedias.length > 0) {
        toDeleteMedias.forEach(media_id => {
          values.medias_attributes.push({id: media_id, _destroy: true});
        });
      }
      httpRequest = await http.updateFinalDiagnosis(values.id, values.label_translations, values.description_translations, values.level_of_urgency, values.medias_attributes, from, source);
    }

    let result = await httpRequest.json();

    if (httpRequest.status === 200) {
      if (from === "rails") {
        window.location.replace(result.url);
      } else {
        if (method === "create") {
          let diagramInstance = createNode(result, addAvailableNode, false, "Diagnosis", engine);
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
    const { finalDiagnosis } = this.props;
    const { language } = this.state;


    getTranslatedText(finalDiagnosis?.label_translations, language);
    const initialValues = {
      id: finalDiagnosis?.id || "",
      label_translations: getTranslatedText(finalDiagnosis?.label_translations, language),
      description_translations: getTranslatedText(finalDiagnosis?.description_translations, language),
      level_of_urgency: finalDiagnosis?.level_of_urgency || 5,
      medias_attributes: []
    };
    finalDiagnosis?.medias?.forEach(media => {
      const mediaVals = {
        id: media.id || "",
        url: media.url || "",
      };
      mediaVals[`label_${language}`] = getTranslatedText(media?.label_translations, language);
      initialValues['medias_attributes'].push(mediaVals)
    });

    return (
      <FadeIn>
        <Formik
          validationSchema={finalDiagnosesSchema}
          initialValues={initialValues}
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
                  disabled={deployedMode}
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
                  disabled={deployedMode}
                  isInvalid={touched.description_translations && !!errors.description_translations}
                />
                <Form.Control.Feedback type="invalid">
                  {errors.description_translations}
                </Form.Control.Feedback>
              </Form.Group>

              <Form.Group controlId="validationLevelOfUrgency">
                <Form.Label>{I18n.t("activerecord.attributes.node.level_of_urgency")}</Form.Label>
                <Form.Control
                  name="level_of_urgency"
                  as={SliderComponent}
                  value={values.level_of_urgency}
                  onChange={handleChange}
                />
                <Form.Control.Feedback type="invalid">
                  {errors.level_of_urgency}
                </Form.Control.Feedback>
              </Form.Group>

              <Form.Group>
                <MediaForm values={values} setFieldValue={setFieldValue} setDeletedMedia={this.setDeletedMedia}/>
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
