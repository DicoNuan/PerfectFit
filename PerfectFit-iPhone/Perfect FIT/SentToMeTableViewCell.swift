

import UIKit

class SentToMeTableViewCell: UITableViewCell {

    // MARK: outlets
    
    @IBOutlet weak var messageTextView: UITextView!

    // MARK: lets
    
    static let CELL_ID = "SentToMeTableViewCell"

    // MARK: overriden methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        messageTextView.textContainerInset = UIEdgeInsets(top: 8, left: 10, bottom: 8, right: 10)
    }

}
