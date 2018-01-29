

import UIKit

class SignUpPhoneViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    // MARK: outlets

    @IBOutlet weak var countryButton: UIButton!
    @IBOutlet weak var countryCodeLabel: UILabel!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var countryPicker: UIPickerView!
    
    
    // MARK: lets
    let SIGN_UP_VIA_PHONE_SEGUE = "SignUpViaPhoneConfirmationSegue"
    
    
    // MARK: vars
    
    var pickerDataArray: [UICountryModel] = []
    var pickerCurrentValue: UICountryModel?
    var keyboardHeight: CGFloat?
    
    
    // MARK: override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // load countries
        loadCountries()
        
        
        // set delegates
        phoneNumberTextField.delegate = self
        countryPicker.dataSource = self
        countryPicker.delegate = self
        
        // init ui
        countryButton.setTitle(pickerCurrentValue!.name, for: .normal)
        countryCodeLabel.text! = pickerCurrentValue!.phoneCode
        phoneNumberTextField.becomeFirstResponder()
        if let keyboardHeight = keyboardHeight {
            let oldFrame = countryPicker.frame
            countryPicker.frame = CGRect(x: oldFrame.origin.x, y: oldFrame.origin.y, width: oldFrame.width, height: keyboardHeight)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        pickerCurrentValue = nil
        keyboardHeight = nil
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let id = segue.identifier {
            if id == SIGN_UP_VIA_PHONE_SEGUE {
                let controller = segue.destination as! SignUpPhoneConfirmViewController
                controller.number = formNumber()
            }
        }
    }
    
    
    // MARK: Actions
    
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            keyboardHeight = keyboardSize.height
        }
    }

    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        errorLabel.text = ""
        // validate input
        if let error = validateInput() {
            errorLabel.text! = error
            return
        }
        
        // show alert
        let number = formNumber()
        let alert = UIAlertController(title: "Number confirmation\n\(number.getFullNumber())", message: "\nis your phone number above correct?", preferredStyle: .alert)
        
        alert.view.tintColor = hexStringToUIColor(hex: greenColor)
        alert.addAction(UIAlertAction(title: "Edit", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {
            action in
            // navigate to confirmation screen
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: self.SIGN_UP_VIA_PHONE_SEGUE, sender: self)
            }
        }))
        
        present(alert, animated: true, completion: nil)
    }

    @IBAction func countryButtonPressed(_ sender: UIButton) {
        // show list of countries
        phoneNumberTextField.resignFirstResponder()
    }
    
    
    // MARK: delegate methods
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // called whenever editing is happening
        let isTyping = !string.isEmpty
        
        let fullText: String
        if !isTyping {
            let copy = textField.text!
            let index = copy.index(before: copy.endIndex)
            fullText = copy.substring(to: index)
        } else {
            fullText = textField.text! + string
        }
        
        let count = (fullText as NSString).length
        let position = count - (!isTyping ? 1 : (string as NSString).length)
        
        if isTyping {
            if position == 0 {
                textField.insertText("(")
            }
            if position == 4 {
                textField.insertText(") ")
            }
        
            if position == 9 {
                textField.insertText("-")
            }
        } else {
            if position == 9 {
                textField.text! = (textField.text! as NSString).substring(with: NSRange.init(location: 0, length: 10))
            }
            if position == 5 {
                textField.text! = (textField.text! as NSString).substring(with: NSRange.init(location: 0, length: 5))
            }
            if position == 0 {
                textField.text! = (textField.text! as NSString).substring(with: NSRange.init(location: 0, length: 1))
            }
        }
    
        return count <= 14
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataArray.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataArray[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerCurrentValue = pickerDataArray[row]
        countryCodeLabel.text = pickerCurrentValue!.phoneCode
        countryButton.setTitle(pickerCurrentValue!.name, for: .normal)
    }
    
    
    // MARK: private methods
    
    private func validateInput() -> String? {
        if let error = validatePhoneNumber(phoneNumberTextField.text) {
            return error
        }
        
        return nil
    }
    
    private func formNumber() -> UIPhoneNumber {
        return UIPhoneNumber(country: pickerCurrentValue!, numberString: phoneNumberTextField.text!)
    }
    
    private func loadCountries() {
        let kuwait = UICountryModel(name: "Kuwait", phoneCode: "+965")
        let usa = UICountryModel(name: "USA", phoneCode: "????")
        let russia = UICountryModel(name: "Russia", phoneCode: "????")
        let china = UICountryModel(name: "China", phoneCode: "????")
        let spain = UICountryModel(name: "Spain", phoneCode: "????")
        let france = UICountryModel(name: "France", phoneCode: "????")
        let belarus = UICountryModel(name: "Belarus", phoneCode: "????")
        
        pickerDataArray = [kuwait, usa, russia, china, spain, france, belarus]
        pickerCurrentValue = pickerDataArray[0]
    }
    
}
