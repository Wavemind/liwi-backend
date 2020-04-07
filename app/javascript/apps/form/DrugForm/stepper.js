import * as React from "react";
import I18n from "i18n-js";

import Http from "../../diagram/engine/http";
import DrugForm from "./drugForm";
import FormulationForm from "./formulationForm";
import InstanceForm from "./instanceForm";
import DisplayErrors from "../components/DisplayErrors";
import store from "../../diagram/engine/reducers/store";
import { closeModal } from "../../diagram/engine/reducers/creators.actions";

export default class StepperDrugForm extends React.Component {

  constructor(props) {
    super(props);
    const { drug, method } = props;

    this.state = {
      errors: null,
      step: 2,
      drug: this.drugBody(drug, method),
      createdDrug: {}
    };
  }

  /**
   * Define state body for drug. State change if we're in create or update method
   * @params [Object] drug
   * @params [String] method
   * @return [Object] drug object for state
   */
  drugBody = (drug, method) => {
    let body = {
      label_en: drug?.label_translations?.en || "",
      description_en: drug?.description_translations?.en || "",
      is_anti_malarial: drug?.is_anti_malarial || false,
      is_antibiotic: drug?.is_antibiotic || "",
      formulations_attributes: drug?.formulations || []
    };

    if (method === "update") {
      body["id"] = drug.id;
    }
    return body;
  };

  /**
   * Send value to server
   */
  save = async () => {
    const { method, from, diagramObject, engine } = this.props;
    const { drug } = this.state;
    let http = new Http();
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

          store.dispatch(
            closeModal()
          );
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
  setMetaData = (values) => {
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
    const { method, engine, diagramObject, addAvailableNode, from } = this.props;

    switch (step) {
      case 1:
        return (
          <>
            <h1 className="mb-5">{method === "create" ? I18n.t("drugs.new.title") : I18n.t("drugs.edit.title")}</h1>
            <DrugForm
              formData={drug}
              setFormData={this.setMetaData}
              nextStep={this.nextStep}
            />
          </>
        );
      case 2:
        return (
          <>
            <h1 className="mb-5">{method === "create" ? I18n.t("formulations.new.title") : I18n.t("formulations.edit.title")}</h1>
            {errors ? <DisplayErrors errors={errors}/> : null}
            <FormulationForm
              formData={drug}
              method={method}
              save={this.save}
              setFormData={this.setFormulationData}
              previousStep={this.previousStep}
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
