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

class NotesViewController : UIViewController,sendNotesDataToNotesDelegate, NavigateToNotesVCDelegate {

    var tableViewData = NSMutableArray()
    var accountNotesArray = [AccountNotes]()
    var accNotesViewModel = AccountsNotesViewModel()
    var notesArray = [AccountNotes]()
    var accountId : String!
    var notesDataToEdit: AccountNotes!
    var isSorting = false
    var isAscendingNotesName = false
    var isAscendingNotesDate = true
    //sort data to display
    var sortedNotesList = [AccountNotes]()
    var tableViewDisplayData = [AccountNotes]()
    var originalAccountNotesList = [AccountNotes]()
    
    @IBOutlet weak var notesTableView : UITableView?
    
    
    //MARK:- ViewLifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    NotificationCenter.default.addObserver(self, selector: #selector(self.refreshNotesList), name: NSNotification.Name("refreshNotesList"), object: nil)
        accountNotesArray = accNotesViewModel.accountsNotesForUser()
        tableViewDisplayData = accountNotesArray
        for accNotes in accountNotesArray {
            if(accNotes.accountId == self.accountId) {
                notesArray.append(accNotes)
            }
            //filtered array of notes related to my notes
            print("Notes Array \(notesArray)")
        }
        originalAccountNotesList = NoteSortUtility.sortAccountsByNotesDateModified(accountNotesToBeSorted: notesArray, ascending: false)
        tableViewDisplayData = originalAccountNotesList
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        notesTableView?.reloadData()
    }
    
    func displayAccountNotes() {
        accountNotesArray = accNotesViewModel.accountsNotesForUser()
        print(accountNotesArray)
        notesTableView?.reloadData()
    }
    
    func navigateToNotesViewController() {
        print("Reload the data")
    
        accountNotesArray = accNotesViewModel.accountsNotesForUser()
        for accNotes in accountNotesArray {
            if(accNotes.accountId == self.accountId) {
                notesArray.append(accNotes)
                
            }
            //filtered array of notes related to my notes
            print("Notes Array \(notesArray)")
            
        }
        notesTableView?.reloadData()
    }
    
    func noteCreated() {
 
        
    }
    
    func dismissEditNote() {
        print("NotesViewController:dismissEditNote")
    }
    
    //MARK:- Sort Actions
    @IBAction func sortByNotesTitle(_ sender: Any) {
        
        print("sortNotesListByNotesName")
        isSorting = true
        
            if isAscendingNotesName == true{
                isAscendingNotesName = false
                sortedNotesList = NoteSortUtility.sortByNoteTitleAlphabetically(notesListToBeSorted: notesArray, ascending: true)
            }
            else
            {
                isAscendingNotesName = true
                 sortedNotesList = NoteSortUtility.sortByNoteTitleAlphabetically(notesListToBeSorted: notesArray, ascending: false)
            }
        
        //self.accountListTableView.reloadData()
        self.updateTheTableViewDataAccordingly()
        
    }
    
    func updateTheTableViewDataAccordingly(){
        if(isSorting)
        {
            tableViewDisplayData = sortedNotesList
        }
        else
        {
            tableViewDisplayData = notesArray
        }
          notesTableView?.reloadData()
    }
    
    @IBAction func sortByDate(_ sender: Any) {
        print("sortNotesListByDatemodified")
        isSorting = true
        
        if isAscendingNotesDate == true{
            isAscendingNotesDate = false
            sortedNotesList = NoteSortUtility.sortAccountsByNotesDateModified(accountNotesToBeSorted: notesArray, ascending: true)
        }
        else
        {
            isAscendingNotesDate = true
            sortedNotesList = NoteSortUtility.sortAccountsByNotesDateModified(accountNotesToBeSorted: notesArray, ascending: false)
        }
        
        //self.accountListTableView.reloadData()
        self.updateTheTableViewDataAccordingly()
    }
    
    //MARK:- Segue connection
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "createNoteSegue" {
            let createNoteScreen = segue.destination as! CreateNoteViewController
            createNoteScreen.notesToEdit = notesDataToEdit
            createNoteScreen.isAddingNewNote = false
            createNoteScreen.sendNoteDelegate = self
            createNoteScreen.modalPresentationStyle = .overCurrentContext
        }
        
        if segue.identifier == "editNotesSegue" {
            let editNoteScreen = segue.destination as! EditNoteViewController
            editNoteScreen.notesToBeEdited = notesDataToEdit
            editNoteScreen.delegate = self
           
            
        }
    }
    
    @objc func refreshNotesList(notification: NSNotification){
        accountNotesArray = []
        notesArray = []
        accountNotesArray = accNotesViewModel.accountsNotesForUser()

        for accNotes in accountNotesArray {
            if(accNotes.accountId == self.accountId) {
                tableViewDisplayData.append(accNotes)
                
            }
            //filtered array of notes related to my notes
            print("Notes Array \(notesArray)")
            
        }
        notesTableView?.reloadData()

    
    }
    
}
//MARK:- UITable view Delegate and Datasource,SwipeTableViewCellDelegate
extension NotesViewController :UITableViewDelegate,UITableViewDataSource,SwipeTableViewCellDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewDisplayData.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "notesTitleCellIdentifier", for: indexPath) as! NotesTableViewCell
        
        cell.delegate = self
        cell.selectionStyle = .none
        let notes = tableViewDisplayData[indexPath.row]
        cell.titleLabel?.text = notes.name
        let serverDate = notes.lastModifiedDate
        if(serverDate != ""){
        let getTime = DateTimeUtility.convertUtcDatetoReadableDate(dateStringfromAccountNotes: serverDate)
        var dateTime = getTime.components(separatedBy: " ")
        if(dateTime.count > 0){
            cell.dateLabel?.text  = dateTime[0]
            cell.timeLabel?.text = dateTime[1]
        }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0;
    }
    
    //MARK:- Table view on Swipe EDIT and DELETE actions
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        
        guard orientation == .right else { return nil }
        
        let editAction = SwipeAction(style: .default, title: "Edit") {action, indexPath in
            
            self.notesDataToEdit = self.tableViewDisplayData[indexPath.row]
            self.performSegue(withIdentifier: "createNoteSegue", sender: nil)
        }
        editAction.hidesWhenSelected = true
        editAction.image = UIImage(named:"editIcon")
        editAction.backgroundColor = UIColor(named:"InitialsBackground")
        
        let deleteAction = SwipeAction(style: .default, title: "Delete") {action, indexPath in
            let cell = tableView.cellForRow(at: indexPath) as! NotesTableViewCell
            let closure: (UIAlertAction) -> Void = { _ in cell.hideSwipe(animated: true) }
            let alert = UIAlertController(title: "Notes Delete", message: StringConstants.deleteConfirmation, preferredStyle: UIAlertControllerStyle.alert)
            let continueAction = UIAlertAction(title: "Delete", style: .default) { action in
                // Handle when button is clicked
                //self.tableViewData.removeObject(at: indexPath.row)
                self.tableViewDisplayData.remove(at: indexPath.row)
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
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 25.0;
    }

    //MARK:- On select row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        notesDataToEdit = tableViewDisplayData[indexPath.row]
        self.performSegue(withIdentifier: "editNotesSegue", sender: nil)
        
        //        (vc as! EditNoteViewController).displayDictdata(name: tableViewData as! [Dictionary<String, String>], index: indexPath.row)
    }
    
}
