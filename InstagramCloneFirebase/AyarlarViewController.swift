//
//  AyarlarViewController.swift
//  InstagramCloneFirebase
//
//  Created by Nihat on 27.02.2022.
//

import UIKit
import Firebase

class AyarlarViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func logOutClicked(_ sender: Any) {
        
        do{
            try Auth.auth().signOut()
            performSegue(withIdentifier: "toViewController", sender: nil)
        }catch{
            makeAlert(titleInput: "Hata", messageInput: "Çıkış Yapılamadı.")
        }
    }
    
    func makeAlert(titleInput : String , messageInput : String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
}
