

import UIKit

class FeedCollectionViewCell: UICollectionViewCell {
 
    // MARK: outlets
    
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var flagImg: UIImageView!
    @IBOutlet weak var activityLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var pricePerHourLabel: UILabel!
    
    
    // MARK: lets
    
    static let CELL_ID: String = "FeedCollectionViewCell"
    
}
