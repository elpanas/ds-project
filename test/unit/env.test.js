/* eslint-disable no-undef */
describe('ENV variables', () => {
  it('should be "test"', () => {
    expect(process.env.NODE_ENV).toBe('test');
  });
});
