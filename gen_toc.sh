#!/usr/bin/env bash
# Update the table of contents

sed -i '0,/^<TOC>$/d' ./readme.md
HDR="# Dev Environment Cheatsheet"
echo -e "${HDR}\n\n$(./node_modules/markdown-toc/cli.js ./readme.md)\n\n<TOC>\n$(cat ./readme.md)\n" > ./readme.md

