const router = require('express').Router();
const {
  createBath,
  getBathDispCoord,
  getBath,
  getBathGest,
  removeBath,
  updateBath,
  updateUmbrellas,
} = require('../middleware/bathware');
const {
  postResultManagement,
  jsonResultManagement,
  resultManagement,
} = require('../functions/functions');
const authManagement = require('../middleware/auth');

// CREATE
router.post('/', authManagement, async (req, res) => {
  const result = await createBath(req.body);
  await postResultManagement(res, result);
});
// --------------------------------------------------------------------

// READ
router.get('/disp/coord/:lat/:long', async (req, res) => {
  const result = await getBathDispCoord(req.params.lat, req.params.long);
  jsonResultManagement(res, result);
});

router.get('/bath/:id', async (req, res) => {
  const result = await getBath(req.params.id);
  jsonResultManagement(res, result);
});

router.get('/gest/:id', authManagement, async (req, res) => {
  const result = await getBathGest(req.params.id);
  jsonResultManagement(res, result);
});
// --------------------------------------------------------------------

// UPDATE umbrellas
router.patch('/:id', authManagement, async (req, res) => {
  const result = await updateUmbrellas(req.params.id, req.body.av_umbrellas);
  resultManagement(res, result);
});
// --------------------------------------------------------------------

// UPDATE whole bath
router.put('/:id', authManagement, async (req, res) => {
  const result = await updateBath(req.params.id, req.body);
  resultManagement(res, result);
});
// --------------------------------------------------------------------

// DELETE
router.delete('/:id', authManagement, async (req, res) => {
  const result = await removeBath(req.params.id);
  resultManagement(res, result);
});
// --------------------------------------------------------------------

module.exports = router;
