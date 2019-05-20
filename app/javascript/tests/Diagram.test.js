import Http from "../http";

describe('Examining the syntax of Jest tests', () => {

  it('sums numbers', () => {
    let http = new Http();
    let test = http.createInstance(12);
    console.log(test);
    expect(1 + 2).toEqual(3);
    expect(2 + 2).toEqual(4);
  });
});
