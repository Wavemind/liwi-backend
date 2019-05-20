module.exports = {
  presets: [
    [
      "@babel/preset-env",
      {
        modules: "auto",
        forceAllTransforms:true,
        targets: {
          node: "current"
        },
        useBuiltIns: false
      }
    ],
    "@babel/preset-react"
  ],
  plugins: [
    "@babel/plugin-syntax-dynamic-import",
    "@babel/plugin-proposal-object-rest-spread",
    [
      "@babel/plugin-proposal-class-properties",
      {
        spec: true
      }
    ]
  ]
};
