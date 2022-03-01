//
//  AkisViewController.swift
//  InstagramCloneFirebase
//
//  Created by Nihat on 27.02.2022.
//

import UIKit
import Firebase
import SDWebImage

class AkisViewController: UIViewController , UITableViewDelegate , UITableViewDataSource{
    
    var emailArray = [String]()
    var likeArray = [Int]()
    var commentArray = [String]()
    var imageArray = [String]()
    var documentIdArray = [String]()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        getDataFromFirebase()
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! AkisCell
        cell.emailLabel.text = emailArray[indexPath.row]
        cell.postImageView.sd_setImage(with: URL(string: imageArray[indexPath.row]))
        cell.commentLabel.text = commentArray[indexPath.row]
        cell.likeLabel.text = String(likeArray[indexPath.row])
        cell.documentIdLabel.text = documentIdArray[indexPath.row]
        return cell
    }
    
    func getDataFromFirebase(){
        
        let firestoreDatabase = Firestore.firestore()
        firestoreDatabase.collection("Posts").order(by: "date", descending: true).addSnapshotListener { snapshot, error in
            if error != nil {
                self.makeAlert(titleInput: "Hata", messageInput: error?.localizedDescription ?? "Akış yüklenemedi.")
            }else{
                if snapshot?.isEmpty != true {
                    self.emailArray.removeAll(keepingCapacity: false)
                    self.imageArray.removeAll(keepingCapacity: false)
                    self.commentArray.removeAll(keepingCapacity: false)
                    self.likeArray.removeAll(keepingCapacity: false)
                    self.documentIdArray.removeAll(keepingCapacity: false)
                    
                    for document in snapshot!.documents {
                        let documentId = document.documentID
                        self.documentIdArray.append(documentId)
                        
                        if let postedBy = document.get("postedBy") as? String{
                            self.emailArray.append(postedBy)
                        }
                        if let like = document.get("likes") as? Int{
                            self.likeArray.append(like)
                        }
                        if let comment = document.get("postComment") as? String{
                            self.commentArray.append(comment)
                        }
                        if let imageUrl = document.get("imageUrl") as? String {
                            self.imageArray.append(imageUrl)
                        }
                    }
                    self.tableView.reloadData()
                    
                }
            }
        }
    }
    func makeAlert(titleInput :String , messageInput : String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
}
