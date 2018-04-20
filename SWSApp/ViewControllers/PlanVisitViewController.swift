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
    private var myTableView: UITableView!
    @IBOutlet weak var searchContactTxtfld: DesignableUITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Plan VC viewDidLoad")
        
//        myTableView = UITableView(frame: CGRect(x: 58, y: 219, width: 909, height: 206))
//        myTableView.register(UINib(nibName: "AccountTableViewCell", bundle: nil), forCellReuseIdentifier: "MyCell")
//        myTableView.separatorStyle = UITableViewCellSeparatorStyle.none
//        myTableView.dataSource = self
//        myTableView.delegate = self
//        self.view.addSubview(myTableView)
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
        return myArray.count
    }
    
    // MARK - UITableView Delegates

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
//        cell.textLabel!.text = "\(myArray[indexPath.row])"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Num: \(indexPath.row)")
        print("Value: \(myArray[indexPath.row])")
//        UIView.animateWithDuration(1.5, delay: 0, options: .Repeat
//            , animations: ({
//                self.hintLabel.myTableView = 0.0
//            }), completion: nil
//        )
//        [UIView animateWithDuration:0.2
//            animations:^{self.myTableView = 0.0;}
//            completion:^(BOOL finished){ [self.myTableView removeFromSuperview]; }];
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 62.0;//Choose your custom row height
    }
    
    // MARK - TextFieldDelegates
    func textFieldDidBeginEditing(_ textField: UITextField) {
        myTableView = UITableView(frame: CGRect(x: textField.frame.origin.x, y: textField.frame.origin.y + textField.frame.size.height, width: textField.frame.size.width, height: 206))
        myTableView.register(UINib(nibName: "AccountTableViewCell", bundle: nil), forCellReuseIdentifier: "MyCell")
        myTableView.separatorStyle = UITableViewCellSeparatorStyle.none
        myTableView.dataSource = self
        myTableView.delegate = self
        self.view.addSubview(myTableView)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("qweqwe")
        myTableView.removeFromSuperview()
    }
    
    
}
