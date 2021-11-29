/* eslint-disable no-plusplus */
const router = require('express').Router();

// It was designed to be blocking and CPU-intensive in order to observe
// how it would affect a cluster afterwards
router.get('/', (req, res) => {
  const base = 8;
  let result = 0;
  for (let i = base ** 7; i >= 0; i--) {
    result += i + i ** 10;
  }

  res.status(200).send(`Result number is ${result}`);
});

module.exports = router;
