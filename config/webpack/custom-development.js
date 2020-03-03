module.exports = {
  devServer: {
    watchOptions: {
      poll: 1000,
    }
  },
  optimization:{
    minimize: false, // <---- disables uglify.
    // minimizer: [new UglifyJsPlugin()] if you want to customize it.
  }
};
