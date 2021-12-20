const router = require('express').Router();
const authManagement = require('../middleware/authware');
const bathController = require('../controllers/bathController');

// CREATE
router.post('/', authManagement, bathController.postBath);
// --------------------------------------------------------------------

// READ
router.get('/disp/coord/:lat/:long', bathController.getBathCoord);
router.get('/bath/:id', bathController.getSingleBath);
router.get('/gest/:id', authManagement, bathController.getGest);
// --------------------------------------------------------------------

// UPDATE umbrellas
router.patch('/:id', authManagement, bathController.patchBath);
// --------------------------------------------------------------------

// UPDATE whole bath
router.put('/:id', authManagement, bathController.putBath);
// --------------------------------------------------------------------

// DELETE
router.delete('/:id', authManagement, bathController.deleteBath);
// --------------------------------------------------------------------

module.exports = router;
