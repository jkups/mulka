const plugin = require("tailwindcss/plugin");

module.exports = {
  important: true,
  content: [
    "./app/assets/**/*.svg",
    "./app/components/**/*.rb",
    "./app/**/*.html.erb",
    "./app/javascript/**/*.js",
    "./app/javascript/**/*.ts",
  ],
  theme: {
    extend: {
      height: {
        104: "24rem",
        108: "26rem",
      },
    },
  },
  plugins: [
    require("@tailwindcss/forms"),
    plugin(function ({ addUtilities }) {
      addUtilities({
        ".no-scrollbars": {
          "-ms-overflow-style": "none",
          "scrollbar-width": "none",
        },
        ".no-scrollbars::-webkit-scrollbar": {
          display: "none",
        },
      });
    }),
  ],
};
