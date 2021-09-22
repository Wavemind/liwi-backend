import "core-js/stable";
import "…/src/jets/crud";
import "regenerator-runtime/runtime";
import I18n from "i18n-js";

// I18n.translations = <%= I18n::JS.translations.to_json %>;

let componentRequireContext = require.context("apps", true);
let ReactRailsUJS = require("react_ujs");
ReactRailsUJS.useContext(componentRequireContext);
