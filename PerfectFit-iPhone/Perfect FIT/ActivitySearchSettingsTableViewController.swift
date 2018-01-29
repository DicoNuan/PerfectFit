
import UIKit

protocol ActivitySearchSettingsDelegate: class {
    
    func searchSettings(_ controller: ActivitySearchSettingsTableViewController, activity selected: String)
    
}

class ActivitySearchSettingsTableViewController: UITableViewController, UISearchResultsUpdating, UISearchBarDelegate, UISearchControllerDelegate {

    
    // MARK: lets
    
    let ACTIVITY_TABLE_VIEW_CELL_ID = "ActivityTableViewCell"
    let SECTION_TITLE = "Select activity"
    
    
    // MARK: vars
    
    var activities: [UIActivityModel] = []
    var filtered: [UIActivityModel] = []
    var selectedIndex = 0
    var searchController: UISearchController?
    var delegate: ActivitySearchSettingsDelegate?
    
    
    // MARK: overriden methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // load activities
        loadActivities()
        
        setupSearchController()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        searchController = nil
        delegate = nil
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let searchController = searchController else {
            return 0
        }
        
        if searchController.isActive && searchController.searchBar.text != "" {
            return filtered.count
        } else {
            return activities.count
        }
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        selectedIndex = indexPath.row
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return SECTION_TITLE
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ACTIVITY_TABLE_VIEW_CELL_ID, for: indexPath)
        
        guard let searchController = searchController else {
            return cell
        }
        
        cell.accessoryType = (selectedIndex == indexPath.row) ? .checkmark : .none
        
        if let label = cell.textLabel {
            if searchController.isActive && searchController.searchBar.text != "" {
                label.text = filtered[indexPath.row].activity
            } else {
                label.text = activities[indexPath.row].activity
            }
        }
        return cell
    }
    
    // MARK: actions
    
    @IBAction func doneButtonPressed() {
        delegate?.searchSettings(self, activity: activities[selectedIndex].activity)
        if let navigationController = navigationController {
            navigationController.popViewController(animated: true)
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
    
    
    // MARK: delegate methods
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
    
    
    // MARK: private methods
    
    private func setupSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        guard let searchController = searchController else {
            return
        }
        
        searchController.searchBar.tintColor = hexStringToUIColor(hex: greenColor)
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchBar.autoresizingMask = UIViewAutoresizing.flexibleWidth
        searchController.searchBar.sizeToFit()
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
    }
    
    
    private func filterContentForSearchText(searchText: String) {
        filtered = activities.filter { activity in
            return activity.activity.lowercased().contains(searchText.lowercased())
        }
        
        tableView.reloadData()
    }
    
    
    private func loadActivities() {
        activities.append(UIActivityModel(activity: "All categories"))
        activities.append(UIActivityModel(activity: "Aerobatics"))
        activities.append(UIActivityModel(activity: "Air racing"))
        activities.append(UIActivityModel(activity: "Gungdo"))
        activities.append(UIActivityModel(activity: "Badminton"))
        activities.append(UIActivityModel(activity: "Bossaball"))
        activities.append(UIActivityModel(activity: "Pickelball"))
        activities.append(UIActivityModel(activity: "Slamball"))
        activities.append(UIActivityModel(activity: "Gymnastics"))
        activities.append(UIActivityModel(activity: "Snowkiting"))
        activities.append(UIActivityModel(activity: "Basketball"))
    }
}
