import * as React from 'react';
import { makeStyles } from '@material-ui/core/styles';
import Typography from '@material-ui/core/Typography';
import Slider from '@material-ui/core/Slider';

export default class Slider extends React.Component {

  const useStyles = makeStyles({
    root: {
      width: 300,
    },
  });

  valuetext = (value) => {
    return `${value}°C`;
  }

  classes = useStyles();

  render() {
    return (
      <div className={this.classes.root}>
        <Typography id="discrete-slider" gutterBottom>
          Temperature
        </Typography>
        <Slider
          defaultValue={30}
          getAriaValueText={this.valuetext}
          aria-labelledby="discrete-slider"
          valueLabelDisplay="auto"
          step={10}
          marks
          min={10}
          max={110}
        />
      </div>
    );
  }
}
