//
//  SignupViewController.swift
//  XiaowenMa-Lab4
//
//  Created by 马晓雯 on 7/13/20.
//  Copyright © 2020 Xiaowen Ma. All rights reserved.
//

import UIKit
import FirebaseAuth

//Reference for firebase sign up and log in:https://www.youtube.com/watch?v=1HN7usMROt8
class SignupViewController: UIViewController {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var errorMessage: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        errorMessage.alpha=0
        navigationItem.title="Join Us"
        signInButton.layer.cornerRadius=15;
        signInButton.layer.backgroundColor=UIColor.systemGray6.cgColor
    }
    
    func validateFileds()->String?{
        //check if  name and password are properly filled
        if(username.text?.trimmingCharacters(in: .whitespacesAndNewlines)==""||password.text?.trimmingCharacters(in: .whitespacesAndNewlines)==""){
            return "Please Fill in Both Fields!"
            }
        else{
            let emailValidation=NSPredicate(format: "SELF MATCHES %@","^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$")
            if(emailValidation.evaluate(with: username.text?.trimmingCharacters(in: .whitespacesAndNewlines))==false){
                return  "Invalid email address format."
            }

        }
        
        
        return nil
    }

    @IBAction func signInClicked(_ sender: Any) {
        //validate
        let error=validateFileds()
        
        if error != nil{
            let InputAlert = UIAlertController(title: "Input Fileds Not Valid", message: "Error: \(error!)", preferredStyle: .alert)
            InputAlert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
            self.present(InputAlert, animated: true, completion: nil)
            //errorMessage.text = error!
            //errorMessage.alpha=1
        }
        else{
            //clean up email and pwd
            let email  =  username.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let pwd = password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            //create a user
            errorMessage.text="Signing up..."
            errorMessage.textColor = .black
            errorMessage.alpha=1
            Auth.auth().createUser(withEmail: email, password: pwd){(result,err) in
                
                if err != nil{
                    let SignUpAlert = UIAlertController(title: "Sign Up Failed", message: "Error: \(String(describing: err!.localizedDescription))", preferredStyle: .alert)
                    SignUpAlert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
                    self.present(SignUpAlert, animated: true, completion: nil)
                    //self.errorMessage.text = "Error in Creating User"
                    //self.errorMessage.alpha=1
                    self.errorMessage.text=""
                }
                else{
                    //go  to home scree
                    self.goToHomeScreen()
                }
            }
        }
    }
    
    func goToHomeScreen(){
        
        let homeTabVarViewController=storyboard?.instantiateViewController(identifier: "Home") as! myTabController
        homeTabVarViewController.user=username.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        view.window?.rootViewController=homeTabVarViewController
        view.window?.makeKeyAndVisible()
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
