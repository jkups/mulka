const { webpackConfig, merge } = require("@rails/webpacker");
const ForkTSCheckerWebpackPlugin = require("fork-ts-checker-webpack-plugin");
const webpack = require("webpack");
const path = require("path");

module.exports = merge(webpackConfig, {
  plugins: [
    new ForkTSCheckerWebpackPlugin({
      async: false,
      typescript: {
        configFile: path.resolve(__dirname, "../../tsconfig.json"),
      },
    }),
    new webpack.DefinePlugin({
      "process.env": JSON.stringify(process.env),
    }),
  ],
});

module.exports = webpackConfig;
