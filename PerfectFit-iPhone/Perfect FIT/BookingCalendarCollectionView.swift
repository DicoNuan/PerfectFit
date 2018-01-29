

import UIKit


protocol BookingCalendarCollectionViewDelegate: class {
    
    func bookingCalendar(_ view: BookingCalendarCollectionView, didSelectCellAt index: Int, with item: UIBookingScheduleDateModel)
    
}


class BookingCalendarCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    // MARK: lets
    
    let edgeInsets: UIEdgeInsets = UIEdgeInsets(top: 18, left: 0, bottom: 12, right: 0)
    let NUMBER_OF_SECTIONS = 1
    let DEFAULT_CELL_HEIGHT: CGFloat = 60
    let DEFAULT_CELL_WIDTH: CGFloat = 38
    let NUMBER_OF_DAYS_TO_DISPLAY = 30
    static let COLLECTION_VIEW_LEFT_MARGIN: CGFloat = 45
    static let NUMBER_OF_CELLS_TO_DISPLAY_AT_ONCE: CGFloat = 7
    static let MARGIN_BETWEEN_CELLS: CGFloat = 10
    
    // MARK: vars
    
    var position: Int = 0
    var dates: [UIBookingScheduleDateModel] = []
    var selectDelegate: BookingCalendarCollectionViewDelegate?
    
    // MARK: overriden methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        loadDates()
        
        dataSource = self
        delegate = self
    }
    
    
    // MARK: delegate methods
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return NUMBER_OF_SECTIONS
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dates.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookingCalendarCollectionViewCell.CELL_ID, for: indexPath) as! BookingCalendarCollectionViewCell
        
        let model = dates[indexPath.row]
        
        cell.pickedDayImg.isHidden = !(indexPath.row == position)
        cell.weekDayLabel.text = model.weekDay
        cell.monthDayLabel.text = model.monthDay
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return edgeInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let screenWidth = window!.frame.width
        let availableSpace = screenWidth - edgeInsets.left - BookingCalendarCollectionView.COLLECTION_VIEW_LEFT_MARGIN - (BookingCalendarCollectionView.MARGIN_BETWEEN_CELLS * (BookingCalendarCollectionView.NUMBER_OF_CELLS_TO_DISPLAY_AT_ONCE - 1))
        let cellWidth = availableSpace / BookingCalendarCollectionView.NUMBER_OF_CELLS_TO_DISPLAY_AT_ONCE
        
        
        return CGSize(width: cellWidth, height: DEFAULT_CELL_HEIGHT)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        position = indexPath.row
        reloadData()
        collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
        selectDelegate?.bookingCalendar(self, didSelectCellAt: indexPath.row, with: dates[indexPath.row])
    }
    
    
    // MARK: private methods
    
    private func loadDates() {
        let currentDate = Date()
        let calendar = Calendar.current
        let currentYear = calendar.component(.year, from: currentDate)
        let currentMonth = calendar.component(.month, from: currentDate)
        let currentDay = calendar.component(.day, from: currentDate)
        
        var components = DateComponents()
        components.year = currentYear
        components.month = currentMonth
        components.day = currentDay
        
        
        let dateWeekFormatter = DateFormatter()
        let dateMonthFormatter = DateFormatter()
        dateWeekFormatter.dateFormat = "EEE"
        dateMonthFormatter.dateFormat = "dd"
        
        let numberOfDays = NUMBER_OF_DAYS_TO_DISPLAY
        for i in 0 ..< numberOfDays {
            components.day = currentDay + i
            let incrementerDate = calendar.date(from: components)
            let currentWeekDateString = dateWeekFormatter.string(from: incrementerDate!)
            let currentMonthDateString = dateMonthFormatter.string(from: incrementerDate!)
            
            let date = UIBookingScheduleDateModel(weekDay: currentWeekDateString, monthDay: currentMonthDateString, isHighlighted: i == 0)
            dates.append(date)
        }
    }
}
