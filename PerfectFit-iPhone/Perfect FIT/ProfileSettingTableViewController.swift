

import UIKit

class ProfileSettingTableViewController: UITableViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var avatarImageview: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    

    
    var user: UIUserModel?
    var alert: UIAlertController?
    
    weak var newPassTextField: UITextField?
    weak var confirmPassTextField: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = hexStringToUIColor(hex: "FFFFFF")
        tableView.separatorColor = tableView.backgroundColor
        
        setupContent()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        newPassTextField = nil
        confirmPassTextField = nil
        alert = nil
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0.0000000001
        } else {
            return super.tableView(tableView, heightForHeaderInSection: section)
        }
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 && indexPath.row == 0 {
            // navigate to choose avatar
            
            let avatarAlert = UIAlertController(title: "Choose profile photo source", message: nil, preferredStyle: .alert)
            avatarAlert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {
                action in
                
                let imagePickerController = UIImagePickerController()
                imagePickerController.sourceType = .camera
                imagePickerController.delegate = self
                self.present(imagePickerController, animated: true, completion: nil)
            }))
            
            avatarAlert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: {
                action in
                
                let imagePickerController = UIImagePickerController()
                imagePickerController.sourceType = .photoLibrary
                imagePickerController.delegate = self
                self.present(imagePickerController, animated: true, completion: nil)
            }))
            
            if user?.imgUrl != "" {
                avatarAlert.addAction(UIAlertAction(title: "Remove current", style: .default, handler: {
                    action in
                   
                    self.user?.imgUrl = ""
                    self.avatarImageview.image = nil
                }))
            }
            
            avatarAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            present(avatarAlert, animated: true, completion: nil)
        }
        
        if indexPath.section == 1 {
            if indexPath.row == 0 {
                // navigate to name
                
                alert = UIAlertController(title: "Enter your name", message: nil, preferredStyle: .alert)
                alert!.addTextField(configurationHandler: {
                    field in
                    field.tag = 10000
                    field.delegate = self
                    field.keyboardAppearance = .default
                    field.keyboardType = .default
                    field.placeholder = "Type name here"
                })
                
                alert!.addAction(UIAlertAction(title: "Save", style: .default, handler: {
                    action in
                    
                    // save new name to back-end
                    
                    if let unwrappedAlert = self.alert {
                        if let field = unwrappedAlert.textFields?[0] {
                            let text = field.text
                            self.nameLabel.text = text
                        }
                    }
                }))
                
                if let user = user {
                    alert!.actions[0].isEnabled = !(user.fullName.isEmpty)
                    alert!.textFields![0].text = user.fullName
                } else {
                    alert!.actions[0].isEnabled = false
                }
                
 
                alert!.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                
                present(alert!, animated: true, completion: nil)
            }
            
            if indexPath.row == 1 {
                // navigate to gender
                
                alert = UIAlertController(title: "Choose your gender", message: nil, preferredStyle: .alert)
               
                alert!.addAction(UIAlertAction(title: "Male", style: .default, handler: {
                    action in
                    self.genderLabel.text = "Male"
                }))
                
                alert!.addAction(UIAlertAction(title: "Female", style: .default, handler: {
                    action in
                    self.genderLabel.text = "Female"
                }))
                
                alert!.addAction(UIAlertAction(title: "Any", style: .default, handler: {
                    action in
                    self.genderLabel.text = "Any"
                }))
                
                alert!.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                    
                present(alert!, animated: true, completion: nil)
            }
            
            if indexPath.row == 2 {
                // navigate to age
                
                alert = UIAlertController(title: "Enter your age", message: nil, preferredStyle: .alert)
                alert!.addTextField(configurationHandler: {
                    field in
                    field.tag = 10001
                    field.delegate = self
                    field.keyboardAppearance = .default
                    field.keyboardType = .numberPad
                    field.placeholder = "Type age here"
                })
                
                alert!.addAction(UIAlertAction(title: "Save", style: .default, handler: {
                    action in
                 
                    // save new age to back-end
                    if let unwrappedAlert = self.alert {
                        if let field = unwrappedAlert.textFields?[0] {
                            let text = field.text
                            self.ageLabel.text = text
                        }
                    }
                }))
                
                if let user = user {
                    alert!.actions[0].isEnabled = !(user.age.description.isEmpty)
                    alert!.textFields![0].text = "\(user.age)"
                } else {
                    alert!.actions[0].isEnabled = false
                }
                
                alert!.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                
                present(alert!, animated: true, completion: nil)
            }
            
            if indexPath.row == 3 {
                // navigate to city
                
                alert = UIAlertController(title: "Enter your city", message: nil, preferredStyle: .alert)
                alert!.addTextField(configurationHandler: {
                    field in
                    field.tag = 10002
                    field.delegate = self
                    field.keyboardAppearance = .default
                    field.keyboardType = .default
                    field.placeholder = "Type city here"
                })
                
                alert!.addAction(UIAlertAction(title: "Save", style: .default, handler: {
                    action in
                    
                    // save new city to back-end
                    if let unwrappedAlert = self.alert {
                        if let field = unwrappedAlert.textFields?[0] {
                            let text = field.text
                            self.cityLabel.text = text
                        }
                    }
                }))
                
                if let user = user {
                    alert!.actions[0].isEnabled = !(user.city.isEmpty)
                    alert!.textFields![0].text = user.city
                } else {
                    alert!.actions[0].isEnabled = false
                }
                
                alert!.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                
                present(alert!, animated: true, completion: nil)
            }
            
            if indexPath.row == 4 {
                // navigate to weight
                
                alert = UIAlertController(title: "Enter your weight", message: nil, preferredStyle: .alert)
                alert!.addTextField(configurationHandler: {
                    field in
                    field.tag = 10003
                    field.delegate = self
                    field.keyboardAppearance = .default
                    field.keyboardType = .decimalPad
                    field.placeholder = "Type weight here"
                })
                
                alert!.addAction(UIAlertAction(title: "Save", style: .default, handler: {
                    action in
                    
                    // save new weight to back-end
                    if let unwrappedAlert = self.alert {
                        if let field = unwrappedAlert.textFields?[0] {
                            let text = field.text
                            self.weightLabel.text = text
                        }
                    }
                }))
                
                if let user = user {
                    alert!.actions[0].isEnabled = !(user.weight.description.isEmpty)
                    alert!.textFields![0].text = "\(user.weight)"
                } else {
                    alert!.actions[0].isEnabled = false
                }
                
                alert!.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                
                present(alert!, animated: true, completion: nil)
            }
            
            if indexPath.row == 5 {
                // navigate to weight
                
                alert = UIAlertController(title: "Enter your height", message: nil, preferredStyle: .alert)
                alert!.addTextField(configurationHandler: {
                    field in
                    field.tag = 10004
                    field.delegate = self
                    field.keyboardAppearance = .default
                    field.keyboardType = .decimalPad
                    field.placeholder = "Type height here"
                })
                
                alert!.addAction(UIAlertAction(title: "Save", style: .default, handler: {
                    action in
        
                    // save new height to back-end
                    if let unwrappedAlert = self.alert {
                        if let field = unwrappedAlert.textFields?[0] {
                            let text = field.text
                            self.heightLabel.text = text
                        }
                    }
                }))
                
                if let user = user {
                    alert!.actions[0].isEnabled = !(user.height.description.isEmpty)
                    alert!.textFields![0].text = "\(user.height)"
                } else {
                    alert!.actions[0].isEnabled = false
                }
                
                alert!.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                
                present(alert!, animated: true, completion: nil)
            }
            
            if indexPath.row == 6 {
                // navigate to medical history
                
            }
        }
        
        if indexPath.section == 2 {
            if indexPath.row == 0 {
                // navigate to email
                
                alert = UIAlertController(title: "Enter your email", message: nil, preferredStyle: .alert)
                alert!.addTextField(configurationHandler: {
                    field in
                    field.tag = 10005
                    field.delegate = self
                    field.keyboardAppearance = .default
                    field.keyboardType = .default
                    field.placeholder = "Type email here"
                })
                
                alert!.addAction(UIAlertAction(title: "Save", style: .default, handler: {
                    action in
                
                    // save to back-end
                    if let unwrappedAlert = self.alert {
                        if let field = unwrappedAlert.textFields?[0] {
                            let text = field.text
                            self.emailLabel.text = text
                        }
                    }
                }))
                
                if let user = user {
                    alert!.actions[0].isEnabled = !(user.email.isEmpty)
                    alert!.textFields![0].text = user.email
                } else {
                    alert!.actions[0].isEnabled = false
                }
                
                alert!.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                
                present(alert!, animated: true, completion: nil)
            }
            
            if indexPath.row == 1 {
                // navigate to phone number
                
                alert = UIAlertController(title: "Enter your phone number", message: nil, preferredStyle: .alert)
                alert!.addTextField(configurationHandler: {
                    field in
                    field.tag = 10006
                    field.delegate = self
                    field.keyboardAppearance = .default
                    field.keyboardType = .phonePad
                    field.placeholder = "Type number here"
                })
                
                alert!.addAction(UIAlertAction(title: "Save", style: .default, handler: {
                    action in
                
                    // save phone number to back-end
                    
                    if let unwrappedAlert = self.alert {
                        if let field = unwrappedAlert.textFields?[0] {
                            let text = field.text
                            self.phoneNumberLabel.text = text
                        }
                    }
                }))
                
                if let user = user {
                    alert!.actions[0].isEnabled = !(user.phoneNumber.isEmpty)
                    alert!.textFields![0].text = user.phoneNumber
                } else {
                    alert!.actions[0].isEnabled = false
                }
                
                alert!.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                
                present(alert!, animated: true, completion: nil)
            }
            
            if indexPath.row == 2 {
                // navigate to password
                
                alert = UIAlertController(title: "Enter your new password here", message: nil, preferredStyle: .alert)
                alert!.addTextField(configurationHandler: {
                    field in
                    field.tag = 10007
                    field.delegate = self
                    field.keyboardAppearance = .default
                    field.keyboardType = .default
                    field.isSecureTextEntry = true
                    field.placeholder = "Type password here"
                    self.newPassTextField = field
                })
                
                alert!.addTextField(configurationHandler: {
                    field in
                    field.tag = 10008
                    field.delegate = self
                    field.keyboardAppearance = .default
                    field.keyboardType = .default
                    field.isSecureTextEntry = true
                    field.placeholder = "Confirm password here"
                    self.confirmPassTextField = field
                })
                
                
                
                alert!.addAction(UIAlertAction(title: "Save", style: .default, handler: {
                   action in
                    
                    // save password to back-end
                }))
                
                alert!.actions[0].isEnabled = false
                
                
                alert!.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                
                present(alert!, animated: true, completion: nil)
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let alert = alert {
            switch textField.tag {
            case 10007:
                let isTyping = !string.isEmpty
                
                let newPassText: String
                if !isTyping {
                    let copy = newPassTextField!.text!
                    let index = copy.index(before: copy.endIndex)
                    newPassText = copy.substring(to: index)
                } else {
                    newPassText = newPassTextField!.text! + string
                }
                
                let confirmPassText = confirmPassTextField!.text!
                
                let isEnabled = !(newPassText.isEmpty) && !(confirmPassText.isEmpty) && newPassText == confirmPassText
                
                alert.actions[0].isEnabled = isEnabled
            case 10008:
                let isTyping = !string.isEmpty
                
                let newPassText = newPassTextField!.text!
                let confirmPassText: String
                if !isTyping {
                    let copy = confirmPassTextField!.text!
                    let index = copy.index(before: copy.endIndex)
                    confirmPassText = copy.substring(to: index)
                } else {
                    confirmPassText = confirmPassTextField!.text! + string
                }
                
                let isEnabled = !(newPassText.isEmpty) && !(confirmPassText.isEmpty) && newPassText == confirmPassText
                
                alert.actions[0].isEnabled = isEnabled
            default:
                let isTyping = !string.isEmpty
                let fullText: String
                if !isTyping {
                    let copy = textField.text!
                    let index = copy.index(before: copy.endIndex)
                    fullText = copy.substring(to: index)
                } else {
                    fullText = textField.text! + string
                }
                alert.actions[0].isEnabled = !fullText.isEmpty
            }
        }
        return true
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
     
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        avatarImageview.image = selectedImage
        
        
        
        if let data = UIImageJPEGRepresentation(selectedImage, 0.5) {
           
            
            // save data to back-end
            
        }
        
        
        
        
        dismiss(animated: true, completion: nil)
    }
    

    private func setupContent() {
        if let user = user {
            if let url = URL(string: user.imgUrl) {
                avatarImageview.kf.setImage(with: url)
            }
            nameLabel.text! = user.fullName
            genderLabel.text! = user.gender
            ageLabel.text! = "\(user.age)"
            cityLabel.text! = user.city
            weightLabel.text! = "\(user.weight)"
            heightLabel.text! = "\(user.height)"
            emailLabel.text! = user.email
            phoneNumberLabel.text! = user.phoneNumber
        }
    }

    
}
