//
//  ContactListDetailsTableViewCell.swift
//  SWSApp
//
//  Created by shubham.e.shukla on 4/21/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit
protocol ContactListDetailsTableViewCellDelegate: NSObjectProtocol {
    func editContactButtonTapped()
}

class ContactListDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var initialNameLabel: UILabel!
    @IBOutlet weak var nameValueLabel: UILabel!
    @IBOutlet weak var phoneValueLabel: UILabel!
    @IBOutlet weak var emailValueLabel: UILabel!

    @IBOutlet weak var editContactButton: UIButton!

    @IBOutlet weak var preferredNameValueLabel: UILabel!
    @IBOutlet weak var titleValueLabel: UILabel!
    @IBOutlet weak var departmentValueLabel: UILabel!
    @IBOutlet weak var faxValueLabel: UILabel!
    @IBOutlet weak var contactHoursValueLabel: UILabel!

    @IBOutlet weak var birthdayValueLabel: UILabel!
    @IBOutlet weak var weddingValueLabel: UILabel!
    @IBOutlet weak var child1ValueLabel: UILabel!
    @IBOutlet weak var child2ValueLabel: UILabel!
    @IBOutlet weak var child3ValueLabel: UILabel!
    @IBOutlet weak var child4ValueLabel: UILabel!
    @IBOutlet weak var child5ValueLabel: UILabel!
    @IBOutlet weak var likesValueLabel: UILabel!
    @IBOutlet weak var dislikesValueLabel: UILabel!
    @IBOutlet weak var favoriteActivitiesValueLabel: UILabel!

    @IBOutlet weak var preferredContactMethodValueLabel: UILabel!
    @IBOutlet weak var notesValueLabel: UILabel!
    weak var delegate: ContactListDetailsTableViewCellDelegate!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        initialNameLabel.layer.cornerRadius = initialNameLabel.frame.size.width/2
        initialNameLabel.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func displayCellContent(_ contactDetails: Contact) {
        
        displayFirstRowCellContent(contactDetails)
        displaySecondRowCellContent(contactDetails)
        displayThirdRowCellContent(contactDetails)
        displayFourthRowCellContent(contactDetails)
        
    }
    
    func displayFirstRowCellContent(_ contactDetails: Contact) {
        
        let fullName = contactDetails.firstName + " " + contactDetails.lastName
        initialNameLabel.text = contactDetails.getIntials(name: fullName)
        nameValueLabel.text = fullName
        phoneValueLabel.text = contactDetails.phoneNumber
        emailValueLabel.text =  contactDetails.email

    }

    func displaySecondRowCellContent(_ contactDetails: Contact) {
        
        preferredNameValueLabel.text = contactDetails.preferredName
        titleValueLabel.text = contactDetails.title
        departmentValueLabel.text = contactDetails.department
        faxValueLabel.text = contactDetails.fax
        contactHoursValueLabel.text =  contactDetails.contactHours
        
    }

    func displayThirdRowCellContent(_ contactDetails: Contact) {
        
        displayEventContent(birthdayValueLabel, textToDisply: "Birthday", dateString: contactDetails.birthDate)
        displayEventContent(weddingValueLabel, textToDisply: "Anniversary", dateString: contactDetails.anniversary)
        
        displayChildContent(child1ValueLabel, textToDisply: contactDetails.child1Name, dateString: contactDetails.child1Birthday)
        displayChildContent(child2ValueLabel, textToDisply: contactDetails.child2Name, dateString: contactDetails.child2Birthday)
        displayChildContent(child3ValueLabel, textToDisply: contactDetails.child3Name, dateString: contactDetails.child3Birthday)
        displayChildContent(child4ValueLabel, textToDisply: contactDetails.child4Name, dateString: contactDetails.child4Birthday)
        displayChildContent(child5ValueLabel, textToDisply: contactDetails.child5Name, dateString: contactDetails.child5Birthday)

        likesValueLabel.text = contactDetails.likes
        dislikesValueLabel.text = contactDetails.dislikes
        favoriteActivitiesValueLabel.text = contactDetails.favouriteActivities
        
    }
    
    func displayEventContent(_ labelToDisplay: UILabel, textToDisply: String, dateString: String) {
        
        labelToDisplay.text = ""
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(identifier:"UTC")
        
        if let date: Date = dateFormatter.date(from: dateString) {
//            dateFormatter.dateFormat = "MMM d, yyyy"
            dateFormatter.dateFormat = "MM/dd/yyyy"
//            labelToDisplay.text = dateFormatter.string(from: date) + " (" + textToDisply + ")"
            labelToDisplay.text = dateFormatter.string(from: date)
        }
        
    }
    
    func displayChildContent(_ labelToDisplay: UILabel, textToDisply: String, dateString: String) {
        
        labelToDisplay.text = ""
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(identifier:"UTC")
        
        if let date: Date = dateFormatter.date(from: dateString) {
//            labelToDisplay.text = textToDisply + " (" + String(date.age) + ")"
            dateFormatter.dateFormat = "MM/dd/yyyy"
            labelToDisplay.text = textToDisply + " (" + dateFormatter.string(from: date) + ")"
        }
        
    }
    
    func displayFourthRowCellContent(_ contactDetails: Contact) {
        
        preferredContactMethodValueLabel.text = contactDetails.preferredCommunicationMethod
        notesValueLabel.text = contactDetails.sgwsNotes
        
    }
    
    @IBAction func editContactButtonTapped(_ sender: UIButton){
        self.delegate.editContactButtonTapped()
    }
    
}
