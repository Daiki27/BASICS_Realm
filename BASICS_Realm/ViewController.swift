//
//  ViewController.swift
//  BASICS_Realm
//
//  Created by 樋口大樹 on 2021/04/04.
//

import UIKit
import RealmSwift

class ViewController: UIViewController,UITextFieldDelegate{
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Realmのインスタンスを取得
        let realm = try! Realm()
        //全件取得する.
        let animal = realm.objects(Animal.self)
        for animalData in animal{
            label.text = animalData.name
            print(animalData)
        }
        //入力してEnter押したときのために.
        textField.delegate = self
        
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
    }
}
