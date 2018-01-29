

import UIKit

protocol TrainersSearchSettingsDelegate: class {
    
    func searchSettings(_ controller: TrainersSearchSettingsTableViewController, trainers selected: String)
    
}

class TrainersSearchSettingsTableViewController: UITableViewController {
    
    
    // MARK: outlets
    
    @IBOutlet weak var groupsCell: UITableViewCell!
    @IBOutlet weak var individualsCell: UITableViewCell!

    // MARK: vars
    
    var selectedIndex = 0
    var trainers: [String] = ["Groups", "Individuals"]
    var delegate: TrainersSearchSettingsDelegate?
    

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
            checkGroupsOption()
        }
        
        if indexPath.row == 1 {
            checkIndividualOption()
        }
    }
    
    
    // MARK: actions
    
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        delegate?.searchSettings(self, trainers: trainers[selectedIndex])
        if let navigationController = navigationController {
            navigationController.popViewController(animated: true)
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
    
    // MARK: private methods
    
    private func checkGroupsOption() {
        groupsCell.accessoryType = .checkmark
        individualsCell.accessoryType = .none
    }
    
    
    private func checkIndividualOption() {
        groupsCell.accessoryType = .none
        individualsCell.accessoryType = .checkmark
    }
    
}
