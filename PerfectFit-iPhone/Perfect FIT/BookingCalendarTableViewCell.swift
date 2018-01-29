

import UIKit

class BookingCalendarTableViewCell: UITableViewCell {

    // MARK: outlet
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet var indicators: [UIView] = []
    
    
    // MARK: lets
    
    static let CELL_ID = "BookingCalendarTableViewCell"
    let INDICATOR_WIDTH: CGFloat = 12
    
    // MARK: public methods
    
    func setupIndicators() {
        let weekDayScheduleCellWidth = getWeekDayScheduleCellWidth()
        
        let firstIndicator = indicators[0]
        firstIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        let oldFirstIndicatorFrame = firstIndicator.frame
        let newFirstIndicatorOriginX = BookingCalendarCollectionView.COLLECTION_VIEW_LEFT_MARGIN + (weekDayScheduleCellWidth / 2.0) - (INDICATOR_WIDTH / 2.0)
        let newFirstIndicatorFrame = CGRect(
            x: newFirstIndicatorOriginX,
            y: oldFirstIndicatorFrame.origin.y,
            width: oldFirstIndicatorFrame.width,
            height: oldFirstIndicatorFrame.height
        )
        
        firstIndicator.frame = newFirstIndicatorFrame
        
        
        var leftMargin = newFirstIndicatorOriginX
        for i in 1 ..< indicators.count {
            let indicator = indicators[i]
            indicator.translatesAutoresizingMaskIntoConstraints = false
            let oldIndicatorFrame = indicator.frame
            let newIndicatorOriginX = leftMargin + BookingCalendarCollectionView.MARGIN_BETWEEN_CELLS + weekDayScheduleCellWidth
            let newIndicatorFrame = CGRect(x: newIndicatorOriginX, y: oldIndicatorFrame.origin.y, width: oldIndicatorFrame.width, height: oldIndicatorFrame.height)
            indicator.frame = newIndicatorFrame
            leftMargin = newIndicatorOriginX
        }
        
        
    }
    
    
    // MARK: private methods

    private func getWeekDayScheduleCellWidth() -> CGFloat {
        let screenWidth = window!.frame.width
        let availableSpace = screenWidth - 0 - BookingCalendarCollectionView.COLLECTION_VIEW_LEFT_MARGIN - (BookingCalendarCollectionView.MARGIN_BETWEEN_CELLS * (BookingCalendarCollectionView.NUMBER_OF_CELLS_TO_DISPLAY_AT_ONCE - 1))
        let cellWidth = availableSpace / BookingCalendarCollectionView.NUMBER_OF_CELLS_TO_DISPLAY_AT_ONCE
        return cellWidth
    }
}
