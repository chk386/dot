---
layout  : wiki
title   : 
summary : 
date    : 2022-12-17 18:23:06 +0900
updated : 2022-12-18 18:40:47 +0900
tag     : 
toc     : true
public  : true
parent  : 
latex   : false
---
* TOC
{:toc}

# 목표 
편리하면서도 있어 보이면서도 개발 업무의 효율을 높이기 위한 리눅스(맥) 셋팅

## 사전준비
- brew install iterm2
- brew tap homebrew/cask-fonts && brew install --cask font-jetbrains-mono-nerd-font
- brew tap homebrew/cask-fonts && brew install --cask font-fira-mono-nerd-font
- docker run -it ubuntu /bin/sh

## Todo
* [ ] 터미널 설치
* [ ] 개발자(NERD) 폰트 설치
* [ ] iterm2 셋팅 - key set, font, colorscheme
* [ ] 쉘 이란? 종류 역사
* [ ] ubuntu 접속
* [ ] git, curl, wget, vim 설치
* [ ] zsh
* [ ] om my zsh
* [ ] zplug : git, syntax-highlighting, powerlevel10k, zsh-autosuggestions,
      zsh-completions 
* [ ] 유용한 터미널 프로그램 : exa, bat, fzf, ripgrep
* [ ] asdf
* [ ] git을 이용하여 동일한 dot config 구성 

## shell
- 사용자와 커널을 연결시켜주는 기능을 수행하는 특별한 프로그램
- 사용자가 입력한 명령을 처리하고 실행 결과를 알려주는 기능
- features: 명령어 해석기, 프로그래밍, 사용자 환경 설정

### 종류
- Bourne Shell (sh)
  - 최초의 쉘
  - Stephen Bourne
  - 근래에도 Unix 기본 설치
  - 히스토리, alias등 편의 기능 X
- Bourne Again Shell (bash)
  - 본 쉘 확장
  - Brian Fox
  - 본쉘 호환성 유지 + C쉘, 콘쉘 기능 포함
  - GPL공개 소프트웨어
  - 리눅스 기본 쉘
- Z Shell (zsh)
  - 쉘 스크립팅을 위한 커맨드 인터프리터, 로그인 쉘이며 unix쉘
  - 본 쉘의 확장과 개선, ksh, tcsh등의 기능 포함
  - 맥os에서는 요새미티 이후 기본쉘이 zsh로 변경. (라이센스 문제로 추측)
  - features
    - tab키키 누르면 명령어 완성기능
    - 입력한 쉘 명령어 히스토리
    - [file globbing](https://www.daleseo.com/glob-patterns/) 
    - 향상된 변수/배열 처리
    - 스펠링 교정
    - 테마적용이 가능한 다양항 프롬프트(예 : git)

### ZSH Utilities 
- [Oh My Zsh](https://ohmyz.sh/)
  - Oh My Zsh is an open source, community-driven framework for managing your Zsh configuration.
  - 수백가지의 파워풀한 플러그인, 아름다운 테마 지원 
  - `Strangers will come up to you in cafés and ask you, "that is amazing! are you some sort of genius?"`
- [zplug](https://github.com/zplu/zplug)
  - A next-generation plugin manager for zsh

```bash
apt update
apt install git curl wget vim zsh bat fzf ripgrep fd-find exa -y

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# zplug
git clone https://github.com/zplug/zplug ~/.zplug

# asdf
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.10.2
```

## 기타
 - [Brew Bundle](https://github.com/Homebrew/homebrew-bundle)
 - [wezterm](https://wezfurlong.org/wezterm/) : iterm2는 mac전용, 이쁘고
   느리다. mac이 아니면?
 - [FlatLaf](https://www.formdev.com/flatlaf/) : idea는 좋은건 알겠지만  느리다. 파일 찾기,
   파일안에 문자열 찾기, auto complete, go to definition, find all
   references등등 다 느리다. 
   - https://intellij-support.jetbrains.com/hc/en-us/community/posts/206330739-Is-IDEA-written-in-Java- 
   - [ctags](https://johngrib.github.io/wiki/ctags/)
   - [tree sitter](https://tree-sitter.github.io/tree-sitter/playground) :
     dooray editor
 - [JetBrains Gateway](https://www.jetbrains.com/ko-kr/remote-development/)
 - [VS Code](https://code.visualstudio.com/docs/remote/vscode-server)
 - [awesome](https://github.com/rust-unofficial/awesome-rust)
 - [github cli](https://cli.github.com/)
 - Nerd한 개발자가 되자.
   - [junegunn](https://github.com/junegunn)
   - [Trustin Lee](https://github.com/trustin)
 - 다음시간 : [Shell Script](Shell Script)



