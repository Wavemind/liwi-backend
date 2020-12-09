import * as React from "react";
import FadeIn from "react-fade-in";
import I18n from "i18n-js";
import BarLoader from "react-spinners/BarLoader";

export default class Loader extends React.Component {

  render() {
    return (
      <FadeIn>
        <div className="row justify-content-center mt-5">
          <h2>{I18n.t("loading")}</h2>
        </div>
        <div className="row justify-content-center mt-5 mb-5">
          <BarLoader
            width={500}
            color="#1F3643"
          />
        </div>
      </FadeIn>
    );
  }
}
