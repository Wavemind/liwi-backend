import 'babel-polyfill';
const puppeteer = require('puppeteer');
let browser;
let page;

beforeAll(async () => {
  browser = await puppeteer.launch({
    headless: false
  });
  page = await browser.newPage();

  page.emulate({
    viewport: {
      width: 500,
      height: 500
    },
    userAgent: ''
  });
});

afterAll(async () => {
  browser.close();
});

describe('Examining the syntax of Jest tests', () => {
  test('auth user', async (done) => {
    await page.goto('http://localhost:3000/');
    await page.waitForSelector('#user_email');
    await page.waitForSelector('#user_password');

    await page.evaluate(() => {
      document.querySelector('#user_email').value = 'quentin.girard@wavemind.ch';
      document.querySelector('#user_password').value = '123456';
      document.querySelector('.btn-success').click();
    });

    await page.waitForSelector('#content');
    const html = await page.$eval('#content h1', e => e.innerHTML);
    expect(html).toBe('Device location');
    done();
  }, 30000);

  test('next test', async (done) => {
    await page.goto('http://localhost:3000/algorithms/3/versions/5/diagnostics/1/diagram');
    await page.waitForSelector('.btn-transparent');
    const html = await page.$eval('.btn-transparent', e => e.innerHTML);
    expect(html).toBe('CC10 - Prevention');

    done();
  }, 30000);
});
