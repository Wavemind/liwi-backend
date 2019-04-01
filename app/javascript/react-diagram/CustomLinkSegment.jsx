class CustomLinkSegment extends PureComponent<Props> {

  static defaultProps: Object = {
    show: () => {},
    hide: () => {},
  }

  path: ?any;
  circle: ?any;
  animation: any;
  progress: number;
  content: BotDetailEditFlowDiagramStepLabel;
  style: Object;

  /**
   * Create `step` link segment
   * @method constructor
   * @param props - component props
   */
  constructor(props: Object) {
    super(props);
    this.progress = props.inversed ? 100 : 0;
    this.content = this.getTooltipContent();
    this.style = this.setPathMarker(props.inversed);
  }

  /**
   * Change path style if path direction changed
   * @method componentDidUpdate
   * @param prevProps - previous props
   */
  componentDidUpdate = (prevProps: Object) => {
    if (prevProps.inversed !== this.props.inversed) {
      this.style = this.setPathMarker(this.props.inversed);
    }
  }


  /**
   * Start animation on mouse enter
   * @method onMouseEnter
   * @param e - event
   */
  onMouseEnter = (e: Object) => {
    // @flow-ignore
    const length = this.path.getTotalLength(),
      step = 4 * 100 / length; // Move 100px for 1000ms

    this.progress = this.props.inversed ? 100 : 0; // reset progress

    // Show tooltip
    this.props.show({
      origin: { x: e.clientX, y: e.clientY },
      content: this.content,
    })

    this.animation = requestAnimationFrame(() => {
      this.animateCircle(length, step)
    });
  }

  /**
   * Cancel animation on mouse leave
   * @method onMouseLeave
   */
  onMouseLeave = () => {
    this.props.hide()
    cancelAnimationFrame(this.animation);
  }

  /**
   * Direction circle animation
   * @method animateCircle
   * @param length - path length
   * @param step - animation step
   */
  animateCircle = (length: number, step: number) => {
    const {inversed} = this.props;

    if(this.path && this.circle) {
      if(inversed) {
        this.progress -= step;
        if (this.progress < 0) {
          this.progress = 100;
        }
      } else {
        this.progress += step;
        if (this.progress > 100) {
          this.progress = 0;
        }
      }

      let point = this.path.getPointAtLength(
        Number.parseInt((length * (this.progress / 100.0)).toFixed())
      );

      // @flow-ignore
      this.circle.setAttribute("cx", "" + point.x);
      // @flow-ignore
      this.circle.setAttribute("cy", "" + point.y);

      this.animation = requestAnimationFrame(() => {
        this.animateCircle(length, step);
      });
    }
  }

  /**
   * Get Source step and Target step to show in tooltip
   * @method getTooltipContent
   * @return tooltip content
   */
  getTooltipContent = (): BotDetailEditFlowDiagramStepLabel => {
    const {t, model} = this.props,
      {source} = model.sourcePort.info,
      {responses} = model.extras;

    return (
      <BotDetailEditFlowDiagramStepLabel
        t={t}
        source={source}
        responses={responses}
      />
    )
  }

  /**
   * Set link path marker head regarding to the link path direction
   * @method setPathMarker
   * @param inversed - is the path inversed
   * @return style object with marker
   */
  setPathMarker = (inversed: boolean): Object => {
    if(inversed) {
      return {
        markerStart: `url(#${markerHeadInversed})`
      }
    } else {
      return {
        markerEnd: `url(#${markerHead})`
      }
    }
  }

  // eslint-disable-next-line require-jsdoc
  render() {
    const {path, model} = this.props;

    return (
      <g className="link-segment">
        <path
          className="link-segment__path"
          ref={ref => this.path = ref}
          strokeWidth={model.width}
          strokeLinecap="round"
          d={path}
          style={this.style}
        />
        <path
          className="link-segment__path link-segment__path_shadow"
          onMouseEnter={this.onMouseEnter}
          onMouseLeave={this.onMouseLeave}
          strokeWidth={model.width * 5}
          d={path}
        />
        <circle
          className="link-segment__circle"
          ref={ref => this.circle = ref}
          r={model.width * 2}
        />
      </g>
    );
  }
}

export default CustomLinkSegment;
