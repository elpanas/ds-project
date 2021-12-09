/* eslint-disable consistent-return */
const headerType = 'WWW-Authenticate';
const headerMessage = 'Basic realm: "Restricted Area"';
const {
  app: { auth },
} = require('../config/config');

module.exports = (req, res, next) => {
  if (req.get('Authorization') !== auth)
    return res.status(401).setHeader(headerType, headerMessage).send();

  next();
};
