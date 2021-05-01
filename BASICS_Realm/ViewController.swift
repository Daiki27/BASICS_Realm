//
//  ViewController.swift
//  BASICS_Realm
//
//  Created by 樋口大樹 on 2021/04/04.
//

import UIKit
import RealmSwift

class ViewController: UIViewController,UITextFieldDelegate,UITableViewDataSource{

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var deleteAllDateButton: UIButton!
    @IBOutlet weak var deleteSpecificDateButton: UIButton!
    @IBOutlet weak var animalTableView: UITableView!
    
    var todoItem: Results<Animal>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animalTableView.dataSource = self
        animalTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        //Realmのインスタンスを取得
        let realm = try! Realm()
        //全件取得する.
        let animal = realm.objects(Animal.self)
        print(animal)
        print(type(of: animal))
        for animalData in animal{
            label.text = animalData.name
            //print(animalData)
        }
        // 永続化されているデータを取りだす
        do{
            let realm = try Realm()
            todoItem = realm.objects(Animal.self)
        }catch{
        }
        //入力してEnter押したときのために.
        textField.delegate = self
        print(Realm.Configuration.defaultConfiguration.fileURL!)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //入力してEnter押すとキーボードが閉じる.
        label.text = textField.text
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func saveButton(_ sender: UIButton) {
        //データベースにデータを保存する.
        let animal = Animal()
        animal.name = textField.text
        label.text = animal.name
        
        let realm = try! Realm()
        try! realm.write {
            print("Success!")
            realm.add(animal)
        }
        animalTableView.reloadData()
    }
    
    @IBAction func deleteAllDate(_ sender: UIButton){
        let realm = try! Realm()
        try! realm.write {
          realm.deleteAll()
        }
    }
    
    @IBAction func deleteSpecificDate(_ sender: UIButton){
        let realm = try! Realm()
        let dogObject = realm.objects(Animal.self).filter("name=='Dog'")
        try! realm.write {
          realm.delete(dogObject)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)->Int {
        //セルの個数はDBに保存されている個数を指定する.
        print("A",todoItem.count)
        return todoItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //再利用できるcellを探索し, そのセルに表示したいコンテンツを渡し, そのセルを返すメソッド.
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        let object = todoItem[indexPath.row]
        //print(indexPath)
        //print(indexPath.row)
        //print(object)
        //print(type(of: object))
        cell.textLabel?.text = object.name
        return cell
    }
}
