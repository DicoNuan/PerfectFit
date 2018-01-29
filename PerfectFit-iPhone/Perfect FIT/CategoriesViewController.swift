

import UIKit



class CategoriesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    
    // MARK: outlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    // MARK: lets
    
    fileprivate let sectionInsets = UIEdgeInsets(top: 0.0, left: 9.0, bottom: 0.0, right: 0.0)
    let CELL_HEIGHT = 45
    let FILLED_CHECKBOX_IMG = "filled_checkbox"
    let EMPTY_CHECKBOX_IMG = "empty_checkbox"
    
    
    // MARK: vars
    
    var categories: [UIActivityCategoryModel] = []
    
    
    // MARK: override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // load categories from back-end
        loadCategories()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        setupNavBar(navigationController?.navigationBar)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    // MARK: actions
    
    @IBAction func okayButtonPressed(_ sender: UIButton) {
        if let navigationController = navigationController {
            navigationController.popViewController(animated: true)
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
    
    
    // MARK: delegate methods
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories[section].activities.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        categories[indexPath.section].activities[indexPath.row].isChecked = !categories[indexPath.section].activities[indexPath.row].isChecked
        
        if let cell = collectionView.cellForItem(at: indexPath) as? CategoryCollectionViewCell {
            updateCell(at: cell, relatedTo: categories[indexPath.section].activities[indexPath.row])
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.CELL_ID, for: indexPath) as! CategoryCollectionViewCell
        
        updateCell(at: cell, relatedTo: categories[indexPath.section].activities[indexPath.row])
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let widthPerItem = ((view.window!.frame.width - (sectionInsets.left * 2.0)) / 2.0) - 1
        let heightPerItem = CELL_HEIGHT
        
        
        return CGSize(width: CGFloat(widthPerItem), height: CGFloat(heightPerItem))
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CategoryHeaderCollectionReusableView.VIEW_ID, for: indexPath) as! CategoryHeaderCollectionReusableView
        
        header.headerTitleLabel.text = categories[indexPath.section].title
        
        return header
    }
    
    
    // MARK: private methods
    
    private func updateCell(at cell: CategoryCollectionViewCell, relatedTo item: UIActivityModel) {
        cell.title.text = item.activity
        
        if item.isChecked {
            cell.checkbox.image = UIImage(named: FILLED_CHECKBOX_IMG)
        } else {
            cell.checkbox.image = UIImage(named: EMPTY_CHECKBOX_IMG)
        }
    }
    
    private func loadCategories() {
        let activities: [UIActivityModel] = [
            UIActivityModel(activity: "Aerobics"),
            UIActivityModel(activity: "Aerobics"),
            UIActivityModel(activity: "Bicycling"),
            UIActivityModel(activity: "Bicycling"),
            UIActivityModel(activity: "Bicycling"),
            UIActivityModel(activity: "Bicycling"),
            UIActivityModel(activity: "Bicycling"),
            UIActivityModel(activity: "Bicycling")]
        
        categories.append(UIActivityCategoryModel(title: "AEROBIC SPORTS", activities: activities))
        categories.append(UIActivityCategoryModel(title: "AEROBIC AND WRESTLING SPORTS", activities: activities))
        categories.append(UIActivityCategoryModel(title: "PLAYING SPORTS", activities: activities))
    }
}
