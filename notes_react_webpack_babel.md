# React/Webpack/Babel Notes - old

These are old notes from setting up an old environment.

## Directory structure

```
project
.
├── node_modules
├── public
├── src
|   ├── components
|   |   └ App.jsx
|   └── main.js
├── .babelrc
├── index.html
├── package.json
└── webpack.config.js
```

## Steps

### Create the project

```shell
mkdir <project> && cd $_
npm init
mkdir -p src/components
```

### Install libraries

```shell
npm i --save webpack babel-loader react babel-preset-es2015 babel-preset-react babel-preset-stage-0 react-hot-loader
npm i -g webpack-dev-server
```

### Edit webpack.config.js

```javascript
var path = require('path');
var webpack = require('webpack');

module.exports = {
  devtool: 'eval-source-map',
  entry: {
    main: [
    'webpack-dev-server/client?http://',
      './src/main.js'
    ]
  },
  output: {
    filename: './public/[name].js'
  },
  module: {
    loaders: [
      {
        test: /\.jsx?$/,
        exclude: /node_modules/,
        loader: 'babel'
      }
    ]
  }
};
```

### Edit .babelrc

```json
{
  "presets":
  [
    "react",
    "es2015",
    "stage-0"
  ]
}
```

### Run

```shell
node_modules/.bin/webpack
webpack-dev-server --progress --colors
```

## Issues

### React.render is deprecated. Please use ReactDOM.render from require('react-dom') instead.

From: https://facebook.github.io/react/blog/2015/10/07/react-v0.14.html

```shell
npm install --save react react-dom
```

Then:

```javascript
var ReactDOM = require('react-dom');
ReactDOM.render(<MyComponent />, node);
```

### Only a ReactOwner can have refs. You might be adding a ref to a component that was not created inside a component's render method, or you have multiple copies of React loaded.

https://gist.github.com/jimfb/4faa6cbfb1ef476bd105

Check if you have multiple copies of React:

```shell
npm ls | grep -i react
```

If so, reinstall your node modules:

```shell
\rm -r node_modules
npm install
```
