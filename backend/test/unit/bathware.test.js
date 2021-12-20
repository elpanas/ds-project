/* eslint-disable no-undef */
const mongoose = require('mongoose');
const {
  generatePostFakeInfos,
  generatePutFakeInfos,
} = require('../aux-functions');
const { createGeoIndex } = require('../../functions/functions');
const {
  createBath,
  getBathDispCoord,
  getBath,
  getBathGest,
  updateBath,
  updateUmbrellas,
  removeBath,
} = require('../../middleware/bathware');

let newBath;
let bid;
let uid;
let lat;
let long;
let avUmbrellas;

beforeAll(() => {
  process.env.NODE_ENV = 'test';
  newBath = generatePostFakeInfos();
});
beforeEach(() => {
  require('../db-test');
  bid = '617c09616263be33dccdf5a2';
  uid = 'CdGMzNaQZZW6ckRqcEeWxFhauRa2';
  lat = 41.4566583;
  long = 15.5343864;
  avUmbrellas = 145;
});
afterAll(async () => {
  await mongoose.disconnect();
});

describe('MIDDLEWARES', () => {
  describe('CREATE', () => {
    test('createBath', async () => {
      const result = await createBath(newBath);
      await createGeoIndex();
      expect(result).not.toBeNull();
      expect(result).toHaveProperty('_id');
    });

    test('createBath Fail', async () => {
      const result = await createBath(newBath);
      expect(result).toBeFalsy();
    });
  });

  describe('READ', () => {
    test('getBathDispCoord', async () => {
      const result = await getBathDispCoord(lat, long);
      expect(result).not.toBeNull();
      expect(result).not.toBeFalsy();
    });

    test('getBath', async () => {
      const result = await getBath(bid);
      expect(result).not.toBeNull();
      expect(result).not.toBeFalsy();
    });

    test('getBath Fail', async () => {
      bid = 'fakeBathId';
      const result = await getBath(bid);
      expect(result).not.toBeNull();
      expect(result).toBeFalsy();
    });

    test('getBathGest', async () => {
      const result = await getBathGest(uid);
      expect(result).not.toBeNull();
      expect(result).not.toBeFalsy();
    });

    test('getBathGest Fail', async () => {
      uid = 'fakeUserId';
      const result = await getBathGest(uid);
      expect(Object.keys(result).length).toEqual(0);
    });
  });

  describe('UPDATE', () => {
    test('updateBath', async () => {
      const updatedBath = generatePutFakeInfos();
      const result = await updateBath(bid, updatedBath);
      expect(result).not.toBeNull();
      expect(result).not.toBeFalsy();
    });

    test('updateBath Fail', async () => {
      bid = 'fakeBathId';
      const updatedBath = generatePutFakeInfos();
      const result = await updateBath(bid, updatedBath);
      expect(result).not.toBeNull();
      expect(result).toBeFalsy();
    });

    test('updateUmbrellas', async () => {
      const result = await updateUmbrellas(bid, avUmbrellas);
      expect(result).not.toBeNull();
      expect(result).not.toBeFalsy();
    });

    test('updateUmbrellas Fail', async () => {
      bid = 'fakeBathId';
      const result = await updateUmbrellas(bid, avUmbrellas);
      expect(result).not.toBeNull();
      expect(result).toBeFalsy();
    });
  });

  describe('DELETE', () => {
    test('removeBath', async () => {
      const result = await removeBath(bid);
      expect(result).not.toBeNull();
      expect(result).not.toBeFalsy();
    });

    test('removeBath Fail', async () => {
      bid = 'fakeBathId';
      const result = await removeBath(bid);
      expect(result).not.toBeNull();
      expect(result).toBeFalsy();
    });
  });
});
