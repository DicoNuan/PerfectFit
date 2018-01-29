

import UIKit

class BookingCalendarCollectionViewCell: UICollectionViewCell {
    
    // MARK: outlets
    
    @IBOutlet weak var weekDayLabel: UILabel!
    @IBOutlet weak var monthDayLabel: UILabel!
    @IBOutlet weak var pickedDayImg: UIImageView!
    
    
    // MARK: lets
    
    static let CELL_ID = "BookingCalendarCollectionViewCell"
}
