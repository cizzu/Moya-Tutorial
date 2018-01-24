//
//  ViewController.swift
//  Moya Tutorial
//
//  Created by Afriyandi Setiawan on 24/01/18.
//  Copyright © 2018 Afriyandi Setiawan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var uname: UITextField!
    @IBOutlet weak var pswd: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doLogin(_ sender: UIButton) {
        let (username, password) = (uname.text, pswd.text)
        userDo().request(target: .login(username: username ?? "empty", password: password ?? "empty"),
                         success: { (val) in
                            print(val) },
                         error: { (err) in
                            print(err) },
                         failure: { (err) in
                            print(err)
        }) {}
    }
    
}

