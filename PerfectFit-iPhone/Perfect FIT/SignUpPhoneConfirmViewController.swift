
import UIKit

class SignUpPhoneConfirmViewController: UIViewController {

    // MARK: outlets
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var countryLabel: UIButton!
    @IBOutlet weak var codeTextField: UITextField!
    
    
    // MARK: vars
    
    var number: UIPhoneNumber?
    
    
    // MARK: overriden methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countryLabel.setTitle(number!.country.name, for: .normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        number = nil
    }
    
    // MARK: Actions
    
    @IBAction func doneButtonPressed() {
        errorLabel.text! = ""
        if let error = validateIsEmpty(codeTextField.text) {
            errorLabel.text! = "Code " + error
            return
        }
        
        // pass code to back-end
        showAlert()
    }
    
    
    // MARK: private methods
    
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
