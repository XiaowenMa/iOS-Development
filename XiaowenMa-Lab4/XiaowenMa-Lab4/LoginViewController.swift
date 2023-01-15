//
//  LoginViewController.swift
//  XiaowenMa-Lab4
//
//  Created by 马晓雯 on 7/13/20.
//  Copyright © 2020 Xiaowen Ma. All rights reserved.
//

import UIKit
import FirebaseAuth


//Reference for firebase sign up and log in:https://www.youtube.com/watch?v=1HN7usMROt8
class LoginViewController: UIViewController {
    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var errorMessage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        errorMessage.alpha=0;
        //logInButton.layer.borderWidth=0.5;
        navigationItem.title="Welcome Back"
        logInButton.layer.cornerRadius=15;
        logInButton.layer.backgroundColor=UIColor.systemGray6.cgColor
    }
    
    func validateInputFileds()->String?{
        //check if  name and password are properly filled
        if(username.text?.trimmingCharacters(in: .whitespacesAndNewlines)==""||password.text?.trimmingCharacters(in: .whitespacesAndNewlines)==""){
            return "Please Fill in Both Fields!"
            }
        
        return nil
    }

    @IBAction func logInClicked(_ sender: Any) {
        //validate the input fields
        let error=validateInputFileds()
        
        if error != nil{
            let InputAlert = UIAlertController(title: "Input Fileds Not Valid", message: "Error: \(error!)", preferredStyle: .alert)
            InputAlert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
            self.present(InputAlert, animated: true, completion: nil)
            //errorMessage.text = error!
            //errorMessage.alpha=1
        }
        else{
            let email=username.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let pwd=password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            //sign in the user
            
            errorMessage.text="Signing in..."
            errorMessage.textColor = .black
            errorMessage.alpha=1
            Auth.auth().signIn(withEmail: email, password: pwd){(result,err) in
                if err != nil{
                    let logInAlert = UIAlertController(title: "Log In Failed", message: "Error: \(String(describing: err!.localizedDescription))", preferredStyle: .alert)
                    logInAlert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
                    self.present(logInAlert, animated: true, completion: nil)
                    self.errorMessage.text=""
                    //self.errorMessage.text="Error in Signing In. Please Check your username or password"
                    //self.errorMessage.textColor = .systemRed
                    //self.errorMessage.alpha=1
                }
                else{
                    //succefully signed in, go to the tab bar view controller
                    let homeTabVarViewController=self.storyboard?.instantiateViewController(identifier: "Home") as! myTabController
                    homeTabVarViewController.user=self.username.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                    self.view.window?.rootViewController=homeTabVarViewController
                    self.view.window?.makeKeyAndVisible()
                }
                
            }
        }
        
        //
    }
    
    
    @IBAction func forgotPasswordTapped(_ sender: Any) {
        //Reference: UIAlertController "https://medium.com/ios-os-x-development/how-to-use-uialertcontroller-in-swift-70143d7fbede"
        
        //the pop up window for user to enter an email address
        let forgotPasswordAlert = UIAlertController(title: "Forgot password?", message: "Enter email address to receive a link to reset your password.", preferredStyle: .alert)
        forgotPasswordAlert.addTextField()
        //click cancel to cloose the alert
        let action1=UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        forgotPasswordAlert.addAction(action1)
        
        //click reset password to pass the entered email address to firebase's sendPasswordReset(withEmail method)
        let action2=UIAlertAction(title: "Reset Password", style: .default){ (action:UIAlertAction) in
            let resetEmail = forgotPasswordAlert.textFields?.first?.text
            //use firebase's method to send email
                Auth.auth().sendPasswordReset(withEmail: resetEmail!, completion: { (error) in
                if error != nil{
                    //failed in sending email
                    let resetFailedAlert = UIAlertController(title: "Reset Failed", message: "Error: \(String(describing: error?.localizedDescription))", preferredStyle: .alert)
                    
                    let innerAction1=UIAlertAction(title: "OK", style: .default, handler: nil)
                    resetFailedAlert.addAction(innerAction1)
                    self.present(resetFailedAlert, animated: true, completion: nil)
                }else {
                    //successfully sent the email
                    let resetEmailSentAlert = UIAlertController(title: "Reset email sent successfully", message: "Check your email", preferredStyle: .alert)
                    let innerAction2=UIAlertAction(title: "OK", style: .default, handler: nil)
                    resetEmailSentAlert.addAction(innerAction2)
                    self.present(resetEmailSentAlert, animated: true, completion: nil)
                }
            })
        }
        forgotPasswordAlert.addAction(action2)
        
        self.present(forgotPasswordAlert, animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
