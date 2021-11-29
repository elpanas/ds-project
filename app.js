const express = require('express'); // FRAMEWORK
const compression = require('compression'); // MIDDLEWARES
const helmet = require('helmet');
const {
  app: { port },
} = require('./config/config');

const app = express();
const restbath = require('./routes/restbath'); // ROUTES
const clusterTest = require('./routes/clustertest');

const listenMessage = `Listening on port ${port}...`;

// MIDDLEWARES ACTIVACTION
app.use(helmet());
app.use(compression());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
// ROUTES
app.get('/', (req, res) => res.status(200).send('BeachU Web Service'));

app.use('/api/bath', restbath);
app.use('/api/clustertest', clusterTest);

// eslint-disable-next-line no-console
const server = app.listen(port, () => console.log(listenMessage));

module.exports = server;
