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
      width: 500,
      height: 500
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

  test("Create a node", async (done) => {
    await page.goto("http://liwi.wavelab.top/algorithms/3/versions/8/diagnostics/51/diagram");
    await page.waitForSelector("#accordionNodes");
    await page.waitForSelector(".card");

    await page.evaluate(() => {
      document.querySelector(".card").click();
    });

    await page.waitForSelector("#collapse-assessmentTest");

    const cue_card_links = await page.evaluate(`(async() => {
      const nodes_list = document.querySelectorAll('#collapse-assessmentTest > div > div');
      const nodes = [...nodes_list];
      return nodes.map(node => node);
    })()`);


    console.log(cue_card_links);

    // let box = await e.boundingBox();
    // console.log(box);
    // await page.mouse.move(box.x + box.width / 2, box.y + box.height / 2);
    // await page.mouse.move(box.x + box.width / 2, box.y + box.height / 2);
    // await page.mouse.down();
    // await page.mouse.move(500, 500);
    // await page.mouse.up();


    const html = await page.$eval(".btn-transparent", e => e.innerHTML);
    expect(html).toBe("New");

  }, 4000000);
});
