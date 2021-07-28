# Agris　出荷登録システムアプリケーション
- トップ画像
![top.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/1514036/38570b94-e64c-c1d3-3911-59223e0d9683.png)
- ロゴイメージ
![logo.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/1514036/5deb1511-5ecb-1fd6-9b44-f33714ab8c5f.png)

## サイト概要
今回作るアプリケーションは、農家がweb上で野菜の出荷登録ができる。「WEB出荷登録システム」サイト


### サイトテーマ
どこでも簡単、出荷登録ができる！計画的な販売で有利に販売しよう！

### サイト概要
- 出先などどこからでも入力　提出することができます
- 生産者ごとのデータがデータベースに蓄積されていきますので、管理もしやすくなる
- JAなどへの出荷時に出荷情報を共有できれば計画的な販売に繋がり、単価UPへつなげることができる


### テーマを選んだ理由
　以前JA職員として青果物の販売を担当していました。その時に一番大変だったのが、朝急に大量に野菜が出荷され販売先が無く安売りして何とかすることでした。前日にでも数量が分かればいいのですが、当日出荷の時に紙の伝票でしか分からず、あたふたすることがあった。

　問題の原因は、農家と連絡を取る方法がないことでした。また数件の農家ではなく、20～30名または、300名ほどのグループなどもあり、把握することが事実上不可能でした。

　そこで今回出荷をネットで登録できるようにし事前にJA側で数量の総数を把握できれば、この問題を解決することができるのではないかと考えテーマに選びました。

　またAIを活用して農家ごとの生育状態の推移を計算し、出荷予測を立てる。また生育状態の葉や茎、花の状態などから収穫まで〇〇日などの予測を立てられるように機能の追加をしていきたいと考えています。

### ターゲットユーザ
- 農家
- 農業会社（管理者）

### 主な利用シーン
- 出荷をする前日までに登録
- これまでの出荷履歴を確認
- 農業会社
- 明日の出荷状況（総数の確認）
- 販売方法の検討・計画（販路確保）
- 前年の販売進捗や今後の戦略立案

## 動作見本


![new5.gif](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/1514036/ac890c06-7ed2-3f7a-7370-7673dd7585d9.gif)

![new6.gif](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/1514036/aec6d0e3-e39d-212f-8435-88837faf5df5.gif)



## 開発環境
- 言語：HTML,CSS,JavaScript,Ruby
- フレームワーク：Ruby on Rails
- JSライブラリ：jQuery
- IDE：Cloud9
- Vision AI
- 使用gem

###技能面
- サーバーサイド言語：Ruby
- インフラ：AWS
- ソース管理：Git
- フロント周り：HTML,css,js

###テスト面
- Rubyでのテストコードを記述するために、
  Rspecを使用しました。
- コードの検査として、rubocopを使用しました。


###使用gemの紹介
今後使用する可能性のあるgemにも挑戦し導入してみました。
- PDFを出力できる機能を実装するため'prawn'を使用
- factorybot

フロント周りでは、
- Jquery
- Bootstrap を使用

以下はその他使用したgemになります。

```
gem 'axlsx_rails'
gem 'bootstrap', '~> 4.5'
gem 'bullet'
gem 'chart-js-rails', '~> 0.1.4'
gem 'devise'
gem 'devise-i18n'
gem 'devise-i18n-views'
gem 'dotenv-rails'
gem 'font-awesome-sass', '~> 5.13'
gem 'geocoder'
gem 'gon'
gem 'google-cloud-vision'
gem 'jquery-rails'
gem 'kaminari', '~> 1.2.1'
gem 'rails-i18n'
gem 'refile', require: 'refile/rails', github: 'manfe/refile'
gem 'refile-mini_magick'
gem 'refile-s3'
gem 'rubocop'
gem 'toastr-rails'
gem 'prawn'
gem 'prawn-table'

```


## 設計書
![出荷予約登録システム.jpg](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/1514036/89ef5549-2076-5ab6-8299-3f048c3898d3.jpeg)

農家側
![agris生産者側.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/1514036/9c6e2ffd-b326-aab7-40a4-4926de399c7c.png)

管理者側
![agris管理者側.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/1514036/5a1cb6c8-1283-d2ef-c206-3e6862bece12.png)

テーブル定義書
![テーブル定義書.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/1514036/66382cbf-83f4-5fc1-9c76-78c63dc1af6b.png)

フロー図
![agris管理者側フロー図.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/1514036/a161f4a3-c5be-1625-5b90-8150b0b910f3.png)

![agris生産者側フロー図.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/1514036/8b2bacd1-54aa-1a5f-47e4-febe7cccb6ef.png)

ER図
![ER図.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/1514036/cf7eb77e-8143-91b2-e38e-63beb45e0019.png)

アプリケーション詳細設計
![アプリケーション詳細設計.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/1514036/62e30a86-d021-21a8-1836-14cd527d0337.png)