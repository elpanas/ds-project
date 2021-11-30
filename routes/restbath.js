const router = require('express').Router();
const authManagement = require('../middleware/auth');
const BathController = require('../controllers/bathController');

// CREATE
router.post('/', authManagement, BathController.postBath);
// --------------------------------------------------------------------

// READ
router.get('/disp/coord/:lat/:long', BathController.getBathCoord);
router.get('/bath/:id', BathController.getSingleBath);
router.get('/gest/:id', authManagement, BathController.getGest);
// --------------------------------------------------------------------

// UPDATE umbrellas
router.patch('/:id', authManagement, BathController.patchBath);
// --------------------------------------------------------------------

// UPDATE whole bath
router.put('/:id', authManagement, BathController.putBath);
// --------------------------------------------------------------------

// DELETE
router.delete('/:id', authManagement, BathController.deleteBath);
// --------------------------------------------------------------------

module.exports = router;
