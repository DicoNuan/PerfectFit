
import UIKit


class SearchSettingsTableViewController: UITableViewController, ActivitySearchSettingsDelegate, CitySearchSettingsDelegate, GenderSearchSettingsDelegate, TrainersSearchSettingsDelegate, AffiliatedWithGymSearchSettingsDelegate, TypeSearchSettingsDelegate {
    

    // MARK: outlets
    
    @IBOutlet weak var activityLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var trainersLabel: UILabel!
    @IBOutlet weak var affiliatedWithGym: UILabel!
    
    
    
    // MARK: overriden methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initCells()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let id = segue.identifier else {
            return
        }
        
        
        if id == "ActivitySearchSettingsSegue" {
            if let controller = segue.destination as? ActivitySearchSettingsTableViewController {
                controller.delegate = self
            }
        }
        
        if id == "CitiesSearchSettingsSegue" {
            if let controller = segue.destination as? CitiesSearchSettingsTableViewController {
                controller.delegate = self
            }
        }
        
        if id == "GenderSearchSettingsSegue" {
            if let controller = segue.destination as? GenderSearchSettingsTableViewController {
                controller.delegate = self
            }
        }
        
        if id == "TypeSearchSettingsSegue" {
            if let controller = segue.destination as? TypeSearchSettingsTableViewController {
                controller.delegate = self
            }
        }
        
        if id == "TrainersSearchSettingsSegue" {
            if let controller = segue.destination as? TrainersSearchSettingsTableViewController {
               controller.delegate = self
            }
        }
        
        if id == "AffiliatedWithGymSearchSettingsSegue" {
            if let controller = segue.destination as? AffiliatedWithGymSearchSettingsTableViewController {
                controller.delegate = self
            }
        }

    }
    
    
    // MARK: actions

    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        if let navigationController = navigationController {
            navigationController.popViewController(animated: true)
        } else {
            dismiss(animated: true, completion: nil)
        }
    }

    // MARK: delegate methods
    
    func searchSettings(_ controller: CitiesSearchSettingsTableViewController, city selected: String) {
        countryLabel.text = selected
    }
    
    func searchSettings(_ controller: ActivitySearchSettingsTableViewController, activity selected: String) {
        activityLabel.text = selected
    }
    
    func searchSettings(_ controller: GenderSearchSettingsTableViewController, gender selected: String) {
        genderLabel.text = selected
    }
    
    func searchSettings(_ controller: AffiliatedWithGymSearchSettingsTableViewController, affiliatedWithGym selected: String) {
        affiliatedWithGym.text = selected
    }
    
    func searchSettings(_ controller: TrainersSearchSettingsTableViewController, trainers selected: String) {
        trainersLabel.text = selected
    }
    
    func searchSettings(_ controller: TypeSearchSettingsTableViewController, type selected: String) {
        typeLabel.text = selected
    }
    
    
    // MARK: private methods
    
    private func initCells() {
        activityLabel.text = "All categories"
        countryLabel.text = "All cities"
        genderLabel.text = "Male"
        typeLabel.text = "In-call (Train at my Location)"
        trainersLabel.text = "Individuals"
        affiliatedWithGym.text = "Yes"
    }

}

