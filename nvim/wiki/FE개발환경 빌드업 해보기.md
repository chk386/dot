---
layout  : wiki
title   : 
summary : 
date    : 2022-12-10 14:41:05 +0900
updated : 2022-12-11 20:45:49 +0900
tag     : 
toc     : true
public  : true
parent  : 
latex   : false
---
* TOC
{:toc}

## 사전준비
```bash
brew install node
```

## 프로젝트 설정
`npm`은 node package manager이다. 설치의 편리함 그리고 버전관리 및 의존성 관리
- java, kotlin -> gradle
- php -> composer
- python -> pip
- ruby -> gem
- .net, c# -> NuGet
- macOS -> brew
- Linux(ubuntu) -> apt
- Linux(centos) -> yum
- Linux(Alpine) -> apk
- windows -> choco, scoop
- jdk echo system -> sdkman
- multiple sdk -> asdf

```bash
npm init 
```

### eslint & prettier
eslint : 유연한 자바스크립트이 특징으로 인하여 뜻하지 않는 문제가 발생하는
경우가 많아 개발된 정적 분석 도구이다. 코드 컨벤션을 자동으로 검증하고
잠재적인에러를 찾아내 js의 단점을 보완하여 준다.
`prettier`는코드 포맷팅 도구이며 javascript, react, typescript, html, css,
markdown등을 지원한다. 한 사람이 작성한 것 처럼 코드스타일 유지가 가능.
문법분석이 아닌 엄격한 코드스타일에 초점을 둔다.


```bash
npm i -D eslint-config-prettier prettier stylelint stylelint-config-standard stylelint-config-prettier
```

```javascript
# .prettierrc.json
{
  "singleQuote": true,
  "semi": true,
  "useTabs": false,
  "tabWidth": 2,
  "trailingComma": "all",
  "printWidth": 80,
  "arrowParens": "avoid"
}

```
```javascript
# .eslintrc.json
{
  "plugins": ["prettier"],
  "rules": {
    "prettier/prettier": "error"
  }
}
```

```javascript
# .stylelintrc.json
{
  "extends": ["stylelint-config-standard"]
  "rules": {
    "alpha-value-notation": "number"
  }
}
```

### webpack
`webpack` HTML, CSS, Javascript, Typescript, Images등을 번들링 하는 도구이다.
![bundle](https://joshua1988.github.io/webpack-guide/assets/img/webpack-bundling.e79747a1.png)

![bundle.js](https://www.whatap.io/ko/blog/44/img/blog_44_03.webp)

  - Code splitting or Lazy Loading : 큰 번들링을 피하기 위하여 chunk로 단위로
    쪼개는 기능
  - Tree Shaking : 사용하지 않는 모듈은 Packing하지 않음 
  - Minify, Uglify : 압축, 난독화 
  - Transpiler : Compiler는 인간에서 기계로 변환하는 작업인 반면
    Transpiler는 source to source compiler이다. sass, react, vue등을 실행가능한
    css, js, html로 변경한다.


```bash
npm i -D webpack webpack-cli webpack-dev-server html-webpack-plugin css-loader style-loader mini-css-extract-plugin
```

package.json 수정
```json
  "scripts": {
    "build": "webpack build --mode production",
    "start": "webpack-dev-server --mode development --open",
    "test": "echo \"Error: no test specified\" && exit 1"
  },
```

Create webpack.config.js 
```javascript
const path = require('path');
const HTMLWebpackPlugin = require('html-webpack-plugin');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');

module.exports = (env, options) => {
  const isProduction = options['mode'].includes('production');

  const plugins = [
    new HTMLWebpackPlugin({
      template: path.resolve(__dirname, 'src', 'index.html'),
    }),
  ];
  if (isProduction) {
    plugins.push(
      new MiniCssExtractPlugin({
        // 플러그인 옵션 설정
        linkType: false, // 기본 값 'text/css'
      }),
    );
  }

  return {
    entry: { index: path.resolve(__dirname, 'src', 'index.js') },
    output: {
      path: path.resolve(__dirname, 'dist'),
      filename: 'main.js',
      clean: true,
    },
    plugins: plugins,
    module: {
      rules: [
        {
          test: /\.css$/,
          use: [
            isProduction ? MiniCssExtractPlugin.loader : 'style-loader',
            'css-loader',
          ],
        },
        // {
        //   test: /\.m?js$/,
        //   exclude: /node_modules/,
        //   use: {
        //     loader: 'babel-loader',
        //     options: {
        //       presets: ['@babel/preset-env'],
        //     },
        //   },
        // },
        },
      ],
    },
  };
};
```

### Babel
`Babel`은 모던 자바스크립트의 하위 브라우저 호환성 유지하기 위한 자바스크립트
컴파일러이다. 바벨로 해결되지 않을 경우 polyfill을 사용하기도 함.

```bash
npm i -D @babel/core babel-loader @babel/preset-env
```

Create babel.config.json configuration file
```javascript
{
  "presets": ["@babel/preset-env"]
}
```

## 기타 이모저모 
```bash
git pull https://github.nhnent.com/ncp/shopby-saas.git
```

```bash
# create .eslintrc.js
npm init @eslint/config


# create react-app
npx create-react-app my-app
```


