# BASICS_Realm

### RealmSwiftに保存されたデータの可視化
***
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

### Realm Documentation | [Realm Official](https://docs.mongodb.com/realm-legacy/jp/docs/swift/latest.html)  
***
* ①オブジェクトの消去  
クエリ(データベースからデータを抽出したり操作したりといった処理を行うための命令)の扱いが重要になる.
```
//Realmに保存されている全オブジェクトの削除.
try! realm.write {
  realm.deleteAll()
}

//Realmに保存されているAnimalクラスのオブジェクトの削除.
let dogObject = realm.objects(Animal.self).filter("name=='Dog'")
try! realm.write {
 realm.delete(dogObject)
}
```

* ②コレクションクラス：Results
> RealmにはRealmオブジェクトの集合を扱うためのクラスが複数あります。それらを総称して”Realmコレクションクラス”と呼びます。
> Results、クエリを用いて取得したオブジェクトを表します。  

例えば, 以下のコードの実行結果を見ると, Results<Animal>となっていると確認できる.
```
let objects = realm.objects(Animal.self)
print(object)
//実行結果.
Results<Animal> <0x7fbb22c08ee0> (
[0] Animal {
   name = Cat;
},
[1] Animal {
   name = Dog;
},
[2] Animal {
   name = Bird;
})

print(type(of: object))
//実行結果.
Results<Animal>
```
コレクションクラスResultsは以下のように宣言する.
```
var animalItem: Results<Animal>!
//使えるメンバは以下のとおり.
animalItem.count // 件数を返す.
animalItem[0]    // 1行目のコンテンツを返す.
```
