//
//  Contact.swift
//  SWSApp
//
//  Created by maria.min-hui.yu on 3/25/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import Foundation

class Contact {
    
    // Static data for Southern Glazer's Contact TableView
    let contactNameArray = ["Devin Miller","Alice Stewert","Ciera Morales","Tasha Howell","Keaton Mckinney","Tiffany Mccarthy"]
    let contactArray    =   ["1236432465","5565789036","3412456677","67673876277","1237645672","58754234456"]
    let contactEmailArray  = ["Devin@abc.com","Alice@bbc.com","Ciera@ccd.com","Tasha@eec.com","Keaton@ffc.com","Tiffany@ggc.com"]
    var southernInitialArray:[String] = []
    
    // Static data for Crown Liquor Contacts TableView
    let crownNameArray = ["Daniel Brown","Cory Gutierrez","Lawrence Sherman"]
    let crownContactArray    =   ["67673876277","1237645672","58754234456"]
    let crownEmailArray  = ["daniel@eec.com","cory@ffc.com","lawrence@ggc.com"]
    var crownInitialArray:[String] = []
    
    //TODO: SHUBHAM No warning must be introduced
    /// Function to get First letters of the Name Label for southern contacts
    func gettingSouthernIntials(){
        for  var i in 0...(contactNameArray.count)-1 {
            
            var initials = contactNameArray[i].components(separatedBy: " ").reduce("") { ($0 == "" ? "" : "\($0.first!)") + "\($1.first!)" }
            
             southernInitialArray.append(initials)
          
           
        }
    }
    
    
    //TODO: SHUBHAM make a common function to handel initails and put in it unitility mentod crea a static method so can be used else were.
    /// Function to get initial Label for crown store contacts
    func gettingCrownsIntials(){
        for  var i in 0...(crownNameArray.count)-1 {
            
            var initials = crownNameArray[i].components(separatedBy: " ").reduce("") { ($0 == "" ? "" : "\($0.first!)") + "\($1.first!)" }
            crownInitialArray.append(initials)
            
        }
    }
}
