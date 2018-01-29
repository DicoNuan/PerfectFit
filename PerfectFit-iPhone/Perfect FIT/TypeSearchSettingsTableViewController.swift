
import UIKit

protocol TypeSearchSettingsDelegate: class {
    
    func searchSettings(_ controller: TypeSearchSettingsTableViewController, type selected: String)
    
}

class TypeSearchSettingsTableViewController: UITableViewController {

    // MARK: outlets
    
    @IBOutlet weak var incallCell: UITableViewCell!
    @IBOutlet weak var outcallCell: UITableViewCell!
    
    // MARK: vars
    
    var selectedIndex = 0
    var types: [String] = ["In-call (Train at my Location)", "Outcall (Train at your Location)"]
    var delegate: TypeSearchSettingsDelegate?
    
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
            checkIncallOption()
        }
        
        if indexPath.row == 1 {
            checkOutcallOption()
        }
    }
    
    // MARK: actions
    
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        delegate?.searchSettings(self, type: types[selectedIndex])
        if let navigationController = navigationController {
            navigationController.popViewController(animated: true)
        } else {
            dismiss(animated: true, completion: nil)
        }
    }

    
    // MARK: private methods
    
    private func checkIncallOption() {
        incallCell.accessoryType = .checkmark
        outcallCell.accessoryType = .none
    }
    
    private func checkOutcallOption() {
        incallCell.accessoryType = .none
        outcallCell.accessoryType = .checkmark
    }
}
