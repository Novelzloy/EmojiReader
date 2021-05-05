//
//  CustomTableViewController.swift
//  EmojiReader
//
//  Created by Роман on 16.04.2021.
//

import UIKit

class CustomTableViewController: UITableViewController {

    var objects = [
        Emoji(emoji: "🥰", name: "Love", description: "Let's love each other", isFavorite: false),
        Emoji(emoji: "⚽️", name: "Soccer", description: "Let's play soccer together", isFavorite: false),
        Emoji(emoji: "🐱", name: "Cat", description: "Cat is the cutest animal", isFavorite: false)]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Emoji Reader"
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    @IBAction func unwindSegue(segue: UIStoryboardSegue){
        guard segue.identifier == "saveSegue" else { return }
        let sourceVC = segue.source as! NewEmojiTableViewController
        let emoji = sourceVC.emoji
        
        if let selectedindexPath = tableView.indexPathForSelectedRow{
            objects[selectedindexPath.row] = emoji
            tableView.reloadData()
        } else {
            let newIndexPath = IndexPath(row: objects.count, section: 0)
            objects.append(emoji)
            tableView.insertRows(at: [newIndexPath], with: .fade)
        }
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return objects.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "editEmoji" else { return }
        let indexPath = tableView.indexPathForSelectedRow!
        let emoji = objects[indexPath.row]
        let navigationVC = segue.destination as! NewEmojiTableViewController
//        let barButtonItem = UIBarButtonItem()
//        barButtonItem.title = "Edit"
        navigationVC.emoji = emoji
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "emojiCell", for: indexPath) as! EmojiTableViewCell
        let object = objects[indexPath.row]
        cell.set(object: object)

        return cell
    }

    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            objects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedEmoji = objects.remove(at: sourceIndexPath.row)
        objects.insert(movedEmoji, at: destinationIndexPath.row)
        tableView.reloadData()
    }
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let favorite = favoriteActions(at: indexPath)
        let doneAction = addAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [doneAction, favorite])
    }
    
    func addAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction (style: .destructive , title:"Done") { (action, view, completion) in
            self.objects.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic )
            completion(true)
        }
        action.backgroundColor = .systemBlue
        action.image = UIImage(systemName: "checkmark")
        return action
    }
    
    func favoriteActions(at indexPath: IndexPath) -> UIContextualAction {
        var object = objects[indexPath.row]
        let action = UIContextualAction(style: .normal, title: "Favorite") { (action, view, completion) in
            object.isFavorite = !object.isFavorite
            self.objects[indexPath.row] = object
            completion(true)
        }
        action.backgroundColor = object.isFavorite ?  .systemPurple : .systemGray
        action.image = UIImage(systemName: object.isFavorite ? "suit.heart.fill" : "suit.heart")
//        if object.isFavorite == true{
//            action.image = UIImage(systemName: "suit.heart.fill")
//        } else {
//            action.image = UIImage(systemName: "suit.heart")
//        }

        return action
    }
}
