const puppeteer = require('puppeteer')

;(async () => {
  const browser = await puppeteer.launch()
  const page = await browser.newPage()
  await page.goto('http://localhost:5173/', {waitUntil: 'networkidle0'})
  await page.pdf({path: 'index.pdf', format: 'A4'})
  await browser.close()
})()