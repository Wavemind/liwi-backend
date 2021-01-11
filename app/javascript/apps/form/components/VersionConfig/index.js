import React from 'react';
import DualListBox from 'react-dual-listbox';
import 'react-dual-listbox/lib/react-dual-listbox.css';

import Http from "../../../diagram/engine/http";

export default class VersionConfig extends React.Component {

  constructor(props) {
    super(props);

    const { selected_medical_case_questions, selected_patient_questions, questions, disabled } = props;

    this.state = {
      http: new Http(),
      selected_medical_case_questions: selected_medical_case_questions,
      selected_patient_questions: selected_patient_questions,
      questions: questions,
      disabled: disabled
    };
  }

  onChange = (list, nextSelected) => {
    const { http } = this.state;

    http.updateVersionList(list, nextSelected);

    if (list === 'patient') {
      this.setState({selected_patient_questions: nextSelected})
    } else {
      this.setState({selected_medical_case_questions: nextSelected})
    }
  };


  render() {
    const { selected_medical_case_questions, selected_patient_questions, questions, disabled } = this.state;

    return (
      <>
        <DualListBox
          options={questions}
          selected={selected_medical_case_questions}
          showHeaderLabels={true}
          onChange={(nextSelected) => this.onChange('medical_case', nextSelected)}
          disabled={disabled}
          preserveSelectOrder={true}
          showOrderButtons={true}
          lang={{
            availableHeader: 'Available questions',
            selectedHeader: 'Fields to show in the list of consultations'
          }}
          icons={{
            moveLeft: <span className="fa fa-chevron-left" />,
            moveAllLeft: [
              <span key={0} className="fa fa-chevron-left" />,
              <span key={1} className="fa fa-chevron-left" />,
            ],
            moveRight: <span className="fa fa-chevron-right" />,
            moveAllRight: [
              <span key={0} className="fa fa-chevron-right" />,
              <span key={1} className="fa fa-chevron-right" />,
            ],
            moveDown: <span className="fa fa-chevron-down" />,
            moveUp: <span className="fa fa-chevron-up" />,
          }}
        />

        <DualListBox
          options={questions}
          selected={selected_patient_questions}
          showHeaderLabels={true}
          onChange={(nextSelected) => this.onChange('patient', nextSelected)}
          disabled={disabled}
          preserveSelectOrder={true}
          showOrderButtons={true}
          lang={{
            availableHeader: 'Available questions',
            selectedHeader: 'Fields to show in the list of patients'
          }}
          icons={{
            moveLeft: <span className="fa fa-chevron-left" />,
            moveAllLeft: [
              <span key={0} className="fa fa-chevron-left" />,
              <span key={1} className="fa fa-chevron-left" />,
            ],
            moveRight: <span className="fa fa-chevron-right" />,
            moveAllRight: [
              <span key={0} className="fa fa-chevron-right" />,
              <span key={1} className="fa fa-chevron-right" />,
            ],
            moveDown: <span className="fa fa-chevron-down" />,
            moveUp: <span className="fa fa-chevron-up" />,
          }}
        />
      </>
    );
  }
}
