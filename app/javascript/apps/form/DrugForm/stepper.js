import * as React from "react";

import Http from "../../diagram/engine/http";
import store from "../../diagram/engine/reducers/store";
import { closeModal } from "../../diagram/engine/reducers/creators.actions";
import { createNode } from "../../diagram/helpers/nodeHelpers";
import DrugForm from "./drugForm";
import FormulationForm from "./formulationForm";
import DisplayErrors from "../components/DisplayErrors";

export default class StepperDrugForm extends React.Component {

  constructor(props) {
    super(props);

    const { drug } = props;

    this.state = {
      errors: null,
      step: 1,
      drug: {
        id: drug?.id || "",
        label_en: drug?.label_translations?.en || "",
        description_en: drug?.description_translations?.en || "",
        formulations_attributes: drug?.formulations ||  []
      }
    };
  }

  /**
   * Send value to server
   */
  save = async () => {
    const { method, from, engine, diagramObject, addAvailableNode } = this.props;
    const { drug } = this.state;
    let http = new Http();
    let httpRequest = {};
console.log(drug);
    if (method === "create") {
      httpRequest = await http.createDrug(drug, from);
    } else {
      // httpRequest = await http.updateFinalDiagnostic(values.id, values.label_translations, values.description_translations, from);
    }

    let result = await httpRequest.json();

    if (httpRequest.status === 200) {
      if (from === "rails") {
        window.location.replace(result.url);
      } else {
        if (method === "create") {
          let diagramInstance = createNode(result, addAvailableNode, false, "Diagnostic", engine);
          engine.getModel().addNode(diagramInstance);
        } else {
          diagramObject.options.dbInstance.node = result;
        }

        engine.repaintCanvas();

        store.dispatch(
          closeModal()
        );
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
    const { errors, step, drug } = this.state;
    const { method } = this.props;

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
      default:
        return "boom boom";
    }
  }
}
