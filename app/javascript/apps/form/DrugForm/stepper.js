import * as React from "react";

import Http from "../../diagram/engine/http";
import DrugForm from "./drugForm";
import FormulationForm from "./formulationForm";
import DisplayErrors from "../components/DisplayErrors";

export default class StepperDrugForm extends React.Component {

  constructor(props) {
    super(props);
    const { drug, method } = props;

    this.state = {
      errors: null,
      step: 1,
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
      formulations_attributes: drug?.formulations ||  []
    };

    if (method === "update") {
      body['id'] = drug.id
    }
    return body;
  };

  /**
   * Send value to server
   */
  save = async () => {
    const { method, from, diagramObject } = this.props;
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
          this.setState({step: 3, createdDrug: result.drug})
        } else {
          diagramObject.options.dbInstance.node = result;
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
    const { method, engine, diagramObject, addAvailableNode } = this.props;

    switch (step) {
      case 1:
        return (
          <DrugForm
            formData={drug}
            setFormData={this.setMetaData}
            nextStep={this.nextStep}
          />
        );
      case 2:
        return (
          <>
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
        <FormulationForm
          engine={engine}
          diagramObject={diagramObject}
          addAvailableNode={addAvailableNode}
          method={method}
          drug={createdDrug}
        />
      );
      default:
        return "boom boom";
    }
  }
}
