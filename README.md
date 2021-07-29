# Agris　出荷登録システムアプリケーション
- トップ画像
![最終トップ.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/1514036/f39f100b-597d-8c22-7a13-f536168d39c4.png)
- ロゴイメージ
![agris.logo.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/1514036/54b8c8b3-306b-c0c7-77b2-93f68fdae01e.png)

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

- 投稿後/便利機能

<iframe width="560" height="315" src="https://www.youtube.com/embed/zFlzQ2c_Ji0" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>



## 開発環境
- 言語：HTML,CSS,JavaScript,Ruby
- フレームワーク：Ruby on Rails
- JSライブラリ：jQuery
- IDE：Cloud9
- Vision AI
- 使用gem

## 技能面
- サーバーサイド言語：Ruby
- インフラ：AWS
- ソース管理：Git
- フロント周り：HTML,css,js

## テスト面
- Rubyでのテストコードを記述するために、
  Rspecを使用しました。
- コードの検査として、rubocopを使用しました。

## チャレンジ要素一覧
| 項目   |     機能名      | 　概要　　　　　　 |
| :--- | :-----------: | -------: |
| HTML/CSS    　　| Flexbox | レイアウトを整えるのに導入 |
| Ruby on Rails　 | デバック|　binding.pry　|
|Ruby on Rails|	テスト(単体/正常・異常)|	結合テストをRSpecで実装予定|
|Ruby on Rails|	CRUD|resorcesメソッド|
|Ruby on Rails|	ユーザー認証|devise|
|Ruby on Rails|	画像アップロード|画像アップロード|
|その他|デプロイ|EC2, RDS, GitHub Actions|
|その他|	リーダブルコード|Rubocopを利用|
|その他|	README|マークダウン形式で記入|
|Ruby on Rails|	環境変数化|GitHubに公開したくない変数や値を隠してpushする方法 dotenv-rails,bash_profile|
|JavaScript(その他)|	データ可視化|de.js|
|その他|	地図表示|GoogleMapAPI  地図の検索機能|
|Ruby on Rails(その他)|	検索|検索機能（生産者の検索に使用）|
|その他|	N+1問題|bulletの活用でN+1の箇所を修正|


## 使用gemの紹介
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

ER図
![ER図.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/1514036/cf7eb77e-8143-91b2-e38e-63beb45e0019.png)