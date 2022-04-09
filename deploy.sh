#!/bin/bash

IFS="
"

python scrape_tg_botapi.py "botapi.json"
python scrape_tg_api_schema.py "https://core.telegram.org/schema" "api.tl"
wget -O tdesktop.tl "https://github.com/telegramdesktop/tdesktop/raw/dev/Telegram/Resources/tl/api.tl"
wget -O tdlib.tl "https://github.com/tdlib/td/raw/master/td/generate/scheme/telegram_api.tl"

git checkout --orphan data

rm -rf .github/ README.md requirements.txt *.py
git rm deploy.sh
git add -r .github/ README.md requirements.txt *.py deploy.sh
git config --global user.email "overtakeful@gmail.com"
git config --global user.name "GitHub Action <Mike Renoir>"
git commit -m "clean up"

git config --global user.email "durov2005@gmail.com"
git config --global user.name "GitHub Action <Pavel Durov>"
git add api.tl
git commit -m "update OW API scheme"

git config --global user.email "johnprestonmail@gmail.com"
git config --global user.name "GitHub Action <John Preston>"
git add tdesktop.tl
git commit -am "update tDesktop API scheme"

git config --global user.email "levlam@telegram.org"
git config --global user.name "GitHub Action <Aliaksei Levin>"
git add tdlib.tl
git commit -am "update TDLib API scheme"

git config --global user.email "igor.beatle@gmail.com"
git config --global user.name "GitHub Action <Igor Zhukov>"
git add botapi.json
git commit -am "update BOT API docs"

git push --force -u origin data
git checkout main
