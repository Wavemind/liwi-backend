import * as React from "react";
import I18n from "i18n-js";
import { FieldArray } from "formik";
import { Form, Button, Col } from "react-bootstrap";

import { DEFAULT_MEDIA_VALUE } from "../constants/constants";
import MediaFields from "./mediaFields";


export default class MediaForm extends React.Component {

  state = {
    toDeleteMedias: []
  };

  /**
   * Add media in media array of formik "values" variable
   * @params [Object] arrayHelpers
   */
  addMedia = (arrayHelpers) => {
    arrayHelpers.push(JSON.parse(DEFAULT_MEDIA_VALUE));
  };

  /**
   * Remove media from view and store the id in another array for deletion from DB
   * @param key
   * @param arrayHelpers
   * @param values
   */
  removeMedia = (key, arrayHelpers, values) => {
    // Workaround to delete properly medias in rails TODO : Find a better solution to do it
    let { setDeletedMedia } = this.props;
    if (values.medias_attributes[key].id !== undefined) {
      setDeletedMedia(values.medias_attributes[key].id);
    }
    arrayHelpers.remove(key);
  };

  render() {
    const { values, setFieldValue } = this.props;

    return (
      <FieldArray
        name="medias_attributes"
        render={arrayHelpers => (
          <>
            {values.medias_attributes.map((answer, key) => (
              <Form.Row key={key}>
                <Col lg="9">
                  <MediaFields
                    setFieldValue={setFieldValue}
                    arrayHelpers={arrayHelpers}
                    index={key}
                  />
                </Col>
                <Col className="align-self-center">
                  {values.medias_attributes[key].url.url !== undefined ? (
                    <Button className="float-right" variant="link" href={values.medias_attributes[key].url.url}>{I18n.t("questions.medias.current_file")}</Button>
                  ) : null }
                </Col>
                <Col className="align-self-center">
                  <Button
                    className="float-right"
                    variant="danger"
                    onClick={(() => this.removeMedia(key, arrayHelpers, values))}
                  >
                    {I18n.t("remove")}
                  </Button>
                </Col>
              </Form.Row>
            ))}
            <Form.Row className="mt-5">
              <Button className="btn-block" type="button" variant="success"
                      onClick={() => this.addMedia(arrayHelpers)}>
                {I18n.t("add_file")}
              </Button>
            </Form.Row>
          </>
        )}
      />
    );
  }
}
