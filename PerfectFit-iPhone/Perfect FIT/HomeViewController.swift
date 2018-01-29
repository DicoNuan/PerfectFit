

import UIKit
import BTNavigationDropdownMenu

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

    
    // MARK: outlets
    
    @IBOutlet weak var cityBarButton: UIBarButtonItem!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: lets
    
    let CATEGORIES_VIEW_CONTROLLER = "CategoriesViewController"
    let SEARCH_SETTINGS_TABLE_VIEW_CONTROLLER = "SearchSettingsTableViewController"
    let TRAINER_PROFILE_TABLE_VIEW_CONTROLLER = "TrainerProfileTableViewController"
    
    fileprivate let sectionInsets = UIEdgeInsets(top: 0.0, left: 22.5, bottom: 8.0, right: 22.5)
    fileprivate let middleInset: CGFloat = 30.0
    let AVATAR_TITLE_VIEW_WIDTH: CGFloat = 30
    let AVATAR_TITLE_VIEW_HEIGHT: CGFloat = 30
    let NAVIGATION_BAR_DIVIDER_HEIGHT: CGFloat = 1
    private let RELATION_COEFFICIENT: CGFloat = 0.66
    
    // MARK: vars
    
    var dropDownMenu: BTNavigationDropdownMenu?
    var tapGestureRecognizer: UITapGestureRecognizer?
    var feed: [UIFeedItem] = []
    var countries: [String] = []
    
    
    // MARK: overriden methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // load feed items
        loadFeed()
        loadCountries()
    
        searchBar.delegate = self
        collectionView.dataSource = self
        collectionView.delegate = self
        
        
        setupNavBar(navigationController?.navigationBar)
        setupNavBarLogo()
        setupDropDownMenu()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        releaseTapGestureListener()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        releaseTapGestureListener()
    }
    
    
    // MARK: actions
    
    @IBAction func addButtonPressed() {
        if let categoriesViewController = storyboard?.instantiateViewController(withIdentifier: CATEGORIES_VIEW_CONTROLLER) as? CategoriesViewController {
            categoriesViewController.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(categoriesViewController, animated: true)
        }
    }
    
    
    @IBAction func filterButtonPressed() {
        if let searchSettingsController = storyboard?.instantiateViewController(withIdentifier: SEARCH_SETTINGS_TABLE_VIEW_CONTROLLER) as? SearchSettingsTableViewController {
            searchSettingsController.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(searchSettingsController, animated: true)
        }
    }
    
    @IBAction func cityBarButtonPressed(_ sender: UIBarButtonItem) {
        guard let dropDownMenu = dropDownMenu else {
            return
        }
        
        dropDownMenu.toggle()
    }
    
    func dismissKeyboard(recognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    
    // MARK: delegate methods
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: FeedCollectionViewCell.CELL_ID, for: indexPath) as! FeedCollectionViewCell
        
        let model = feed[indexPath.row]
        if let url = URL(string: model.trainer.imgUrl) {
            item.avatar.kf.setImage(with: url)
        } else {
            if indexPath.row == 0 {
                item.avatar.image = UIImage(named: "test_ava")
            } else if indexPath.row == 1 {
                item.avatar.image = UIImage(named: "test_ava2")
            } else if indexPath.row == 2 {
                item.avatar.image = UIImage(named: "test_ava3")
            } else if indexPath.row == 3 {
                item.avatar.image = UIImage(named: "test_ava4")
            } 
        }
        
        item.nameLabel.text = model.trainer.fullName
        item.activityLabel.text = model.trainer.activity
        item.flagImg.image = UIImage(named: "ic_test_country")
        item.ratingLabel.text = "4,7(5)"
        item.pricePerHourLabel.text = "15 KD/hr"
        
        return item
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthPerItem = (view.window!.frame.width - (sectionInsets.left + sectionInsets.right + middleInset)) / 2.0
        let heightPerItem = widthPerItem / RELATION_COEFFICIENT
        
        return CGSize(width: CGFloat(widthPerItem), height: CGFloat(heightPerItem))
    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return feed.count
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        if let trainerViewController = storyboard?.instantiateViewController(withIdentifier: TRAINER_PROFILE_TABLE_VIEW_CONTROLLER) as? TrainerProfileTableViewController {
            trainerViewController.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(trainerViewController, animated: true)
        }
    }
    

    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGestureRecognizer!)
        return true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        releaseTapGestureListener()
    }

    
    
    // MARK: private methods
    
    private func loadFeed() {
        feed.append(UIFeedItem(trainer: UITrainerModel(fullName: "Amanda Fisher", imgUrl: "", gender: "Female", age: 123, city: "Chernihiv", weight: 123, height: 291, email: "pp@gmail,com", phoneNumber: "12kjalskdjalskd", activity: "MMA")))
        feed.append(UIFeedItem(trainer: UITrainerModel(fullName: "Amanda Fisher", imgUrl: "", gender: "Female", age: 123, city: "Chernihiv", weight: 123, height: 291, email: "pp@gmail,com", phoneNumber: "12kjalskdjalskd", activity: "MMA")))
        feed.append(UIFeedItem(trainer: UITrainerModel(fullName: "Amanda Fisher", imgUrl: "", gender: "Female", age: 123, city: "Chernihiv", weight: 123, height: 291, email: "pp@gmail,com", phoneNumber: "12kjalskdjalskd", activity: "MMA")))
        feed.append(UIFeedItem(trainer: UITrainerModel(fullName: "Amanda Fisher", imgUrl: "", gender: "Female", age: 123, city: "Chernihiv", weight: 123, height: 291, email: "pp@gmail,com", phoneNumber: "12kjalskdjalskd", activity: "MMA")))
    }
    
    private func releaseTapGestureListener() {
        if let recognizer = tapGestureRecognizer {
            view.removeGestureRecognizer(recognizer)
            tapGestureRecognizer = nil
        }
    }
    
    private func loadCountries() {
        countries.append("Kuwait")
        countries.append("China")
        countries.append("Russia")
        countries.append("France")
        countries.append("USA")
        countries.append("Italy")
        countries.append("Belarus")
        countries.append("Germany")
        countries.append("England")
        countries.append("Mexico")
        countries.append("Spain")
        countries.append("Turkey")
        countries.append("Bulgary")
        countries.append("Hungary")
    }
    
    private func setupNavBarLogo() {
        let imageView = UIImageView(image: UIImage(named: "login_logo"))
        imageView.contentMode = UIViewContentMode.scaleAspectFill
//        imageView.clipsToBounds = true
//        imageView.layer.masksToBounds = true
//        imageView.layer.cornerRadius = AVATAR_CORNER_RADIUS
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: AVATAR_TITLE_VIEW_WIDTH, height: AVATAR_TITLE_VIEW_HEIGHT))
        imageView.frame = titleView.bounds
        titleView.addSubview(imageView)
        
        if let navigationController = self.navigationController {
            
            let navigationBar = navigationController.navigationBar
            let navBorder: UIView = UIView(frame: CGRect(x: 0, y: navigationBar.frame.size.height, width: navigationBar.frame.size.width, height: NAVIGATION_BAR_DIVIDER_HEIGHT))
            // Set the color you want here
            navBorder.backgroundColor = hexStringToUIColor(hex: navigationBarBlack)
            navBorder.isOpaque = true
            self.navigationController?.navigationBar.addSubview(navBorder)
        }
        
        self.navigationItem.titleView = titleView
    }
    
    
    private func setupDropDownMenu() {
        dropDownMenu = BTNavigationDropdownMenu(
            navigationController: self.navigationController,
            containerView: self.navigationController!.view,
            title: countries.isEmpty ? "" : countries[0],
            items: countries as [AnyObject]
        )
        
        guard let dropDownMenu = dropDownMenu else {
            return
        }
        
        dropDownMenu.didSelectItemAtIndexHandler = {(indexPath: Int) -> () in
            self.cityBarButton.title = self.countries[indexPath]
            print("Did select item at index: \(indexPath)")
        }
    }
}
