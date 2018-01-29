
import UIKit

protocol CitySearchSettingsDelegate: class {
    
    func searchSettings(_ controller: CitiesSearchSettingsTableViewController, city selected: String)
    
}

class CitiesSearchSettingsTableViewController: UITableViewController, UISearchResultsUpdating, UISearchBarDelegate, UISearchControllerDelegate {

    // MARK: lets
    let CITY_TABLE_VIEW_CELL_ID = "CityTableViewCell"
    let SECTION_TITLE = "Select city"
    
    // MARK: vars
    
    var countries: [UICountryModel] = []
    var filtered: [UICountryModel] = []
    var selectedIndex = 0
    var searchController: UISearchController?
    var delegate: CitySearchSettingsDelegate?
    
    
    // MARK: overriden methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // load countries from back-end
        loadCountries()
        
        
        setupSearchController()
        tableView.tintColor = hexStringToUIColor(hex: greenColor)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        searchController = nil
        delegate = nil
    }


    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return SECTION_TITLE
    }
  
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let searchController = searchController else {
            return 0
        }
        
        if searchController.isActive && searchController.searchBar.text != "" {
            return filtered.count
        } else {
            return countries.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CITY_TABLE_VIEW_CELL_ID, for: indexPath)
        
        guard let searchController = searchController else {
            return cell
        }
        
        
        cell.accessoryType = (selectedIndex == indexPath.row) ? .checkmark : .none
        
        if let label = cell.textLabel {
            if searchController.isActive && searchController.searchBar.text != "" {
                label.text = filtered[indexPath.row].name
            } else {
                label.text = countries[indexPath.row].name
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        selectedIndex = indexPath.row
        tableView.reloadData()
    }
    
    
    // MARK: actions
    @IBAction func doneButtonPressed() {
        delegate?.searchSettings(self, city: countries[selectedIndex].name)
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
        filtered = countries.filter { country in
            return country.name.lowercased().contains(searchText.lowercased())
        }
        
        tableView.reloadData()
    }
    
    private func loadCountries() {
        countries.append(UICountryModel(name: "All cities", phoneCode: "+3950"))
        countries.append(UICountryModel(name: "Bayan", phoneCode: "+3950"))
        countries.append(UICountryModel(name: "Bnied Al-Gar", phoneCode: "+3950"))
        countries.append(UICountryModel(name: "Hawalli", phoneCode: "+3950"))
        countries.append(UICountryModel(name: "Mishref", phoneCode: "+3950"))
        countries.append(UICountryModel(name: "Salmiya", phoneCode: "+3950"))
        countries.append(UICountryModel(name: "Salwa", phoneCode: "+3950"))
        countries.append(UICountryModel(name: "Sharq", phoneCode: "+3950"))
        countries.append(UICountryModel(name: "Al-Jabriya", phoneCode: "+3950"))
        countries.append(UICountryModel(name: "Abdullah Al-Salem", phoneCode: "+3950"))
        countries.append(UICountryModel(name: "Doha", phoneCode: "+3950"))
        countries.append(UICountryModel(name: "Faiha", phoneCode: "+3950"))
    }
}
