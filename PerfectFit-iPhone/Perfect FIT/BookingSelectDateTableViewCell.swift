

import UIKit

class BookingSelectDateTableViewCell: UITableViewCell, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // MARK: outlets

    @IBOutlet weak var selectDate: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var chevron: UIImageView!
    @IBOutlet weak var datePicker: UIPickerView!
    
    
    // MARK: vars
    
    var daysOfYear: [String] = []
    
    
    // MARK: overriden methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initDaysOfYear()
        
        datePicker.delegate = self
        datePicker.dataSource = self
        
        
        
        initContent()
    }


    
    // MARK: delegate methods
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return daysOfYear.count
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return daysOfYear[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        initContent()
    }
    
    
    // MARK: private methods
    
    private func initDaysOfYear() {
        let currentDate = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: currentDate)
        
        var components = DateComponents()
        components.year = year
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE dd MMM"
        
        let numberOfDaysInYear = getNumberOfDaysInYear(year)
        
        for i in 1 ... numberOfDaysInYear {
            components.day = i
            let incrementerDate = calendar.date(from: components)
            let currentDateString: String = dateFormatter.string(from: incrementerDate!)
            daysOfYear.append(currentDateString)
        }
    }
    
    private func getNumberOfDaysInYear(_ year: Int) -> Int {
        if #available(iOS 10.0, *) {
            var components = DateComponents()
            components.year = year
            let date = Calendar.current.date(from: components)!
            let interval = Calendar.current.dateInterval(of: .year, for: date)!
            let days = Calendar.current.dateComponents([.day], from: interval.start, to: interval.end).day!
            return days
        } else {
            // Fallback on earlier versions
            let date = NSDate()
            let cal = NSCalendar(calendarIdentifier:NSCalendar.Identifier.gregorian)!
            let days = cal.range(of: .day, in: .month, for: date as Date)
            return days.length
        }
    }
    
    
    private func initContent() {
        let dateIndex = datePicker.selectedRow(inComponent: 0)
        let dateValue = daysOfYear[dateIndex]
        let index = dateValue.index(dateValue.endIndex, offsetBy: -6)
        date.text = dateValue.substring(from: index)
    }
}
