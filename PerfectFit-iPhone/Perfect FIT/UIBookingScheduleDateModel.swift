

import Foundation


class UIBookingScheduleDateModel {
    
    var weekDay: String
    var monthDay: String
    var isHighlighted: Bool
    
    init(weekDay: String, monthDay: String, isHighlighted: Bool) {
        self.weekDay = weekDay
        self.monthDay = monthDay
        self.isHighlighted = isHighlighted
    }
    
}
