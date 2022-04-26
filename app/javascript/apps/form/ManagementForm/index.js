import * as React from "react";
import I18n from "i18n-js";
import FadeIn from "react-fade-in";
import { Form, Button } from "react-bootstrap";
import { Formik } from "formik";

import DisplayErrors from "../components/DisplayErrors";
import Http from "../../diagram/engine/http";
import store from "../../diagram/engine/reducers/store";
import { managementSchema } from "../constants/schema";
import { closeModal } from "../../diagram/engine/reducers/creators.actions";
import { createNode } from "../../diagram/helpers/nodeHelpers";
import MediaForm from "../MediaForm/mediaForm";
import SliderComponent from "../components/Slider";
import Autocomplete from "../QuestionsSequenceForm";
import {getStudyLanguage, getTranslatedText} from "../../utils";
import Dependencies from "../components/Dependencies";

export default class ManagementForm extends React.Component {

  constructor(props) {
    super(props);

    this.state = {
      toDeleteMedias: [],
      language: getStudyLanguage(),
      deployedMode: props.method === "update" && props.is_deployed,
    };
  }

  /**
   * Suppress entry in media
   * @param id
   * @returns {Promise<void>}
   */
  setDeletedMedia = async id => {
    const { toDeleteMedias } = this.state;
    toDeleteMedias.push(id);
    this.setState({ toDeleteMedias });
  };

  /**
   * Create or update value in database + update diagram if we're editting from diagram
   * @params [Object] values
   * @params [Object] actions
   */
  handleOnSubmit = async (values, actions) => {
    const {
      method,
      from,
      engine,
      diagramObject,
      addAvailableNode
    } = this.props;
    const { toDeleteMedias } = this.state;
    let http = new Http();
    let httpRequest = {};

    if (method === "create") {
      httpRequest = await http.createManagement(
        values.label_translations,
        values.description_translations,
        values.level_of_urgency,
        values.is_referral,
        values.medias_attributes,
        from
      );
    } else {
      if (toDeleteMedias.length > 0) {
        toDeleteMedias.map(media_id => {
          values.medias_attributes.push({ id: media_id, _destroy: true });
        });
      }
      httpRequest = await http.updateManagement(
        values.id,
        values.label_translations,
        values.description_translations,
        values.level_of_urgency,
        values.is_referral,
        values.medias_attributes,
        from
      );
    }

    let result = await httpRequest.json();

    if (httpRequest.status === 200) {
      if (from === "rails") {
        window.location.replace(result.url);
      } else {
        if (method === "create") {
          let diagramInstance = createNode(
            result,
            addAvailableNode,
            false,
            result.node.category_name,
            engine
          );
          engine.getModel().addNode(diagramInstance);
        } else {
          diagramObject.options.dbInstance.node = result;
        }

        engine.repaintCanvas();

        store.dispatch(closeModal());
      }
    } else {
      actions.setStatus({ result });
    }
  };

  render() {
    const { management, is_deployed, method, from } = this.props;
    const { language, deployedMode } = this.state;
    const initialValues = {
      id: management?.id || "",
      label_translations: getTranslatedText(management?.label_translations, language),
      description_translations: getTranslatedText(management?.description_translations, language),
      level_of_urgency: management?.level_of_urgency || 5,
      is_referral: management?.is_referral || false,
      medias_attributes: []
    };

    management?.medias?.forEach(media => {
      const body = {
        id: media.id || "",
        url: media.url || "",
      };

      body[`label_${language}`] = getTranslatedText( media.label_translations, language);
      initialValues["medias_attributes"].push(body);
    });

    return (
      <FadeIn>
        {(method === 'update' && from !== 'rails') && <Dependencies dependenciesHash={management.dependencies_by_version}/>}
        <Formik
          validationSchema={managementSchema}
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
              {status ? <DisplayErrors errors={status} /> : null}
              <Form.Group controlId="validationLabel">
                <Form.Label>
                  {I18n.t("activerecord.attributes.node.label_translations")}
                </Form.Label>
                <Form.Control
                  name="label_translations"
                  value={values.label_translations}
                  onChange={handleChange}
                  disabled={deployedMode}
                  isInvalid={
                    touched.label_translations && !!errors.label_translations
                  }
                />
                <Form.Control.Feedback type="invalid">
                  {errors.label_translations}
                </Form.Control.Feedback>
              </Form.Group>

              <Form.Group controlId="validationIsReferral">
                <Form.Check
                  name="is_referral"
                  label={I18n.t("activerecord.attributes.node.is_referral")}
                  value={values.is_referral}
                  checked={values.is_referral}
                  onChange={handleChange}
                  disabled={deployedMode}
                  isInvalid={touched.is_referral && !!errors.is_referral}
                />
                <Form.Control.Feedback type="invalid">
                  {errors.is_referral}
                </Form.Control.Feedback>
              </Form.Group>

              <Form.Group controlId="validationDescription">
                <Form.Label>
                  {I18n.t(
                    "activerecord.attributes.node.description_translations"
                  )}
                </Form.Label>
                <Form.Control
                  name="description_translations"
                  as="textarea"
                  value={values.description_translations}
                  onChange={handleChange}
                  disabled={deployedMode}
                  isInvalid={
                    touched.description_translations &&
                    !!errors.description_translations
                  }
                />
                <Form.Control.Feedback type="invalid">
                  {errors.description_translations}
                </Form.Control.Feedback>
              </Form.Group>

              <Form.Group controlId="validationLevelOfUrgency">
                <Form.Label>
                  {I18n.t("activerecord.attributes.node.level_of_urgency")}
                </Form.Label>
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
                <MediaForm
                  values={values}
                  setFieldValue={setFieldValue}
                  setDeletedMedia={this.setDeletedMedia}
                />
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
