//
//  PlanVisitViewController.swift
//  SWSApp
//
//  Created by vipin.vijay on 19/04/18.
//  Copyright © 2018 maria.min-hui.yu. All rights reserved.
//

import UIKit

class PlanVisitViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    private let myArray: NSArray = ["First","Second","Third"]
    private let associatedSelectedContact: NSMutableArray = []
    private var myTableView: UITableView!
    private var associatedContactTableView: UITableView!
    var textFieldTag: Int = 0
    @IBOutlet var searchAccountLbl: UILabel!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var planLbl: UILabel!
    @IBOutlet var bottomView: UIView!
    @IBOutlet var searchAccountTxt: DesignableUITextField!
    @IBOutlet var searchContactTxt: DesignableUITextField!
    @IBOutlet var schedulerComponentView: SchedulerComponent!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Plan VC viewDidLoad")
        
        NotificationCenter.default.addObserver(self, selector: #selector(PlanVisitViewController.closeView(notification:)), name: Notification.Name("CLOSEACCOUNTVIEW"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(PlanVisitViewController.removeAssociate(notification:)), name: Notification.Name("REMOVEASSOCIATE"), object: nil)
        
        self.associatedContactTableView = UITableView(frame: CGRect(x: 10, y: 300, width: self.searchAccountTxt.frame.size.width, height: 206))
        self.associatedContactTableView.register(UINib(nibName: "SelectedAssociateTableViewCell", bundle: nil), forCellReuseIdentifier: "SelectedAssociateTableViewCell")
        
        self.associatedContactTableView.separatorStyle = UITableViewCellSeparatorStyle.none
        self.associatedContactTableView.dataSource = self
        self.associatedContactTableView.delegate = self
        self.scrollView.addSubview(self.associatedContactTableView)
        self.associatedContactTableView.isHidden = true
        self.textFieldTag = 102
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("Plan VC will appear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("Plan VC will disappear")
    }
    
    // MARK - UITableView Datasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count: Int = 0
        if(textFieldTag == 102) {
            count = associatedSelectedContact.count
        } else {
            count = myArray.count
        }
        return count
    }
    
    // MARK - UITableView Delegates
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(textFieldTag == 100) {
            let cell: AccountTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath) as! AccountTableViewCell
            return cell
        } else if(textFieldTag == 101) {
            let cell: AssociateTableViewCell = tableView.dequeueReusableCell(withIdentifier: "AssociateTableViewCell", for: indexPath as IndexPath) as! AssociateTableViewCell
            return cell
        } else {
            let cell: SelectedAssociateTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SelectedAssociateTableViewCell", for: indexPath as IndexPath) as! SelectedAssociateTableViewCell
            cell.removeButton.tag = indexPath.row
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Num: \(indexPath.row)")
        print("Value: \(myArray[indexPath.row])")
        
        UIView.animate(withDuration: 1.0, animations: {
            self.myTableView.alpha = 0
        }) { _ in
            self.myTableView.removeFromSuperview()
            if(self.textFieldTag == 100) {
                self.searchAccountLbl.isHidden = true
                self.searchAccountTxt.isHidden = true
                
                let accountView = AccountView(frame: CGRect(x: self.planLbl.frame.origin.x - 20, y:
                    self.planLbl.frame.origin.y + 20, width: self.searchAccountTxt.frame.size.width, height: 100))
                self.scrollView.addSubview(accountView)
            } else if(self.textFieldTag == 101) {
                self.textFieldTag = 102
                self.associatedSelectedContact.add("a")
                self.associatedContactTableView.isHidden = false
                self.associatedContactTableView.reloadData()
                
                self.associatedContactTableView.frame = CGRect(x: self.searchContactTxt.frame.origin.x, y: self.searchContactTxt.frame.origin.y + self.searchContactTxt.frame.size.height + 40, width: self.searchContactTxt.frame.size.width, height: CGFloat(62 * self.associatedSelectedContact.count))
                
                self.bottomView.frame = CGRect(x: 0, y: self.associatedContactTableView.frame.origin.y +  self.associatedContactTableView.frame.size.height + 20, width: self.bottomView.frame.size.width, height: self.bottomView.frame.size.height)
                
                self.scrollView.contentSize = CGSize(width: self.scrollView.frame.size.width, height: self.scrollView.frame.size.height + CGFloat(62 * self.associatedSelectedContact.count) + 40)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 62.0;//Choose your custom row height
    }
    
    // MARK - TextFieldDelegates
    func textFieldDidBeginEditing(_ textField: UITextField) {
        myTableView = UITableView(frame: CGRect(x: textField.frame.origin.x, y: textField.frame.origin.y + textField.frame.size.height, width: textField.frame.size.width, height: 206))
        print("width", textField.frame.size.width);
        textFieldTag = textField.tag
        switch textField.tag {
        case 100:
            myTableView.register(UINib(nibName: "AccountTableViewCell", bundle: nil), forCellReuseIdentifier: "MyCell")
        case 101:
            myTableView.register(UINib(nibName: "AssociateTableViewCell", bundle: nil), forCellReuseIdentifier: "AssociateTableViewCell")
        default:
            print("default")
        }
        
        myTableView.separatorStyle = UITableViewCellSeparatorStyle.none
        myTableView.dataSource = self
        myTableView.delegate = self
        self.scrollView.addSubview(myTableView)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("qweqwe")
    }
    
    // MARK - Notification
    
    @objc func removeAssociate(notification: Notification){
        //Take Action on Notification
        print("hi")
        if let userInfo = notification.userInfo // or use if you know the type  [AnyHashable : Any]
        {
            if let tag = userInfo["tag"] as? Int {
                self.associatedSelectedContact.removeObject(at: tag)
                self.associatedContactTableView.reloadData()
                if (self.associatedSelectedContact.count > 0) {
                    self.associatedContactTableView.frame = CGRect(x: self.searchContactTxt.frame.origin.x, y: self.searchContactTxt.frame.origin.y + self.searchContactTxt.frame.size.height + 40, width: self.searchContactTxt.frame.size.width, height: CGFloat(62 * self.associatedSelectedContact.count))
                    
                    self.bottomView.frame = CGRect(x: 0, y: self.associatedContactTableView.frame.origin.y +  self.associatedContactTableView.frame.size.height + 20, width: self.bottomView.frame.size.width, height: self.bottomView.frame.size.height)
                    
                    self.scrollView.contentSize = CGSize(width: self.scrollView.frame.size.width, height: self.scrollView.frame.size.height + CGFloat(62 * self.associatedSelectedContact.count) + 40)
                } else {
                    self.associatedContactTableView.isHidden = true
                    
                    self.bottomView.frame = CGRect(x: 0, y: self.searchContactTxt.frame.origin.y +  self.searchContactTxt.frame.size.height + 20, width: self.bottomView.frame.size.width, height: self.bottomView.frame.size.height)
                    
                    self.scrollView.contentSize = CGSize(width: self.scrollView.frame.size.width, height: self.scrollView.frame.size.height)
                }
            }
        }
    }
    
    @objc func closeView(notification: Notification){
        //Take Action on Notification
        self.searchAccountLbl.isHidden = false
        self.searchAccountTxt.isHidden = false
        self.myTableView.removeFromSuperview()
    }
}
