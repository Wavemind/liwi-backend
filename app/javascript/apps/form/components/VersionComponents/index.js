import React from 'react';
import DualListBox from 'react-dual-listbox';
import 'react-dual-listbox/lib/react-dual-listbox.css';

import Http from "../../../diagram/engine/http";

export default class VersionComponents extends React.Component {

  constructor(props) {
    super(props);

    const { selected, questions, disabled } = props;

    this.state = {
      http: new Http(),
      selected: selected,
      questions: questions,
      disabled: disabled
    };
  }


  onChange = (nextSelected) => {
    const { http, selected } = this.state;
    if (selected.length > nextSelected.length) {
      http.removeVersionInstances(selected.filter(x => !nextSelected.includes(x)));
    } else {
      http.createVersionInstance(nextSelected.filter(x => !selected.includes(x)));
    }

    this.setState({selected: nextSelected})
  };


  render() {
    const { selected, questions, disabled } = this.state;

    return (
      <DualListBox
        options={questions}
        selected={selected}
        showHeaderLabels={true}
        onChange={this.onChange}
        disabled={disabled}
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
        }}
      />
    );
  }
}
