# BASICS_Realm

# RealmSwiftに保存されたデータの可視化

1 . Realm Browser：AppleStoreからインストール  
* ファイルを開こうとすると「please enter a valid encryption key for this realm file」と表示され開けない.

2 . Realm Studio：公式サイトからインストール  
* 問題なくRealmSwiftの中身を見ることができたので, こちらを採用する.  
    * A . [Realm studio公式サイト](https://docs.mongodb.com/realm-legacy/jp/products/realm-studio.html)からRealm Studioをダウンロードしてインストール.  
    * B . [こちらの記事](https://qiita.com/i_nak/items/5d6062333b205275b85b)を参考にRealmファイルを探す.  
    * C . 見つけたRealmファイルをRealmStudioで開く.  

* メモ書き(シュミレーターの場合)  
まず, 以下のコードをプロジェクトに記載して実行.
```
print(Realm.Configuration.defaultConfiguration.fileURL!)
```
そうすると, xcodeのデバッグコンソールに以下の形で出力が得られる.
```
file:///Users/・・・/・・・/default.realm
```
ここから, 以下の部分だけをコピペする.
```
/Users/・・・/・・・/
```
コマンドラインでやっても良いし, Finderで移動しても良い.
```
cd /Users/・・・/・・・/ or Finder>移動>/Users/・・・/・・・/>
```
そして, default.realmをRealm Studioで開くことでDBをRealmの中身を見ることができる.
