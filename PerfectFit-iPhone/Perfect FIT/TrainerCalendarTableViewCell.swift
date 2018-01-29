
import UIKit


protocol TrainerCalendarTableViewCellDelegate: class {

    func trainerCalendar(_ cell: TrainerCalendarTableViewCell, didSelectItemAt index: Int)
    
}


class TrainerCalendarTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    // MARK: outlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: lets
    
    let CELL_HEIGHT = 50
    let CELL_WIDTH = 50
    
    
    // MARK: vars
    
    var dates: [UIBookingScheduleDateModel] = []
    weak var delegate: TrainerCalendarTableViewCellDelegate?
    
    
    // MARK: overriden methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // load dates
        loadDates()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    // MARK: delegate methods
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrainerCalendarCollectionViewCell.CELL_ID, for: indexPath) as! TrainerCalendarCollectionViewCell
        
        let model = dates[indexPath.row]
        
        cell.weekDayLabel.text = model.weekDay
        cell.monthDayLabel.text = model.monthDay
        cell.monthDayLabel.textColor = (model.isHighlighted) ? hexStringToUIColor(hex: greenColor) : UIColor.black
        cell.weekDayLabel.textColor = (model.isHighlighted) ? hexStringToUIColor(hex: greenColor) : UIColor.black
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dates.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: CELL_WIDTH, height: CELL_HEIGHT)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.trainerCalendar(self, didSelectItemAt: indexPath.row)
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
        
        let numberOfDays = 30
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
