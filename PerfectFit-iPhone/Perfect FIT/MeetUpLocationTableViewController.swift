

import UIKit

class MeetUpLocationTableViewController: UITableViewController {

    @IBOutlet weak var locationTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    
    @IBAction func locationDoneButtonPressed() {
        locationTextField.resignFirstResponder()
    }
}
