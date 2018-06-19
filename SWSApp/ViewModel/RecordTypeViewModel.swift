//
//  RecordTypeViewModel.swift
//  SWSApp
//
//  Created by manu.a.gupta on 19/06/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation

class RecordTypeViewModel {
    func getRecordTypeForDeveloper() -> [RecordType] {
        let recordTypeArray = StoreDispatcher.shared.fetchRecordTypeForDeveloperName()
        return recordTypeArray
    }
}

