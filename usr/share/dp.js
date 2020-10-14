const puppeteer = require('puppeteer-core');
const axios = require('axios');
const fs = require('fs');

(async() => {
  try {
    const response = await axios.get('http://localhost:9222/json/version');
    const {webSocketDebuggerUrl} = response.data;
    const browser = await puppeteer.connect({
      browserWSEndpoint: webSocketDebuggerUrl, 
      defaultViewport: {
        width:2304,
        height: 1440,
        isLandscape: true
      }
    });
    const page = await browser.newPage();
    page.on('console', msg => console.log('PAGE LOG:', msg.text()));
    await page.setDefaultTimeout(300000);
    page.setViewport({
      width: 2304,
      height: 1440,
      isLandscape: true
    });
    await page.goto('http://digital.olivesoftware.com/Olive/ODN/DenverPost/Default.aspx', {waitUntil: 'networkidle2'});


    await page.waitForSelector('.download');
    await page.waitForTimeout(3000);
    await page.hover('.download');
    await page.waitForTimeout(3000);
    await page.waitForSelector('.button.pdf.dropdown');
    await page.click('.button.pdf.dropdown');

    await page.waitForTimeout(30000);

    const contents = await page.content();
    fs.writeFile('contents.json', contents,'utf8', () => {});

    const extracted = await page.evaluate(() => {
      const actualUrl = document.URL;
      const links = Array.from(document.getElementsByTagName('a'));
      return JSON.stringify(links.map((n) => {
        try {
          return {
            "actualUrl": actualUrl,
            "href": n.getAttribute("href"),
            "innerHTML": n.innerHTML,
            "hreflang": n.getAttribute("hreflang"),
            "ping": n.getAttribute("ping"),
            "referrerpolicy": n.getAttribute("referrerpolicy"),
            "rel": n.getAttribute("rel"),
            "target": n.getAttribute("target")
          };
        } catch (e) {
          return {"error": e.toString()};
        }
      }));
    });
    fs.writeFile('extracted.json', extracted,'utf8', () => {});

    await browser.close();

  } catch (e) {
    console.log(e.message);
    process.exit(1);
  }
})();
