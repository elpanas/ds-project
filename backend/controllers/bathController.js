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

module.exports = {
  postBath: async (req, res) => {
    const result = await createBath(req.body);
    await postResultManagement(res, result);
  },

  getBathCoord: async (req, res) => {
    const result = await getBathDispCoord(req.params.lat, req.params.long);
    jsonResultManagement(res, result);
  },

  getSingleBath: async (req, res) => {
    const result = await getBath(req.params.id);
    jsonResultManagement(res, result);
  },

  getGest: async (req, res) => {
    const result = await getBathGest(req.params.id);
    jsonResultManagement(res, result);
  },

  patchBath: async (req, res) => {
    const result = await updateUmbrellas(req.params.id, req.body.av_umbrellas);
    resultManagement(res, result);
  },

  putBath: async (req, res) => {
    const result = await updateBath(req.params.id, req.body);
    resultManagement(res, result);
  },

  deleteBath: async (req, res) => {
    const result = await removeBath(req.params.id);
    resultManagement(res, result);
  },
};
