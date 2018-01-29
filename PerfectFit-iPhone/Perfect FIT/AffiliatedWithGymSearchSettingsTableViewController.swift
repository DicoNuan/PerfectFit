

import UIKit

protocol AffiliatedWithGymSearchSettingsDelegate: class {
    
    func searchSettings(_ controller: AffiliatedWithGymSearchSettingsTableViewController, affiliatedWithGym selected: String)
    
}

class AffiliatedWithGymSearchSettingsTableViewController: UITableViewController {

    // MARK: outlets
    
    @IBOutlet weak var bothCell: UITableViewCell!
    @IBOutlet weak var yesCell: UITableViewCell!
    @IBOutlet weak var noCell: UITableViewCell!
    
    
    // MARK: vars
    
    var selectedIndex = 0
    var affiliatedWithGym: [String] = ["Both", "Yes", "No"]
    var delegate: AffiliatedWithGymSearchSettingsDelegate?
    
    
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
            checkBothOption()
        }
        
        if indexPath.row == 1 {
            checkYesOption()
        }
        
        if indexPath.row == 2 {
            checkNoOption()
        }
    }

    
    // MARK: actions
    
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        delegate?.searchSettings(self, affiliatedWithGym: affiliatedWithGym[selectedIndex])
        if let navigationController = navigationController {
            navigationController.popViewController(animated: true)
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
    
    
    // MARK: private methods
    
    private func checkBothOption() {
        bothCell.accessoryType = .checkmark
        yesCell.accessoryType = .none
        noCell.accessoryType = .none
    }
    
    private func checkYesOption() {
        bothCell.accessoryType = .none
        yesCell.accessoryType = .checkmark
        noCell.accessoryType = .none
    }
    
    private func checkNoOption() {
        bothCell.accessoryType = .none
        yesCell.accessoryType = .none
        noCell.accessoryType = .checkmark
    }
}
