import {withStyles} from "@material-ui/core/styles";
import Slider from "@material-ui/core/Slider";

export const LiwiSlider = withStyles({
  rail: {
    backgroundImage: "linear-gradient(90deg, rgba(5,217,40,1) 0%, rgba(224,224,4,1) 50%, rgba(215,0,0,1) 100%)",
    height: 8,
    opacity: 0.8,
  },
  mark: {
    height: 8
  },
  markLabel: {
    marginTop: "5px",
  },
  thumb: {
    color: "white",
    height: 20,
    width: 20,
    marginTop: -6,
    marginLeft: -10,
    boxShadow: '0 3px 1px rgba(0,0,0,0.1),0 4px 8px rgba(0,0,0,0.13),0 0 0 1px rgba(0,0,0,0.02)',
    border: '1px solid lightgrey',
    '&:focus,&:hover,&:active': {
      boxShadow: '0 3px 1px rgba(0,0,0,0.1),0 4px 8px rgba(0,0,0,0.3),0 0 0 1px rgba(0,0,0,0.02)',
    },
  }
})(Slider);
