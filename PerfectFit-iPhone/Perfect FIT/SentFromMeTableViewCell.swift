
import UIKit

class SentFromMeTableViewCell: UITableViewCell {

    // MARK: outlets
    
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var messageDeliveryIcon: UIImageView!
    
    // MARK: lets
    static let CELL_ID = "SentFromMeTableViewCell"
    
    // MARK: overriden methods
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        messageTextView.textContainerInset = UIEdgeInsets(top: 8, left: 10, bottom: 8, right: 10)
    }

    

}
