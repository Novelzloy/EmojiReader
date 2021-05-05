//
//  NewEmojiTableViewController.swift
//  EmojiReader
//
//  Created by Роман on 25.04.2021.
//

import UIKit

class NewEmojiTableViewController: UITableViewController {
    
    var emoji = Emoji(emoji: "", name: "", description: "", isFavorite: false)
    
    
    @IBOutlet weak var emojiTF: UITextField!
    @IBOutlet weak var descriptionTF: UITextField!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        updateSaveButtonState()

    }
    
    private func updateSaveButtonState(){
        let emojiText = emojiTF.text ?? ""
        let nameText = nameTF.text ?? ""
        let descriptionText = descriptionTF.text ?? ""
        
        saveButton.isEnabled = !emojiText.isEmpty && !nameText.isEmpty && !descriptionText.isEmpty
        
    }
    
    private func updateUI(){
        emojiTF.text = emoji.emoji
        nameTF.text = emoji.name
        descriptionTF.text = emoji.description
    }

    @IBAction func textChange(_ sender: UITextField) {
        updateSaveButtonState()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "saveSegue" else { return }
        let emoji = emojiTF.text ?? ""
        let name = nameTF.text ?? ""
        let description = descriptionTF.text ?? ""
        
        self.emoji = Emoji(emoji: emoji, name: name, description: description, isFavorite: self.emoji.isFavorite)
    }

}
