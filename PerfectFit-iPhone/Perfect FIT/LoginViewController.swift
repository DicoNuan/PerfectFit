

import UIKit

class LoginViewController: UIViewController {

    // MARK: Outlets
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    
    // MARK: Overriden methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    // MARK: Actions
    
    @IBAction func onEmailDoneButtonPressed() {
        passwordTextField.becomeFirstResponder()
    }
    
    @IBAction func onPasswordDoneButtonPressed() {
       passwordTextField.resignFirstResponder()
    }

    @IBAction func onLoginButtonPressed(sender: UIButton) {
        errorLabel.text! = ""
        if let error = validateInput() {
            // show error
            errorLabel.text! = error
            return
        }
     
        // send request to back-end
        
        AppDelegate.getApplicationTabBarController()?.setHome()
    }
    
    
    // MARK: private methods
    
    private func validateInput() -> String? {
        
        if let error = validateEmail(emailTextField.text) {
            return error
        }
        
        
        if let error = validatePassword(passwordTextField.text) {
            return error
        }
        
      
        return nil
    }
}
