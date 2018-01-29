

import UIKit

class ForgotPasswordConfirmViewController: UIViewController {

    // MARK: outlets
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var renewPasswordTextField: UITextField!
    
    
    // MARK: overriden methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    // MARK: actions
    
    @IBAction func newPasswordDoneButtonPressed() {
        renewPasswordTextField.becomeFirstResponder()
    }
    
    @IBAction func renewPasswordDoneButtonPressed() {
        newPasswordTextField.resignFirstResponder()
    }
    
    @IBAction func doneButtonPressed(_ sender: UIButton) {
        errorLabel.text! = ""
        if let error = validateInput() {
            errorLabel.text! = error
            return
        }
        
        // pass data to back-end
    }

    
    // MARK: private methods
    
    private func validateInput() -> String? {
        if let newPasswordError = validatePassword(newPasswordTextField.text) {
            return newPasswordError
        }
        
        if let renewPasswordError = validatePassword(renewPasswordTextField.text) {
            return renewPasswordError
        }
        
        if newPasswordTextField.text! != renewPasswordTextField.text! {
            return "Passwords are not identical"
        }
        
        return nil
    }
    
}
