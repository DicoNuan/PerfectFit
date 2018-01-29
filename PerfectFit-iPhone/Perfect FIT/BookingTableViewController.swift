
import UIKit

class BookingTableViewController: UITableViewController, UITextFieldDelegate, ActivitySearchSettingsDelegate, TypeSearchSettingsDelegate {

    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var datePicker: UIPickerView!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var startTimePicker: UIDatePicker!
    @IBOutlet weak var endTimeLabel: UILabel!
    @IBOutlet weak var endTimePicker: UIDatePicker!
    @IBOutlet weak var meetupLocationLabel: UILabel!
    @IBOutlet weak var trainerLabel: UILabel!
    @IBOutlet weak var activityLabel: UILabel!

    // MARK: lets
    let SECTION_ONE_CELL_SHORT_HEIGHT: CGFloat = 45
    let SECTION_ONE_CELL_FULL_HEIGHT: CGFloat = 172
    let MEET_UP_LOCATION_SEGUE = "MeetupLocationSegue"
    let SELECT_TRAINER_SEGUE = "SelectTrainerSegue"
    let MEDICAL_HISTORY_SEGUE = "MedicalHistorySegue"
    let SELECT_ACTIVITY_SEGUE = "SelectActivitySegue"
    static let STORYBOARD_ID = "BookingTableViewController"
    
    let PROMOTION_CODE_TAG = 10000
    
    // MARK: vars

    var isDatePickerShown = false
    var isStartTimePickerShown = false
    var isEndTimePickerShown = false

    var alert: UIAlertController?
    
    
    // MARK: overriden methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        alert = nil
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            
            if indexPath.row == 0 {
                return isDatePickerShown ? SECTION_ONE_CELL_FULL_HEIGHT : SECTION_ONE_CELL_SHORT_HEIGHT
            }
            
            if indexPath.row == 1 {
                return isStartTimePickerShown ? SECTION_ONE_CELL_FULL_HEIGHT : SECTION_ONE_CELL_SHORT_HEIGHT
            }
            
            if indexPath.row == 2 {
                return isEndTimePickerShown ? SECTION_ONE_CELL_FULL_HEIGHT : SECTION_ONE_CELL_SHORT_HEIGHT
            }
            
        }
        return super.tableView(tableView, heightForRowAt: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 {
            
            if indexPath.row == 0 {
                // show date picker
                setDatePickerShown()
                tableView.reloadData()
            }
            
            if indexPath.row == 1 {
                // show start time picker
                setStartTimePickerShown()
                tableView.reloadData()
            }
            
            if indexPath.row == 2 {
                // show end time picker
                setEndTimePickerShown()
                tableView.reloadData()
            }
            
            if indexPath.row == 3 {
                // navigate to meep-up location
                
                performSegue(withIdentifier: MEET_UP_LOCATION_SEGUE, sender: nil)
            }
        }
        
        
        if indexPath.section == 1 {
            
            if indexPath.row == 0 {
                // navigate to trainer
                
                performSegue(withIdentifier: SELECT_TRAINER_SEGUE, sender: nil)
            }
            
        }
        
        if indexPath.section == 2 {
            
            if indexPath.row == 0 {
                // navigate to medical history
                
                performSegue(withIdentifier: MEDICAL_HISTORY_SEGUE, sender: nil)
            }
            
        }
        
        if indexPath.section == 3 {
            
            if indexPath.row == 0 {
                // navigate to select activity
                
                performSegue(withIdentifier: SELECT_ACTIVITY_SEGUE, sender: nil)
            }
            
        }
        
        if indexPath.section == 4 {
            
            if indexPath.row == 0 {
                // open dialog for promotion code
                
                alert = UIAlertController(title: "Enter promotion code", message: nil, preferredStyle: .alert)
                alert!.addTextField(configurationHandler: {
                    field in
                    field.tag = self.PROMOTION_CODE_TAG
                    field.delegate = self
                    field.keyboardAppearance = .default
                    field.keyboardType = .default
                    field.placeholder = "Type code here"
                })
                
                alert!.addAction(UIAlertAction(title: "Done", style: .default, handler: {
                    action in
                    
                    // handle discount or anything related to promotion code 
                    
                }))
                
                alert!.actions[0].isEnabled = false
                alert!.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                
                present(alert!, animated: true, completion: nil)
            }
            
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let id = segue.identifier {
            if id == "SelectActivitySegue" {
                if let controller = segue.destination as? ActivitySearchSettingsTableViewController {
                    controller.delegate = self
                }
            }
            
            if id == "SelectTrainerSegue" {
                if let controller = segue.destination as? TypeSearchSettingsTableViewController {
                    controller.delegate = self
                }
            }
        }
    }
    
    
    // MARK: delegate methods
    
    func searchSettings(_ controller: ActivitySearchSettingsTableViewController, activity selected: String) {
        activityLabel.text = selected
    }
//
//    func searchSettings(_ controller: TrainersSearchSettingsTableViewController, type selected: String) {
//        trainerLabel.text = selected
//    }
//    
    func searchSettings(_ controller: TypeSearchSettingsTableViewController, type selected: String) {
        trainerLabel.text = selected
    }

    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let alert = alert {
            switch textField.tag {
            case PROMOTION_CODE_TAG:
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
            default:
                break
            }
        }
        
        return true
    }
    
    
    // MARK: private methods
    
    private func setDatePickerShown() {
        isDatePickerShown = !isDatePickerShown
        isStartTimePickerShown = false
        isEndTimePickerShown = false
    }
    
    private func setStartTimePickerShown() {
        isDatePickerShown = false
        isStartTimePickerShown = !isStartTimePickerShown
        isEndTimePickerShown = false
    }
    
    private func setEndTimePickerShown() {
        isDatePickerShown = false
        isStartTimePickerShown = false
        isEndTimePickerShown = !isEndTimePickerShown
    }
    

}
