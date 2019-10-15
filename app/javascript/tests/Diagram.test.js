import "babel-polyfill";

const puppeteer = require("puppeteer");
let browser;
let page;

beforeAll(async () => {
  browser = await puppeteer.launch({
    headless: false
  });
  page = await browser.newPage();

  page.emulate({
    viewport: {
      width: 1024,
      height: 1024
    },
    userAgent: "Mozilla/5.0 (X11; Linux x86_64)" +
      "AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.39 Safari/537.36"
  });
});

afterAll(async () => {
});

describe("Examining the syntax of Jest tests", () => {
  test("auth user", async (done) => {
    await page.goto("http://liwi.wavelab.top/");
    await page.waitForSelector("#user_email");
    await page.waitForSelector("#user_password");

    await page.evaluate(() => {
      document.querySelector("#user_email").value = "quentin.girard@wavemind.ch";
      document.querySelector("#user_password").value = "123456";
      document.querySelector(".btn-succes").click();
    });

    await page.waitForSelector("#content");
    const html = await page.$eval("#content h1", e => e.innerHTML);
    expect(html).toBe("Device location");
    done();
  }, 40000);

  // test("Open diagram question modal", async (done) => {
  //   await page.goto("http://liwi.wavelab.top/algorithms/3/versions/8/diagnostics/51/diagram");
  //   await page.waitForSelector("#node-101");
  //
  //   await page.evaluate(() => {
  //     document.querySelector("body > main > div:nth-child(2) > div > div > div > div > div.col-md-12.liwi-toolbar > div > div:nth-child(1) > div > button").click();
  //     document.querySelector("body > main > div:nth-child(2) > div > div > div > div > div.col-md-12.liwi-toolbar > div > div:nth-child(1) > div > div > a:nth-child(1)").click();
  //   });
  //
  //
  //   const modalTitle = await page.$eval("body > div.fade.modal.show > div > div > form > div.modal-header > div", e => e.innerHTML);
  //   const category = await page.$eval("body > div.fade.modal.show > div > div > form > div.modal-body > div:nth-child(1) > div > label", e => e.innerHTML);
  //   const answerType = await page.$eval("body > div.fade.modal.show > div > div > form > div.modal-body > div:nth-child(2) > div > label", e => e.innerHTML);
  //   expect(modalTitle).toBe("Create a question");
  //   expect(category).toBe("Category");
  //   expect(answerType).toBe("Answer type");
  //
  //   done();
  // }, 40000);

  test("Open diagram question modal", async (done) => {
    await page.goto("http://liwi.wavelab.top/algorithms/3/versions/8/diagnostics/51/diagram");
    await page.waitForSelector("#node-101");

    await page.evaluate(() => {
      document.querySelector("body > main > div:nth-child(2) > div > div > div > div > div.col-md-12.liwi-toolbar > div > div:nth-child(1) > div > button").click();
      document.querySelector("body > main > div:nth-child(2) > div > div > div > div > div.col-md-12.liwi-toolbar > div > div:nth-child(1) > div > div > a:nth-child(1)").click();
    });
    await page.waitFor(5000);

    // await page.select('#category', 'Questions::ChiefComplaint')
    // await page.click("#category");
    await page.waitFor(5000);
    await page.evaluate(() => {
      document.querySelector('#category option:nth-child(9)').selected = true;
      document.querySelector('#category').dispatchEvent(new Event("change"));
    });

    await page.waitFor(50000);

    const wrapper = mount(<myReactComponent{...props}/>);
    wrapper.find('#category').simulate('change',{target: { value : 'Questions::Vaccine'}});

    done();
  }, 40000);

  // TODO : Make it work
  // test("Open rails question modal", async (done) => {
  //   await page.goto("http://liwi.wavelab.top/algorithms/3");
  //   await page.waitForSelector("#profile-tab");
  //
  //   await page.evaluate(() => {
  //     document.querySelector("#profile-tab").click();
  //     document.querySelector("#questions > a > button").click();
  //   });
  //
  //   await page.waitForSelector("#question_type");
  //
  //   await page.evaluate(() => {
  //     document.querySelector("#question_type").click();
  //     document.querySelector("#question_type > option:nth-child(3)").click();
  //   });
  //   await page.waitFor(50000)
  //
  //
  //   const stage = await page.$eval("#question_stage_displayed", e => e.hasAttribute('disabled'));
  //
  //   console.log(stage);
  //
  //   done();
  // }, 40000);
});
