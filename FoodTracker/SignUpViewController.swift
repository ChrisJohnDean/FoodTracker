//
//  SignUpViewController.swift
//  FoodTracker
//
//  Created by Chris Dean on 2018-03-26.
//  Copyright © 2018 Apple Inc. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var usernameTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    var requestManager: RequestManager!
    
    @IBAction func signUp(_ sender: Any) {
       
        requestManager.signUp(userName: usernameTextfield.text, password: passwordTextfield.text) { (token: String?, error: String?) in
            
            DispatchQueue.main.async {
                if let token = token {
                    UserDefaults.standard.set(self.usernameTextfield.text, forKey: "username")
                    UserDefaults.standard.set(self.passwordTextfield.text, forKey: "password")
                    UserDefaults.standard.set(token, forKey: "token")
                    self.performSegue(withIdentifier: "signedUpSegue", sender: self)
                } else if let error = error {
                    let alert = UIAlertController(title: "\(error)!", message: nil, preferredStyle: .alert)
                    self.present(alert, animated: true, completion: nil)
                }
            }
            
        }
    }
    
    @IBAction func login(_ sender: Any) {
        
        requestManager.login(userName: usernameTextfield.text, password: passwordTextfield.text) { (token: String?, error: String?) in
            
            DispatchQueue.main.async {
                
                if let token = token {
                    UserDefaults.standard.set(self.usernameTextfield.text, forKey: "username")
                    UserDefaults.standard.set(self.passwordTextfield.text, forKey: "password")
                    UserDefaults.standard.set(token, forKey: "token")
                    self.performSegue(withIdentifier: "signedUpSegue", sender: self)
                } else if let error = error {
                    let alert = UIAlertController(title: "\(error)!", message: nil, preferredStyle: .alert)
                    self.present(alert, animated: true, completion: nil)
                }
            }
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestManager = RequestManager()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if UserDefaults.standard.string(forKey: "token") != nil {
            performSegue(withIdentifier: "signedUpSegue", sender: self)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
}
