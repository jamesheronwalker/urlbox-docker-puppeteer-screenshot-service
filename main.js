const express = require("express");
const puppeteer = require("puppeteer");

const app = express();
const appPort = 3000;

(async () => {

	const browser = await puppeteer.launch();

	process.on("beforeExit", async () => {
		await browser.close();
	});

	app.get("/capture", async (req, res) => {
		const page = await browser.newPage();
		await page.goto(req.query.url);
		await page.screenshot({path: `/captures/${Date.now()}.png`});
		await page.close();
		res.status(204).send();
	});

	app.listen(appPort, () => {
		console.log(`Service is listening on port ${appPort}...`);
	});

})();
