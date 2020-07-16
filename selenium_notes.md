# Using Selenium

## Installation

Install the WebDrivers.

Firefox on Ubuntu Linux:
```shell
sudo apt install firefox-geckodriver
```

Chrome on Ubuntu Linux:
```shell
sudo apt install chromium-chromedriver
```

Create a new node project and install the [selenium-webdriver](https://www.npmjs.com/package/selenium-webdriver):
```shell
npm install --save selenium-webdriver
```


## Docker

TODO.


## Example setup

### Firefox
A skeleton selenium-webdriver setup using Firefox:

```javascript
const {Builder, By, Key, until} = require('selenium-webdriver');

(async function skeleton() {
  let driver = await new Builder().forBrowser('firefox').build();
  try {
    await driver.get('https://example.com/');
    await driver.wait(until.titleIs('Example Title'), 2000);
  } finally {
    await driver.quit();
  }
})();
```


### Chrome

Default:
```javascript
const browser = await new Builder().forBrowser('chrome');
const driver = await browser.build();
```

With options (notice the `goog:chromeOptions` key):
```javascript
// Chrome with options -
const chromeOpts = {
  args: [
    '--start-maximized',
    '--use-fake-ui-for-media-stream'
  ],
};
let chromeCaps = Capabilities.chrome();
// Specify both options for grid or local use, see:
// https://github.com/webdriverio/webdriverio/issues/2645#issuecomment-407034467
chromeCaps = {
  ...chromeCaps,
  'browserName': 'chrome',
  'chromeOptions': chromeOpts,
  'goog:chromeOptions': chromeOpts,
};
const driver = await new Builder().withCapabilities(chromeCaps).build();
```


## Cookbook

Note that most calls return promises.


### Find an element by name attribute

```javascript
const el = await driver.findElement(By.name('some-elem'));
```


### Send text input to an element

```javascript
const el = await driver.findElement(By.name('some-elem'));
await el.sendKeys('some text', Key.RETURN);
```


### Find an element that contains specific text

```javascript
const el = await driver.findElement(By.xpath("//*[contains(text(), 'some text')]"));
```


### Click an element

```javascript
...
el.click();
```


### Find an element by placeholder text

```javascript
const el = await driver.findElement(By.xpath("//input[@placeholder='some placeholder']"));
```


### Get the value of an attribute for an element

```javascript
const val = await el.getAttribute('some_attr');
```


### Find the parent of an element

```javascript
const el = await driver.findElement(By.xpath("//*[contains(text(), 'something')]"));
const parentEl = await el.findElement(By.xpath("./.."));
```

### Get the page title

```javascript
const title = await driver.getTitle();
```


### Wait until the page title is some value

Wait with a timeout of 2 seconds:
```javascript
await driver.wait(until.titleIs('Some Title'), 2000);
```


### Wait until an element is located

```javascript
await driver.wait(until.elementLocated(By.xpath("//*[@placeholder='some value']")));
```


### Wait for a custom predicate

```javascript
await driver.wait(async () => {
  const val = await el.getAttribute('value');
  return val.match(/^some pattern/);
}, 2000);
```


### Switch windows

Enumerate windows and switch to the last one (assumes a single starting window with a second window just opened):
```javascript
const wins = await driver.getAllWindowHandles();
await driver.switchTo().window(wins[wins.length - 1]);
```


### Interact with or dismiss a Javascript alert

```javascript
const jsAlert = await driver.switchTo().alert();
jsAlert.accept();
```

