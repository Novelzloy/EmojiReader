//
//  EmojiTableViewCell.swift
//  EmojiReader
//
//  Created by Роман on 18.04.2021.
//

import UIKit

class EmojiTableViewCell: UITableViewCell {

    
    @IBOutlet weak var emojiLable: UILabel!
    @IBOutlet weak var descriptionLable: UILabel!
    @IBOutlet weak var nameLable: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func set(object: Emoji) {
        self.nameLable.text = object.name
        self.descriptionLable.text = object.description
        self.emojiLable.text = object.emoji
    }

     

}
