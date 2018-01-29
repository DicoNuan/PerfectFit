
import UIKit

class SignUpEmailViewController: UIViewController {
    
    // MARK: outlets
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    
    // MARK: overriden methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    // MARK: actions
    
    @IBAction func emailDoneButtonPressed() {
        passwordTextField.becomeFirstResponder()
    }
    
    @IBAction func passwordDoneButtonPressed() {
        confirmPasswordTextField.becomeFirstResponder()
    }
    
    @IBAction func confirmPasswordDoneButtonPressed() {
        confirmPasswordTextField.resignFirstResponder()
    }
    
    @IBAction func doneButtonPressed(sender: UIButton) {
        errorLabel.text! = ""
        if let error = validateInput() {
            errorLabel.text! = error
            return
        }
        
        // pass data to back-end
        
        showAlert()
    }
    
    
    // MARK: private methods
    
    private func validateInput() -> String? {
        if let emailError = validateEmail(emailTextField.text) {
            return emailError
        }
        
        if let passwordError = validatePassword(passwordTextField.text) {
            return passwordError
        }
        
        if let confirmPasswordError = validatePassword(confirmPasswordTextField.text) {
            return confirmPasswordError
        }
        
        if passwordTextField.text! != confirmPasswordTextField.text! {
            return "Passwords are not identical"
        }
        
        return nil
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "PerfectFit", message: "Thank you for registering. Let's get fit!", preferredStyle: .alert)
        alert.view.tintColor = hexStringToUIColor(hex: greenColor)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {
            action in
            
            // navigate to home
            
            AppDelegate.getApplicationTabBarController()?.setHome()
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
}
