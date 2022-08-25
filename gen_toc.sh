#!/usr/bin/env bash
# Update the table of contents

case `uname` in
  Darwin)
  sed -i '' '1,/^<TOC>$/d' ./readme.md
  ;;
  Linux)
  sed -i '0,/^<TOC>$/d' ./readme.md
  ;;
esac

HDR="# Dev Environment Cheatsheet"
echo -e "${HDR}\n\n$(./node_modules/markdown-toc/cli.js ./readme.md)\n\n<TOC>\n$(cat ./readme.md)\n" > ./readme.md

