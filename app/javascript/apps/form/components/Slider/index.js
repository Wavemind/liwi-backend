import * as React from "react";
import { useField } from 'formik'
import { CustomSlider } from './style'

const SliderComponent = ({...props}) => {

  const [field, meta, helpers] = useField(props);
  const {name, value} = props;

  const marks = [];
  for (let i = 1; i<=10; i++) {
    marks.push({value: i, label: i});
  }

  return(
    <CustomSlider
      min={1}
      max={10}
      step={1}
      marks={marks}
      name={name}
      value={value}
      {...field}
      onChange={(event, value) => helpers.setValue(value)}
      track={false}
    />
  );
};

export default SliderComponent;
