

import UIKit

class BookingSelectTimeTableViewCell: UITableViewCell {

    // MARK: outlets
    
    @IBOutlet weak var selectDate: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var chevron: UIImageView!
    @IBOutlet weak var timePicker: UIDatePicker!
    
    
    // MARK: overriden methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        timePicker.addTarget(self, action: #selector(dateChanged), for: UIControlEvents.valueChanged)
        initContent()
    }

    
    // MARK: actions
    
    
    func dateChanged() {
        initContent()
    }
    
  
    // MARK: private methods

    private func initContent() {
        let value = timePicker.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        date.text = dateFormatter.string(from: value)
    }
}
