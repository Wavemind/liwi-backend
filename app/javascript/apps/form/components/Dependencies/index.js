import * as React from "react";
import FadeIn from "react-fade-in";
import I18n from "i18n-js";
import humanizeString from "humanize-string";

export default class Dependencies extends React.Component {

  render() {
    const { dependenciesHash } = this.props;

    console.log(dependenciesHash)
    return (
      <div className="justify-content-center">
        <div>
          <div className="alert alert-danger warning_dependencies" role="alert">
            {I18n.t("warning_dependency")}
            {Object.keys(dependenciesHash).map(key => (
              <>
                <h5>{ dependenciesHash[key]['title'] }</h5>
                <ul>
                  {dependenciesHash[key]['dependencies'].map((dependence) => (
                    <a target="_blank" href={dependence['url']}><li><b>{dependence['label']}</b></li></a>
                  ))}
                </ul>
              </>
            ))}
          </div>
        </div>
      </div>
    );
  }
}
