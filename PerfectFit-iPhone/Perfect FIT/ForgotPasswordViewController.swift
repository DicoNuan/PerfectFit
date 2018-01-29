
import UIKit

class ForgotPasswordViewController: UIViewController {
    
    // MARK: outlets
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    // MARK: lets
    
    let FORGOT_PASSWORD_CONFIRM_SEGUE = "ForgotPasswordConfirmSegue"
    
    
    // MARK: overriden methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    // MARK: actions
    
    @IBAction func emailDoneButtonPressed() {
        emailTextField.resignFirstResponder()
    }
    
    @IBAction func requestButtonPressed(sender: UIButton) {
        errorLabel.text! = ""
        if let emailError = validateEmail(emailTextField.text) {
            errorLabel.text! = emailError
            return
        }
        
        // pass data to back-end
        
        
        // navigate to confirm
        performSegue(withIdentifier: FORGOT_PASSWORD_CONFIRM_SEGUE, sender: nil)
    }
    

}
