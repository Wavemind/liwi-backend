import * as React from "react";
import I18n from "i18n-js";
import FadeIn from "react-fade-in";
import { Form, Col } from "react-bootstrap";

export default class MediaFields extends React.Component {

  constructor(props) {
    super(props);
  }

  /**
   * Display label error
   * @params [String] input
   * @return [String] label
   */
  displayErrors(input) {
    const {
      index, arrayHelpers: { form: { errors } }
    } = this.props;

    return errors?.medias_attributes !== undefined && errors?.medias_attributes[index]?.[input];
  }

  /**
   * Test if input has an error
   * @params [String] input
   * @return [Boolean] error ?
   */
  isInvalid(input) {
    const {
      index, arrayHelpers: { form: { errors } }
    } = this.props;

    return errors?.medias_attributes !== undefined && !!errors?.medias_attributes[index]?.[input];
  }

  render() {
    const {
      arrayHelpers: {
        form: {
          handleChange,
          values
        }
      },
      index,
      setFieldValue
    } = this.props;

    let media = values.medias_attributes[index];

    return (
      <FadeIn>
        <Form.Row>
          <Form.Group as={Col} controlId="validationLabelTranslations">
            <Form.Label>{I18n.t("activerecord.attributes.media.label_translations")}</Form.Label>
            <Form.Control
              name={`medias_attributes.${index}.label_en`}
              value={media.label_en}
              onChange={handleChange}
              isInvalid={this.isInvalid("label_en")}>
            </Form.Control>
            <Form.Control.Feedback type="invalid">
              {this.displayErrors("label_en")}
            </Form.Control.Feedback>
          </Form.Group>

          <Form.Group as={Col} controlId="validationUrl">
            <Form.Label>{I18n.t("activerecord.attributes.media.url")}</Form.Label>
            <Form.Control
              type="file"
              name={`medias_attributes.${index}.url`}
              onChange={e => {

                let reader = new FileReader();
                let file = e.target.files[0];
                reader.readAsDataURL(file);
                if (file) {
                  reader.onload = (e) => {
                    this.props.setFieldValue(`medias_attributes.${index}.url`, e.target.result);
                    this.props.setFieldValue(`medias_attributes.${index}.filename`, file.name);
                  };
                }
              }}
              isInvalid={this.isInvalid("url")}>
            </Form.Control>
            <Form.Control.Feedback type="invalid">
              {this.displayErrors("url")}
            </Form.Control.Feedback>
          </Form.Group>
        </Form.Row>
      </FadeIn>
    );
  }
}
