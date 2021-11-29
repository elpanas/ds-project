/* eslint-disable no-undef */
const {
  generatePostFakeInfos,
  generateMissingPostFakeInfos,
  generateWrongPostFakeInfos,
} = require('../aux-functions');
const { Bath } = require('../../models/bath');

jest.useFakeTimers();

describe('Bath model validation tests', () => {
  it('should validate bath', async () => {
    const newBath = generatePostFakeInfos();
    const bath = new Bath(newBath);
    expect(async () => bath.validate()).not.toThrow();
  });

  it('should not validate bath without required name field', async () => {
    const missBath = generateMissingPostFakeInfos();
    const bath = new Bath(missBath);
    expect(async () => bath.validate()).rejects.toThrow();
  });

  it('should not validate bath with wrong format field', async () => {
    const wrongBath = generateWrongPostFakeInfos();
    const bath = new Bath(wrongBath);
    expect(async () => bath.validate()).rejects.toThrow();
  });
});
