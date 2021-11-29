module.exports = {
  env: {
    browser: true,
    commonjs: true,
    es2021: true,
  },
  extends: ['airbnb-base', 'prettier'],
  parserOptions: {
    ecmaVersion: 13,
  },
  rules: {
    'global-require': 0,
  },
  plugins: ['prettier'],
};
