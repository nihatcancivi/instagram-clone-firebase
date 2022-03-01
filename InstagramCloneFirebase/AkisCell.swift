//
//  AkisCell.swift
//  InstagramCloneFirebase
//
//  Created by Nihat on 1.03.2022.
//

import UIKit
import Firebase

class AkisCell: UITableViewCell {

    @IBOutlet weak var documentIdLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func likeButtonClicked(_ sender: Any) {
        
        let fireStoreDatabase = Firestore.firestore()
              if let likeCount = Int(likeLabel.text!) {
                  let likeStore = ["likes" : likeCount + 1] as [String : Any]
                  fireStoreDatabase.collection("Posts").document(documentIdLabel.text!).setData(likeStore, merge: true)
              }
    }
}
