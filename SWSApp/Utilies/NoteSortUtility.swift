//
//  NoteSortUtility.swift
//  SWSApp
//
//  Created by shubham.e.shukla on 5/1/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation
class NoteSortUtility {
    
    static func sortByNoteTitleAlphabetically(notesListToBeSorted:[AccountNotes], ascending:Bool)->[AccountNotes]
    {
        
        var alphabeticallySortedNotesList = [AccountNotes]()
        if(ascending == true)
        {
            alphabeticallySortedNotesList = notesListToBeSorted.sorted { $0.name.lowercased() < $1.name.lowercased() }
        }
        else
        {
            alphabeticallySortedNotesList = notesListToBeSorted.sorted { $1.name.lowercased() < $0.name.lowercased() }
        }
        
        
        return alphabeticallySortedNotesList
}
    
        static func sortAccountsByNotesDateModified(accountNotesToBeSorted: [AccountNotes], ascending: Bool) -> [AccountNotes]{
    
            var dateSortedNotesList = [AccountNotes]()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-mm-dd"
    
            if(ascending == true) {
                dateSortedNotesList = accountNotesToBeSorted.sorted(by:{ dateFormatter.date(from: $0.lastModifiedDate)?.compare(dateFormatter.date(from :$1.lastModifiedDate)!) == .orderedAscending })
            } else {
                dateSortedNotesList = accountNotesToBeSorted.sorted(by:{ dateFormatter.date(from :$0.lastModifiedDate)?.compare(dateFormatter.date(from :$1.lastModifiedDate)!) == .orderedDescending })
            }
        return dateSortedNotesList
        }
}
