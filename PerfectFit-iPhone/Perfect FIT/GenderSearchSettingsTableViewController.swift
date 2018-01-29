

import UIKit

protocol GenderSearchSettingsDelegate: class {
    
    func searchSettings(_ controller: GenderSearchSettingsTableViewController, gender selected: String)
    
}

class GenderSearchSettingsTableViewController: UITableViewController {

    // MARK: outlets
    
    @IBOutlet weak var maleCell: UITableViewCell!
    @IBOutlet weak var femaleCell: UITableViewCell!
    @IBOutlet weak var anyCell: UITableViewCell!
    
    
    // MARK: vars
    
    var selectedIndex = 0
    var genders: [String] = ["Male", "Female", "Any"]
    var delegate: GenderSearchSettingsDelegate?
    
    
    // MARK: overriden methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tintColor = hexStringToUIColor(hex: greenColor)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        delegate = nil
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        selectedIndex = indexPath.row
        if indexPath.row == 0 {
            checkMaleOption()
        }
        
        if indexPath.row == 1 {
            checkFemaleOption()
        }
        
        if indexPath.row == 2 {
            checkAnyOption()
        }
    }
    
    // MARK: actions
    
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        delegate?.searchSettings(self, gender: genders[selectedIndex])
        if let navigationController = navigationController {
            navigationController.popViewController(animated: true)
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
    
    
    // MARK: private methods
    
    private func checkMaleOption() {
        maleCell.accessoryType = .checkmark
        femaleCell.accessoryType = .none
        anyCell.accessoryType = .none
    }
    
    private func checkFemaleOption() {
        maleCell.accessoryType = .none
        femaleCell.accessoryType = .checkmark
        anyCell.accessoryType = .none
    }
    
    private func checkAnyOption() {
        maleCell.accessoryType = .none
        femaleCell.accessoryType = .none
        anyCell.accessoryType = .checkmark
    }
    
}
