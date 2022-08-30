# うつメイト
![ogp](https://user-images.githubusercontent.com/73326842/187337506-b11bf753-5e87-4465-ae02-c23053a35c0e.png)
# About
うつメイトは、うつ病の治療に大切な、「うつ病の人の客観的な行動記録」を作成するためのアプリです。

毎日記録をとるのは大変ですが、うつメイトなら、「お薬を飲めましたか？」「お食事を一食以上摂りましたか？」などの6つの簡単な質問に答えるだけでokです。
「客観的な行動記録」なので、うつ病の人本人だけでなく、家族やパートナーも使えます。

記録を元に正確なデータをpdf出力できるので、それを月々の診察に持っていけば、メンタルクリニックで、「先月どうだったっけ...。」なんて困ることもグッと減らせます。
# URL

```
https://utsumate.net
```

# Features
- 医師との相談で決められた6つの質問に回答するだけで、簡単に毎日の記録が取れます。
- 記録を元に毎月の「うつレポ」を作成し、pdf出力できます。

# Setup

```bash
$ git clone https://github.com/naomichi-h/utsumate.git
$ cd utsumate
$ bin/setup
$ bin/rails s
```

# Seeds

```bash
$ bin/rails db:seed_fu
```

# Lint & Tests

```shell
$ ./bin/lint
$ bundle exec rspec
```

# Log in

```
Email: alice@example.com
PASS:  password
```