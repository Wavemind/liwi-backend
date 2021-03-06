import * as React from "react";
import I18n from "i18n-js";
import FadeIn from "react-fade-in";
import {Form, Col, Button} from "react-bootstrap";
import { getStudyLanguage } from "../../utils";

export default class MediaFields extends React.Component {

  constructor(props) {
    super(props);

    this.state = {
      language: getStudyLanguage()
    };
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

  /**
   * Save file in global form
   * @param fileEvent
   */
  handleFile = (fileEvent) => {
    const {setFieldValue, index} = this.props;
    const reader = new FileReader();
    const file = fileEvent.files[0];

    if (file) {
      reader.readAsDataURL(file);
      reader.onload = (e) => {
        setFieldValue(`medias_attributes.${index}.url`, e.target.result);
        setFieldValue(`medias_attributes.${index}.filename`, file.name);
      };
    }
  };

  render() {
    const {
      arrayHelpers: {
        form: {
          handleChange,
          values
        }
      },
      index,
    } = this.props;

    const media = values.medias_attributes[index];
    const { language } = this.state;

    return (
      <FadeIn>
        <Form.Row>
          <Form.Group as={Col} controlId="validationLabelTranslations">
            <Form.Label>{I18n.t("activerecord.attributes.media.label_translations")}</Form.Label>
            <Form.Control
              name={`medias_attributes.${index}.label_${language}`}
              value={media[`label_${language}`]}
              onChange={handleChange}
              isInvalid={this.isInvalid(`label_${language}`)}>
            </Form.Control>
            <Form.Control.Feedback type="invalid">
              {this.displayErrors(`label_${language}`)}
            </Form.Control.Feedback>
          </Form.Group>

          <Form.Group as={Col} controlId="validationUrl">
            <Form.Label>{I18n.t("activerecord.attributes.media.url")}</Form.Label>
            <Form.Control
              type="file"
              name={`medias_attributes.${index}.url`}
              onChange={(e) => this.handleFile(e.target)}
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
