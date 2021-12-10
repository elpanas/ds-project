/* eslint-disable consistent-return */
const headerType = 'WWW-Authenticate';
const headerMessage = 'Bearer realm: "Restricted Area"';
const {
  app: { auth },
} = require('../config/config');

module.exports = (req, res, next) => {
  if (req.get('Authorization') !== `Bearer ${auth}`)
    return res.status(401).setHeader(headerType, headerMessage).send();

  next();
};
