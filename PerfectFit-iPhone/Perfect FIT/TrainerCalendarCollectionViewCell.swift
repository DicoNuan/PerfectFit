

import UIKit

class TrainerCalendarCollectionViewCell: UICollectionViewCell {

    // MARK: outlets
    
    @IBOutlet weak var weekDayLabel: UILabel!
    @IBOutlet weak var monthDayLabel: UILabel!
    @IBOutlet var bookedTimeDots: [UIImageView]!
    
    
    // MARK: lets
    static let CELL_ID = "TrainerCalendarCollectionViewCell"
    
}

