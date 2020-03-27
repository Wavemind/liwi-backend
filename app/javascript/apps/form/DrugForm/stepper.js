import * as React from "react";

import Http from "../../diagram/engine/http";
import store from "../../diagram/engine/reducers/store";
import { closeModal } from "../../diagram/engine/reducers/creators.actions";
import { createNode } from "../../diagram/helpers/nodeHelpers";
import DrugForm from "./drugForm";
import FormulationForm from "./formulationForm";

export default class StepperDrugForm extends React.Component {

  constructor(props) {
    super(props);

    const { drug } = props;

    this.state = {
      step: 2,
      drug: {
        id: drug?.id || "",
        label_translations: drug?.label_translations?.en || "",
        description_translations: drug?.description_translations?.en || "",
        formulations: drug?.formulations ||  []
      }
    };
  }

  /**
   * Set value in context
   * @param prop
   * @param value
   */
  setFormData = (prop, value) => {
    this.setState({ drug: { ...this.state.drug, [prop]: value } });
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
    const { step, drug } = this.state;
    const { method } = this.props;

    switch (step) {
      case 1:
        return (
          <DrugForm
            formData={drug}
            setFormData={this.setFormData}
            nextStep={this.nextStep}
          />
        );
      case 2:
        return (
          <FormulationForm
            formData={drug}
            method={method}
            setFormData={this.setFormData}
            nextStep={this.nextStep}
            previousStep={this.previousStep}
          />
        );
      default:
        return "boom boom";
    }
  }
}
