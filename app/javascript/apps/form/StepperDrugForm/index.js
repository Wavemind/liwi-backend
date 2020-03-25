import * as React from "react";

import Http from "../../diagram/engine/http";
import store from "../../diagram/engine/reducers/store";
import { closeModal } from "../../diagram/engine/reducers/creators.actions";
import { createNode } from "../../diagram/helpers/nodeHelpers";
import DrugForm from "../DrugForm";
import FormulationForm from "../FormulationForm";

export default class StepperDrugForm extends React.Component {

  constructor(props) {
    super(props);

    const {drug} = props;

    this.state = {
      step: 1,
      drug: {
        id: drug?.id || "",
        label_translations: drug?.label_translations?.en || "",
      }
    };
  }

  /**
   * Set value in context
   * @param prop
   * @param value
   */
  setFormData = (prop, value) => {
    this.setState({ drug: {[prop]: value }});
  };

  nextStep = () => {
    const {step} = this.state;
    this.setState({step: step + 1})
  };

  previousStep = () => {
    const {step} = this.state;
    this.setState({step: step - 1})
  };

  render() {
    const {step, drug} = this.state;
console.log(step);
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
