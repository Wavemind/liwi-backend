import * as React from "react";
import FadeIn from "react-fade-in";
import I18n from "i18n-js";

export default class Loader extends React.Component {

  render() {
    return (
      <FadeIn>
        <span>{I18n.t("loading")}</span>
      </FadeIn>
    );
  }
}
