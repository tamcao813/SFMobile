//
//  ContactsViewController.swift
//  SWSApp
//
//  Created by shilpa.a.kulkarni on 26/03/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class AccountDetailTabViewController: UITableViewController {
    
    //use view models to get contacts data
    let userViewModel = UserViewModel()
    let contactViewModel = ContactsViewModel()
    var contactsWithBuyingPower = [Contact]()
    var contactsForSG = [Contact]()
    var account : Account?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //let loggerInUser = userViewModel.loggedInUser
        // Get the buying power contact for this account
        if let accountId = account?.account_Id {
            contactsWithBuyingPower = contactViewModel.contactsWithBuyingPower(forAccount: accountId)
            contactsForSG = contactViewModel.contactsForSG(forAccount: accountId)
        }
        //just testing globalContacts here
        let globalContactas = contactViewModel.globalContacts()
        print("globalContactas.count = " + "\(globalContactas.count)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Function to get the full address by adding all fields.
    func getFullAddress(headerCell:UITableViewCell) {
        if let acc = account{
            var fullAddress = ""
            if acc.shippingStreet == "" && acc.shippingCity == "" && acc.shippingState == "" && acc.shippingPostalCode == "" {
                fullAddress = acc.shippingStreet + " " + acc.shippingCity + " " + acc.shippingState +  " " + acc.shippingPostalCode
                
            }else{
                if (acc.shippingStreet != "" || acc.shippingCity != "") {
                    if (acc.shippingState != "" || acc.shippingPostalCode != "") {
                        fullAddress = acc.shippingStreet + " " + acc.shippingCity + "," + " " + acc.shippingState +  " " + acc.shippingPostalCode
                    }else{
                        fullAddress = acc.shippingStreet + " " + acc.shippingCity + " " + acc.shippingState +  " " + acc.shippingPostalCode
                    }
                }else{
                    fullAddress = acc.shippingStreet + " " + acc.shippingCity + " " + acc.shippingState +  " " + acc.shippingPostalCode
                }
            }
            (headerCell as! CustomerHeaderTableViewCell).addressValue.text = fullAddress
        }
        
    }
    
    // Battery indicator implementation....
    func batteryIndicator(headerCell:UITableViewCell) {
        let mtdValue:Double = ((account?.percentageLastYearMTDNetSales)! as NSString).doubleValue
        print("MTD value is \(mtdValue)")
        
        if (mtdValue >= 0.0 && mtdValue < 0.4 )
        {
            (headerCell as! CustomerHeaderTableViewCell).batterySalesIndicator.image = UIImage(named:"Health-Pathetic")
            
        } else if ( 0.6 > mtdValue && mtdValue >= 0.4){
            (headerCell as! CustomerHeaderTableViewCell).batterySalesIndicator.image = UIImage(named:"Health-Extremely Bad.png" )
        }
        else if ( 0.8 > mtdValue && mtdValue >= 0.6){
            (headerCell as! CustomerHeaderTableViewCell).batterySalesIndicator.image = UIImage(named: "Health-Very Bad.png")
        }
        else if ( 1.0 > mtdValue && mtdValue >= 0.8){
            (headerCell as! CustomerHeaderTableViewCell).batterySalesIndicator.image = UIImage(named:"Health-Bad")
        }
        else if  mtdValue >= 1.0 {
            
            (headerCell as! CustomerHeaderTableViewCell).batterySalesIndicator.image = UIImage(named:"Health-Good")
            
        }
    }
    
    //Past due amount value is greater than 0 than only show indicator else hide it
    func showPastDueAmountIndicator(headerCell:UITableViewCell) {
        if let pastDueAmmt = account?.pastDueAmountDouble{
            if pastDueAmmt <= 0{
                (headerCell as! CustomerHeaderTableViewCell).pastDueIndicatorImage.isHidden = true
            }
            else{
                (headerCell as! CustomerHeaderTableViewCell).pastDueIndicatorImage.isHidden = false
            }
        }
    }
    
    
    //Getting account Type Account type
    func showAccountType(headerCell:UITableViewCell)  {
        if let acc = account{
            let accountType = acc.premiseCode + " " + acc.channelTD + "\n" + acc.subChannelTD
            (headerCell as! CustomerHeaderTableViewCell).accountTypeValue.text = accountType
        } else {
            (headerCell as! CustomerHeaderTableViewCell).accountTypeValue.text = ""
        }
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0{
            return  0
        }
        else if section == 1{
            return contactsWithBuyingPower.count
        }
        else if section == 2{
            return contactsForSG.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // setting the contact cell data.....
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ContactTableViewCell
        var ary: [Contact] = []
        if indexPath.section == 1 {
            ary = contactsWithBuyingPower
            cell.nameLabel.textColor = UIColor(named: "Data New")
        }
        else if indexPath.section == 2 {
            ary = contactsForSG
            cell.nameLabel.textColor = UIColor.black
            
        }
        let contact = ary[indexPath.row]
        cell.emailLabel.text = contact.email
        cell.nameLabel.text = contact.name
        cell.phoneNumberLabel.text = contact.phoneNumber
        cell.function_RoleLabel.text = contact.functionRole
        cell.initialsLabel.text =  Validations().getIntials(name: contact.name) //contact.getIntials(name: contact.name)

        cell.selectionStyle = .none
        return cell
    }
    
   
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 280
        }
        else if section == 1{
            return 100
        }
        else if section == 2{
            return 150
        }
        return 0
    }
    
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0.1
        }
        else if section == 1{
            return 0.1
        }else if section == 2{
            return 75
            
        }
        return 0.1
    }
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let  headerCell = tableView.dequeueReusableCell(withIdentifier: "customerHeaderCell") as! CustomerHeaderTableViewCell
        
        if section == 0{
            self.getFullAddress(headerCell: headerCell)
            self.batteryIndicator(headerCell: headerCell)
            self.showPastDueAmountIndicator(headerCell: headerCell)
            self.showAccountType(headerCell: headerCell)
            headerCell.accountIDValue.text = account?.accountNumber
            headerCell.phoneValue.text = account?.phone
            headerCell.licenseTypeValue.text = account?.licenseType
            headerCell.licenseNumberValue.text = account?.licenseNumber
            headerCell.mtdSalesValue.text =  CurrencyFormatter.convertToCurrencyFormat(amountToConvert: (account?.mtdNetSales)!)
            headerCell.creditLimitValue.text = CurrencyFormatter.convertToCurrencyFormat(amountToConvert: (account?.creditLimit)!) 
            headerCell.totalBalanceValue.text = CurrencyFormatter.convertToCurrencyFormat(amountToConvert: (account?.totalARBalance)!)
            headerCell.expirationValue.text = DateTimeUtility.getDDMMYYYFormattedDateString(dateStringfromAccountObject: account?.licenseExpirationDate)
            headerCell.pastDueValue.text = CurrencyFormatter.convertToCurrencyFormat(amountToConvert: (account?.pastDueAmountDouble)!)
            headerCell.deliveryFrequencyValue.text = account?.deliveryFrequency
            headerCell.nextDeliveryDateValue.text =  DateTimeUtility.getDDMMYYYFormattedDateString(dateStringfromAccountObject: account?.nextDeliveryDate)
            //Getting only working hours from extension
            //  let workingHours = account?.operatingHours.slice(from: ":", to: "\n")
            headerCell.businessHoursValue.text = account?.operatingHours
            return headerCell
            
        }
        else if section == 1{
            
            let frame = tableView.frame
            let sectionLabel = UILabel.init(frame: CGRect(x: 40, y: 25, width: 800, height: 50))
            sectionLabel.text = (account?.accountName)! + " " + "Contacts"
            sectionLabel.textColor = UIColor.black
            sectionLabel.font = UIFont(name: "Ubuntu-Medium", size: 25)
            
            let headerView = UIView.init(frame: CGRect(x: 0, y: 0, width:frame.width , height:frame.height ))
            headerView.backgroundColor = UIColor.white
            headerView.addSubview(sectionLabel)
            return headerView;
            
        }
            
        else if section == 2 {
            
            let frame = tableView.frame
            // ViewAllContacts Button Frame and Position....
            let viewAllAccountContactsButton = UIButton.init(frame: CGRect(x: 815, y: 25, width: 200, height: 35))
            
            viewAllAccountContactsButton.setTitle("View All Account Contacts", for: .normal)
            viewAllAccountContactsButton.backgroundColor = UIColor(named: "LightGrey")
            viewAllAccountContactsButton.setTitleColor(UIColor.black, for: .normal)
            viewAllAccountContactsButton.titleLabel?.font = UIFont.init(name: "Ubuntu-Medium", size: 12)
            viewAllAccountContactsButton.addTarget(self, action:#selector(viewAllContactFunction), for: .touchUpInside)
            
            // Southern Glazer,s  Label Frame and Position....
            let sectionLabel = UILabel.init(frame: CGRect(x: 40, y: 90, width: 400, height: 50))
            sectionLabel.text = "Southern Glazer's Contacts"
            sectionLabel.textColor = UIColor.black
            sectionLabel.font = UIFont(name: "Ubuntu-Medium", size: 25)
            
            // Adding Button and Label to the  headerView.....
            let headerView = UIView.init(frame: CGRect(x: 0, y: 0, width:frame.width , height:frame.height ))
            headerView.backgroundColor = UIColor.white
            headerView.addSubview(viewAllAccountContactsButton)
            headerView.addSubview(sectionLabel)
            
            return headerView;
        }
        
        return nil
    }
    
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        guard  let tableViewHeaderFooterView = view as? UITableViewHeaderFooterView else { return }
        
        if  section == 1{
            tableViewHeaderFooterView.contentView.backgroundColor = UIColor.white
            tableViewHeaderFooterView.textLabel?.text = (account?.accountName)! + "Contacts"
            tableViewHeaderFooterView.textLabel?.textColor = UIColor.black
            tableViewHeaderFooterView.textLabel?.font = UIFont.boldSystemFont(ofSize:25)
            tableViewHeaderFooterView.textLabel?.frame = tableViewHeaderFooterView.frame
            tableViewHeaderFooterView.textLabel?.textAlignment = .left
            
        }
        else if section == 2
        {
            tableViewHeaderFooterView.contentView.backgroundColor = UIColor.white
            tableViewHeaderFooterView.textLabel?.text = "Southern Glazer's Contacts "
            tableViewHeaderFooterView.textLabel?.textColor = UIColor.black
            tableViewHeaderFooterView.textLabel?.font = UIFont.boldSystemFont(ofSize:25)
            tableViewHeaderFooterView.textLabel?.frame = tableViewHeaderFooterView.frame
            tableViewHeaderFooterView.textLabel?.textAlignment = .left
            
        }
        
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.view.endEditing(true)
        
        ContactFilterMenuModel.comingFromDetailsScreen = "YES"
        var ary: [Contact] = []
        if indexPath.section == 1 {
            ary = contactsWithBuyingPower
        }
        else if indexPath.section == 2 {
            ary = contactsForSG
            return
            
        }
        else {
            return
        }
        let contact = ary[indexPath.row]
        ContactFilterMenuModel.selectedContactId = contact.contactId
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showAllContacts"), object:nil)

    }

    @objc func viewAllContactFunction()  {
        
        ContactFilterMenuModel.comingFromDetailsScreen = ""
        ContactFilterMenuModel.selectedContactId = ""

        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showAllContacts"), object:account?.account_Id)
    }
    
}
