//
//  Notes.swift
//  SWSApp
//
//  Created by Jagadeeshwar Reddy on 18/04/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation
import UIKit
import SwipeCellKit

class NotesTableViewCell : SwipeTableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
}

class NotesViewController : UIViewController {
    
    var tableViewData = NSMutableArray()
    var accountNotesArray = [AccountNotes]()
    var accNotesViewModel = AccountsNotesViewModel()
    var accountId : String!
    var notesArray = [AccountNotes]()
    var notesDataToEdit: AccountNotes!
    
//   // var notesDict = [
//        ["title" : "Visit: Crown Liquor Store One", "date": "Today","time" : "10:30AM","description" : "Hello 1"],
//        ["title" : "aLorem Ipsum dolor sit", "date": "March 30th 2018","time" : "10:30AM","description" : "Hello 2 "],
//        ["title" : "dLorem Ipsum dolor sit", "date": "March 30th 2018","time" : "10:30AM","description" : "Hello 3"],
//        ["title" : "bLorem Ipsum dolor sit", "date": "March 30th 2018","time" : "10:30AM","description" : "Hello 4"],
//        ["title" : "dLorem Ipsum dolor sit", "date": "March 30th 2018","time" : "10:30AM","description" : "Hello 5"]]
    
    
    @IBOutlet weak var notesTableView : UITableView?
    
    
    //MARK:- ViewLifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        accountNotesArray = accNotesViewModel.accountsNotesForUser()
        for accNotes in accountNotesArray {
            if(accNotes.accountId == self.accountId) {
                notesArray.append(accNotes)               
            }
            //filtered array of notes related to my notes
             print("Notes Array \(notesArray)")
        }
        
        

//        for item in notesDict{
//            tableViewData.add(item)
//        }
        print(tableViewData)
        if(sendDataToTable.addDataToArray != -1){
            sendDataToTable.addDataToArray = -1
            tableViewData.add(sendDataToTable.dataDictionary)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    //MARK:- Sort Actions
    @IBAction func sortByNotesTitle(_ sender: Any) {
        
    }
    
    @IBAction func sortByDate(_ sender: Any) {
        
    }
    
    //MARK:- Segue connection
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "createNoteSegue" {
            let createNoteScreen = segue.destination as! CreateNoteViewController
            createNoteScreen.notesToEdit = notesDataToEdit
            createNoteScreen.isAddingNewNote = false
        }
        
        if segue.identifier == "editNotesSegue" {
            let editNoteScreen = segue.destination as! EditNoteViewController
            editNoteScreen.notesToBeEdited = notesDataToEdit
        }
    }
    
    
    
}
//MARK:- UITable view Delegate and Datasource,SwipeTableViewCellDelegate
extension NotesViewController :UITableViewDelegate,UITableViewDataSource,SwipeTableViewCellDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "notesTitleCellIdentifier", for: indexPath) as! NotesTableViewCell
        
        cell.delegate = self
        cell.selectionStyle = .none
        let notes = notesArray[indexPath.row]
        cell.titleLabel?.text = notes.name
        
      //  cell.timeLabel?.text  = notes.
        
        let serverDate = notes.lastModifiedDate
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000+0000"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let date = dateFormatter.date(from: serverDate)// create date from string
        
        // change to a readable time format and change to local time zone
        dateFormatter.dateFormat = "MM/dd/YYYY h:mma"
        dateFormatter.timeZone = TimeZone.current
        let timeStamp = dateFormatter.string(from: date!)
        
        var dateTime = timeStamp.components(separatedBy: " ")
        cell.dateLabel?.text  = dateTime[0]
        cell.timeLabel?.text = dateTime[1]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0;
    }
    
    //MARK:- Table view on Swipe EDIT and DELETE actions
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        
        guard orientation == .right else { return nil }
        
        let editAction = SwipeAction(style: .default, title: "Edit") {action, indexPath in
            self.notesDataToEdit = self.notesArray[indexPath.row]
            self.performSegue(withIdentifier: "createNoteSegue", sender: nil)
        }
        editAction.image = UIImage(named:"editIcon")
        editAction.backgroundColor = UIColor(named:"InitialsBackground")
        
        let deleteAction = SwipeAction(style: .default, title: "Delete") {action, indexPath in
            let cell = tableView.cellForRow(at: indexPath) as! NotesTableViewCell
            let closure: (UIAlertAction) -> Void = { _ in cell.hideSwipe(animated: true) }
            let alert = UIAlertController(title: "Notes Delete", message: "Are you sure you want to delete?", preferredStyle: UIAlertControllerStyle.alert)
            let continueAction = UIAlertAction(title: "Delete", style: .default) { action in
                // Handle when button is clicked
                //self.tableViewData.removeObject(at: indexPath.row)
                self.notesArray.remove(at: indexPath.row)
                self.notesTableView?.reloadData()
                //tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
            }
            alert.addAction(continueAction)
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: closure))
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
        }
        deleteAction.image = UIImage(named:"deletX")
        deleteAction.backgroundColor = UIColor(named:"InitialsBackground")
        return [deleteAction, editAction]
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeTableOptions {
        var options = SwipeTableOptions()
        options.transitionStyle = .border
        return options
    }
    
    //MARK:- Custom header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notesSortCellID")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0;
    }

    //MARK:- On select row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        notesDataToEdit = notesArray[indexPath.row]
        self.performSegue(withIdentifier: "editNotesSegue", sender: nil)
        
        //        (vc as! EditNoteViewController).displayDictdata(name: tableViewData as! [Dictionary<String, String>], index: indexPath.row)
    }
    
}
