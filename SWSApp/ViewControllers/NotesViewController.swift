//
//  Notes.swift
//  SWSApp
//
//  Created by Jagadeeshwar Reddy on 18/04/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation
import UIKit

class NotesTableViewCell : UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
}


class NotesViewController : UIViewController{
    
    var notesDict = [
        ["title" : "Visit: Crown Liquor Store One", "date": "Today","time" : "10:30AM","description" : "Hello 1"],
        ["title" : "Lorem Ipsum dolor sit", "date": "March 30th 2018","time" : "10:30AM","description" : "Hello 2 "],
        ["title" : "Lorem Ipsum dolor sit", "date": "March 30th 2018","time" : "10:30AM","description" : "Hello 3"],
        ["title" : "Lorem Ipsum dolor sit", "date": "March 30th 2018","time" : "10:30AM","description" : "Hello 4"],
        ["title" : "Lorem Ipsum dolor sit", "date": "March 30th 2018","time" : "10:30AM","description" : "Hello 5"]]
    //MARK:- ViewLifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //var todayDate = Date()
        //print(todayDate)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
}
//MARK:- UITable view Delegate and Datasource
extension NotesViewController :UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesDict.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notesTitleCellIdentifier", for: indexPath) as! NotesTableViewCell
        cell.selectionStyle = .none
        let notes = notesDict[indexPath.row]
        cell.titleLabel?.text = notes["title"]!
        cell.dateLabel?.text  = notes["date"]!
        cell.timeLabel?.text  = notes["time"]!
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0;
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        //  let editButton = UIButton( type: .system)
        let editRowAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "Edit", handler:{action, indexpath in
            let notes = self.notesDict[indexPath.row]
            let storyboard: UIStoryboard = UIStoryboard(name: "Notes", bundle: nil)
            let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: "EditNoteID") as! EditNoteViewController
            self.present(vc, animated: true, completion: nil)
            (vc as! EditNoteViewController).displayEditNoteData(title: notes["title"]!, date: notes["date"]!, description: notes["description"]!)
            print("EDIT•ACTION");
        });
        //editRowAction.view
        editRowAction.backgroundColor = UIColor(named:"InitialsBackground")
        
        let deleteRowAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "Delete", handler:{action, indexpath in
            // create the alert
            let alert = UIAlertController(title: "NotesDelete", message: "Would you like to delete current selected note?", preferredStyle: UIAlertControllerStyle.alert)
            let continueAction = UIAlertAction(title: "Continue", style: .default) { action in
                // Handle when button is clicked
                self.notesDict.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
            }
            alert.addAction(continueAction)
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
            print("DELETE•ACTION");
        });
        deleteRowAction.backgroundColor = UIColor(named:"InitialsBackground")
        return [deleteRowAction, editRowAction];
    }
    
    //Custom header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notesSortCellID")
        return cell
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0;
    }
    
}
