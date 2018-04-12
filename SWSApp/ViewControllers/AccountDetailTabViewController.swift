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
        let loggerInUser = userViewModel.loggedInUser
        contactsWithBuyingPower = contactViewModel.contactsWithBuyingPower(forUser: (loggerInUser?.userid)!)
        contactsForSG = contactViewModel.contactsForSG(forUser: (loggerInUser?.userid)!)
        
        // checking single multi location filter
        if let acc = account{
            print( "the single multi is \(acc.singleMultiLocationFilter)")
        }
        
       
        
        
        //just testing globalContacts here
        let globalContactas = contactViewModel.globalContacts()
        print("globalContactas.count = " + "\(globalContactas.count)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        cell.phoneNumberLabel.text = contact.phoneuNmber
        cell.function_RoleLabel.text = contact.functionRole
        cell.initialsLabel.text = contact.getIntials(name: contact.name)
        return cell
    }
    
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 1{
            return "Crown Liquor Store"
        }
        else if section == 2{
            return "Southern Glazer's Contact "
        }
        return nil
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
            return 60
            
        }
        return 0.1
    }
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let  headerCell = tableView.dequeueReusableCell(withIdentifier: "customerHeaderCell") as! CustomerHeaderTableViewCell
        
        if section == 0{
            
            // getting full address
            if let acc = account{
                let fullAddress = acc.shippingStreet + " " + acc.shippingCity + "," + " " + acc.shippingState +  " " + acc.shippingPostalCode 
                headerCell.addressValue.text = fullAddress
            } else {
                headerCell.addressValue.text = ""
            }
            
            headerCell.accountIDValue.text = account?.accountNumber
            headerCell.phoneValue.text = account?.phone
            headerCell.licenseTypeValue.text = account?.licenseType
            headerCell.licenseNumberValue.text = account?.licenseNumber
            headerCell.totalCYR12NetSales.text = "$" + String(describing: account!.totalCYR12NetSales)
            

            
            let mtdValue : Double = Double((account?.percentageLastYearMTDNetSales)!)
            if (mtdValue > 0.0 && mtdValue < 0.40 )
            {// Health-Pathetic
                headerCell.batterySalesIndicator.image = UIImage(named: "Health-Good")
            } else if ( 0.60 > mtdValue && mtdValue > 0.40){
                 headerCell.batterySalesIndicator.image = UIImage(named: "Health-Bad")
            }
            else if ( 0.80 > mtdValue && mtdValue > 0.60){
                 headerCell.batterySalesIndicator.image = UIImage(named: "Health-Very Bad.png")
            }
            else if ( 1.0 > mtdValue && mtdValue > 0.80){
                 headerCell.batterySalesIndicator.image = UIImage(named: "Health-Extremely Bad.png")
            }
            else {
                headerCell.batterySalesIndicator.image = UIImage(named: "Health-Pathetic.png")
            }

            headerCell.creditLimitValue.text = "$"+(account?.creditLimit.description)!
            headerCell.totalBalanceValue.text = "$"+(account?.totalARBalance.description)!
            
            if let expDate = account?.licenseExpirationDate {
                let dateFormatter = DateFormatter()
                
                dateFormatter.dateFormat = "dd/mm/yyyy"
                headerCell.expirationValue.text = dateFormatter.string(from: expDate)
            }
            
            //Past due amount value is greater than 0 than only show indicator else hide it
            if let pastDueAmmt = account?.pastDueAmount{
                if pastDueAmmt <= 0{
                    headerCell.pastDueIndicatorImage.isHidden = true
                }
                else{
                    
                     headerCell.pastDueIndicatorImage.isHidden = false
                    
                }
            }
            headerCell.pastDueValue.text = "$"+(account?.pastDueAmount.description)!
            headerCell.deliveryFrequencyValue.text = account?.deliveryFrequency
            headerCell.nextDeliveryDateValue.text =  account?.nextDeliveryDate
            headerCell.accountHealthIndicator.text = account?.percentageLastYearMTDNetSales.description
            
            //Getting only working hours from extension
            
          //  let workingHours = account?.operatingHours.slice(from: ":", to: "\n")
            headerCell.businessHoursValue.text = account?.operatingHours
            
            // getting account type value
            if let acc = account{
                let accountType = acc.premiseCode + " " + acc.channelTD + "\n" + acc.subChannelTD
                headerCell.accountTypeValue.text = accountType
                
            } else {
                
                headerCell.accountTypeValue.text = ""
            }
            
            return headerCell
            
        }
        else if section == 1{
            let frame = tableView.frame
            let sectionLabel = UILabel.init(frame: CGRect(x: 40, y: 25, width: 400, height: 50))
            sectionLabel.text = "Contacts"
            sectionLabel.textColor = UIColor.black
            sectionLabel.font = UIFont(name: "Ubuntu-Medium", size: 25)
            
            let headerView = UIView.init(frame: CGRect(x: 0, y: 0, width:frame.width , height:frame.height ))
            headerView.backgroundColor = UIColor.white
            headerView.addSubview(sectionLabel)
            return headerView;
            
        }
            
        else if section == 2 {
            
            let frame = tableView.frame
            // ViewAllContacts Button...
            let viewAllAccountContactsButton = UIButton.init(frame: CGRect(x: 815, y: 25, width: 200, height: 35))
            viewAllAccountContactsButton.setTitle("View All Account Contacts", for: .normal)
            viewAllAccountContactsButton.backgroundColor = UIColor(named: "LightGrey")
            viewAllAccountContactsButton.setTitleColor(UIColor.black, for: .normal)
            viewAllAccountContactsButton.titleLabel?.font = UIFont.init(name: "Ubuntu-Medium", size: 12)
            
            
            let sectionLabel = UILabel.init(frame: CGRect(x: 40, y: 90, width: 400, height: 50))
            sectionLabel.text = "Southern Glazer's Contacts"
            sectionLabel.textColor = UIColor.black
            sectionLabel.font = UIFont(name: "Ubuntu-Medium", size: 25)
            
            
            
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
            tableViewHeaderFooterView.textLabel?.text = "Contacts"
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
    
}

