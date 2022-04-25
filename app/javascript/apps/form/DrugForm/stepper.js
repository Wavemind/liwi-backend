import * as React from "react";
import I18n from "i18n-js";

import Http from "../../diagram/engine/http";
import DrugForm from "./drugForm";
import FormulationForm from "./formulationForm";
import InstanceForm from "./instanceForm";
import DisplayErrors from "../components/DisplayErrors";
import store from "../../diagram/engine/reducers/store";
import { closeModal } from "../../diagram/engine/reducers/creators.actions";
import {getTranslatedText, getStudyLanguage} from "../../utils";

export default class StepperDrugForm extends React.Component {
  constructor(props) {
    super(props);
    const { drug, method, step } = props;

    this.state = {
      errors: null,
      step: step || 1,
      drug: this.drugBody(drug, method),
      createdDrug: drug || {},
    };
  }

  /**
   * Define state body for drug. State change if we're in create or update method
   * @params [Object] drug
   * @params [String] method
   * @return [Object] drug object for state
   */
  drugBody = (drug, method) => {
    const language = getStudyLanguage();

    const body = {
      level_of_urgency: drug?.level_of_urgency || 5,
      is_anti_malarial: drug?.is_anti_malarial || false,
      is_antibiotic: drug?.is_antibiotic || "",
      is_neonat: drug?.is_neonat || "",
      formulations_attributes: drug?.formulations || []
    };
    body[`label_${language}`] = getTranslatedText(drug?.label_translations, language);
    body[`description_${language}`] = getTranslatedText(drug?.description_translations, language);

    if (method === "update") {
      body["id"] = drug.id;
      body["formulations_attributes"] = [];

      // Generate hash cause of label_translation
      drug.formulations.map(formulation => {
        const formulationBody = {
          id: formulation.id,
          administration_route_id: formulation.administration_route_id,
          minimal_dose_per_kg: formulation.minimal_dose_per_kg,
          maximal_dose_per_kg: formulation.maximal_dose_per_kg,
          maximal_dose: formulation.maximal_dose,
          medication_form: formulation.medication_form,
          dose_form: formulation.dose_form,
          liquid_concentration: formulation.liquid_concentration,
          doses_per_day: formulation.doses_per_day,
          unique_dose: formulation.unique_dose,
          by_age: formulation.by_age,
          breakable: formulation.breakable,
          _destroy: false
        };
        formulationBody[`description_${language}`] = getTranslatedText(formulation?.description_translations, language);
        formulationBody[`injection_instructions_${language}`] = getTranslatedText(formulation?.injection_instructions_translations, language);
        formulationBody[`dispensing_description_${language}`] = getTranslatedText(formulation?.dispensing_description_translations, language);
        body["formulations_attributes"].push(formulationBody);
      });
    } else {
      body["answers_attributes"] = [];
    }
    return body;
  };

  /**
   * Send value to server
   */
  save = async toDeleteFormulations => {
    const { method, from, diagramObject, engine } = this.props;
    const { drug } = this.state;
    toDeleteFormulations.map(formulation_id => {
      const formulation = drug.formulations_attributes[0];
      formulation.id = formulation_id;
      formulation._destroy = true;
      drug.formulations_attributes.push(formulation);
    });
    const http = new Http();
    let httpRequest = {};

    if (method === "create") {
      httpRequest = await http.createDrug(drug, from);
    } else {
      httpRequest = await http.updateDrug(drug, from);
    }

    let result = await httpRequest.json();

    if (httpRequest.status === 200) {
      if (from === "rails") {
        window.location.replace(result.url);
      } else {
        if (method === "create") {
          this.setState({ step: 3, createdDrug: result });
        } else {
          diagramObject.options.dbInstance.node = result;
          engine.repaintCanvas();

          store.dispatch(closeModal());
        }
      }
    } else {
      this.setState({ errors: result });
    }
  };

  /**
   * Set value in context for formulations
   * @param prop
   * @param value
   */
  setFormulationData = (prop, value) => {
    this.setState({ drug: { ...this.state.drug, [prop]: value } });
  };

  /**
   * Set value in context for meta data
   * @param values
   */
  setMetaData = values => {
    this.setState({ drug: values });
  };

  /**
   * Set step to next
   */
  nextStep = () => {
    const { step } = this.state;
    this.setState({ step: step + 1 });
  };

  /**
   * Set step to previous
   */
  previousStep = () => {
    const { step } = this.state;
    this.setState({ step: step - 1 });
  };

  render() {
    const { errors, step, drug, createdDrug } = this.state;
    const {
      method,
      engine,
      diagramObject,
      addAvailableNode,
      from,
      is_deployed
    } = this.props;

    switch (step) {
      case 1:
        return (
          <>
            <h1 className="mb-5">
              {method === "create"
                ? I18n.t("drugs.new.title")
                : I18n.t("drugs.edit.title")}
            </h1>
            <DrugForm
              formData={drug}
              setFormData={this.setMetaData}
              nextStep={this.nextStep}
              save={this.save}
              method={method}
              from={from}
              diagramObject={diagramObject}
              is_deployed={is_deployed}
            />
          </>
        );
      case 2:
        return (
          <>
            <h1 className="mb-5">
              {method === "create"
                ? I18n.t("formulations.new.title")
                : I18n.t("formulations.edit.title")}
            </h1>
            {errors ? <DisplayErrors errors={errors} /> : null}
            <FormulationForm
              formData={drug}
              method={method}
              save={this.save}
              setFormData={this.setFormulationData}
              previousStep={this.previousStep}
              is_deployed={is_deployed}
            />
          </>
        );
      case 3:
        return (
          <InstanceForm
            engine={engine}
            diagramObject={diagramObject}
            addAvailableNode={addAvailableNode}
            method={method}
            drug={createdDrug}
            positions={{ x: 100, y: 100 }}
            from={from}
          />
        );
      default:
        return <h1>{I18n.t("something_went_wrong")}</h1>;
    }
  }
}
