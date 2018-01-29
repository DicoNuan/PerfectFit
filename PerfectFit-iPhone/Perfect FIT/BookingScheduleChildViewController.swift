

import UIKit
import XLPagerTabStrip
import SwiftEventBus

class BookingScheduleChildViewController: UIViewController, IndicatorInfoProvider, UITableViewDelegate, UITableViewDataSource {

    // MARK: outlets
    
    @IBOutlet weak var tableView: UITableView!

    // MARK: lets
    
    static let UPDATE_SCHEDULE_EVENT = "UpdateScheduleEvent"
    let NUMBER_OF_WORK_HOURS_A_DAY = 20
    let WORK_DAY_START_HOUR = 5
    let MIN_DAYS_TO_DISPLAY_AT_ONCE = 7

    
    // MARK: vars
    
    var tabTitle: String?
    var numberOfDaysInMonth: Int?
    var hours: [UIHourScheduleModel] = []
    
    
    // MARK: overriden methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        initHours()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        tabTitle = nil
        numberOfDaysInMonth = nil
    }

    
    // MARK: delegate methods

    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        let indicatorInfo: IndicatorInfo
        if let title = tabTitle {
            indicatorInfo = IndicatorInfo(title: title)
        } else {
            indicatorInfo = IndicatorInfo(title: "")
        }
        
        return indicatorInfo
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hours.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BookingCalendarTableViewCell.CELL_ID, for: indexPath) as! BookingCalendarTableViewCell
        
        cell.setupIndicators()
        
        let model = hours[indexPath.row]
        cell.timeLabel.text = "\(model.hour):00"
        
        for i in 0 ..< MIN_DAYS_TO_DISPLAY_AT_ONCE {
            let day = model.days[i]
            cell.indicators[i].isHidden = !day.isBooked
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let bookingController = storyboard?.instantiateViewController(withIdentifier: BookingTableViewController.STORYBOARD_ID) {
            navigationController?.pushViewController(bookingController, animated: true)
        }
    }
    
    
    // MARK: private methods
    
    
    
    private func initHours() {

        let startHour = WORK_DAY_START_HOUR
        for i in 0 ..< NUMBER_OF_WORK_HOURS_A_DAY {
            let hour = startHour + i

            var daysArrayForModel: [UIDayScheduleModel] = []
          
            if i == 0 {
                daysArrayForModel.append(UIDayScheduleModel(isBooked: false, isMine: false))
                daysArrayForModel.append(UIDayScheduleModel(isBooked: true, isMine: false))
                daysArrayForModel.append(UIDayScheduleModel(isBooked: false, isMine: false))
                daysArrayForModel.append(UIDayScheduleModel(isBooked: true, isMine: false))
                daysArrayForModel.append(UIDayScheduleModel(isBooked: false, isMine: false))
                daysArrayForModel.append(UIDayScheduleModel(isBooked: false, isMine: false))
                daysArrayForModel.append(UIDayScheduleModel(isBooked: false, isMine: false))
            }
            
            if i == 1 {
                daysArrayForModel.append(UIDayScheduleModel(isBooked: false, isMine: false))
                daysArrayForModel.append(UIDayScheduleModel(isBooked: true, isMine: false))
                daysArrayForModel.append(UIDayScheduleModel(isBooked: false, isMine: false))
                daysArrayForModel.append(UIDayScheduleModel(isBooked: true, isMine: false))
                daysArrayForModel.append(UIDayScheduleModel(isBooked: false, isMine: false))
                daysArrayForModel.append(UIDayScheduleModel(isBooked: false, isMine: false))
                daysArrayForModel.append(UIDayScheduleModel(isBooked: false, isMine: false))
                
            }
            
            if i == 2 {
                daysArrayForModel.append(UIDayScheduleModel(isBooked: true, isMine: false))
                daysArrayForModel.append(UIDayScheduleModel(isBooked: true, isMine: false))
                daysArrayForModel.append(UIDayScheduleModel(isBooked: false, isMine: false))
                daysArrayForModel.append(UIDayScheduleModel(isBooked: true, isMine: false))
                daysArrayForModel.append(UIDayScheduleModel(isBooked: false, isMine: false))
                daysArrayForModel.append(UIDayScheduleModel(isBooked: false, isMine: false))
                daysArrayForModel.append(UIDayScheduleModel(isBooked: true, isMine: false))
                
            }
            
            if i == 3 {
                daysArrayForModel.append(UIDayScheduleModel(isBooked: true, isMine: false))
                daysArrayForModel.append(UIDayScheduleModel(isBooked: false, isMine: false))
                daysArrayForModel.append(UIDayScheduleModel(isBooked: false, isMine: false))
                daysArrayForModel.append(UIDayScheduleModel(isBooked: true, isMine: false))
                daysArrayForModel.append(UIDayScheduleModel(isBooked: false, isMine: false))
                daysArrayForModel.append(UIDayScheduleModel(isBooked: false, isMine: false))
                daysArrayForModel.append(UIDayScheduleModel(isBooked: true, isMine: false))
                
            }
            
            if i == 4 {
                daysArrayForModel.append(UIDayScheduleModel(isBooked: true, isMine: false))
                daysArrayForModel.append(UIDayScheduleModel(isBooked: false, isMine: false))
                daysArrayForModel.append(UIDayScheduleModel(isBooked: false, isMine: false))
                daysArrayForModel.append(UIDayScheduleModel(isBooked: true, isMine: false))
                daysArrayForModel.append(UIDayScheduleModel(isBooked: false, isMine: false))
                daysArrayForModel.append(UIDayScheduleModel(isBooked: false, isMine: false))
                daysArrayForModel.append(UIDayScheduleModel(isBooked: true, isMine: false))
                
            }
            
            if i == 5 {
                daysArrayForModel.append(UIDayScheduleModel(isBooked: true, isMine: false))
                daysArrayForModel.append(UIDayScheduleModel(isBooked: false, isMine: false))
                daysArrayForModel.append(UIDayScheduleModel(isBooked: false, isMine: false))
                daysArrayForModel.append(UIDayScheduleModel(isBooked: true, isMine: false))
                daysArrayForModel.append(UIDayScheduleModel(isBooked: false, isMine: false))
                daysArrayForModel.append(UIDayScheduleModel(isBooked: false, isMine: false))
                daysArrayForModel.append(UIDayScheduleModel(isBooked: true, isMine: false))
                
            }
            
            if i == 6 {
                daysArrayForModel.append(UIDayScheduleModel(isBooked: true, isMine: false))
                daysArrayForModel.append(UIDayScheduleModel(isBooked: false, isMine: false))
                daysArrayForModel.append(UIDayScheduleModel(isBooked: false, isMine: false))
                daysArrayForModel.append(UIDayScheduleModel(isBooked: true, isMine: false))
                daysArrayForModel.append(UIDayScheduleModel(isBooked: false, isMine: false))
                daysArrayForModel.append(UIDayScheduleModel(isBooked: false, isMine: false))
                daysArrayForModel.append(UIDayScheduleModel(isBooked: true, isMine: false))
                
            }
            
            if i == 7 {
                daysArrayForModel.append(UIDayScheduleModel(isBooked: true, isMine: false))
                daysArrayForModel.append(UIDayScheduleModel(isBooked: false, isMine: false))
                daysArrayForModel.append(UIDayScheduleModel(isBooked: false, isMine: false))
                daysArrayForModel.append(UIDayScheduleModel(isBooked: true, isMine: false))
                daysArrayForModel.append(UIDayScheduleModel(isBooked: false, isMine: false))
                daysArrayForModel.append(UIDayScheduleModel(isBooked: false, isMine: false))
                daysArrayForModel.append(UIDayScheduleModel(isBooked: true, isMine: false))
                
            }
            
            if i == 8 {
                daysArrayForModel.append(UIDayScheduleModel(isBooked: true, isMine: false))
                daysArrayForModel.append(UIDayScheduleModel(isBooked: true, isMine: false))
                daysArrayForModel.append(UIDayScheduleModel(isBooked: false, isMine: false))
                daysArrayForModel.append(UIDayScheduleModel(isBooked: false, isMine: false))
                daysArrayForModel.append(UIDayScheduleModel(isBooked: false, isMine: false))
                daysArrayForModel.append(UIDayScheduleModel(isBooked: false, isMine: false))
                daysArrayForModel.append(UIDayScheduleModel(isBooked: true, isMine: false))
                
            }
            
            if i == 9 {
                daysArrayForModel.append(UIDayScheduleModel(isBooked: true, isMine: false))
                daysArrayForModel.append(UIDayScheduleModel(isBooked: true, isMine: false))
                daysArrayForModel.append(UIDayScheduleModel(isBooked: false, isMine: false))
                daysArrayForModel.append(UIDayScheduleModel(isBooked: false, isMine: false))
                daysArrayForModel.append(UIDayScheduleModel(isBooked: false, isMine: false))
                daysArrayForModel.append(UIDayScheduleModel(isBooked: false, isMine: false))
                daysArrayForModel.append(UIDayScheduleModel(isBooked: true, isMine: false))
                
            }
            
            if i == 10 {
                daysArrayForModel.append(UIDayScheduleModel(isBooked: false, isMine: false))
                daysArrayForModel.append(UIDayScheduleModel(isBooked: true, isMine: false))
                daysArrayForModel.append(UIDayScheduleModel(isBooked: false, isMine: false))
                daysArrayForModel.append(UIDayScheduleModel(isBooked: false, isMine: false))
                daysArrayForModel.append(UIDayScheduleModel(isBooked: false, isMine: false))
                daysArrayForModel.append(UIDayScheduleModel(isBooked: false, isMine: false))
                daysArrayForModel.append(UIDayScheduleModel(isBooked: true, isMine: false))
                
            }
            
            if i > 10 {
                daysArrayForModel.append(UIDayScheduleModel(isBooked: false, isMine: false))
                daysArrayForModel.append(UIDayScheduleModel(isBooked: false, isMine: false))
                daysArrayForModel.append(UIDayScheduleModel(isBooked: false, isMine: false))
                daysArrayForModel.append(UIDayScheduleModel(isBooked: false, isMine: false))
                daysArrayForModel.append(UIDayScheduleModel(isBooked: false, isMine: false))
                daysArrayForModel.append(UIDayScheduleModel(isBooked: false, isMine: false))
                daysArrayForModel.append(UIDayScheduleModel(isBooked: false, isMine: false))
                
            }
            
            hours.append(UIHourScheduleModel(hour: hour, days: daysArrayForModel))
        }
        
    }
}

class UIDayScheduleModel {
    
    var isBooked: Bool
    var isMine: Bool
    
    init(isBooked: Bool, isMine: Bool) {
        self.isBooked = isBooked
        self.isMine = isMine
    }
    
}

class UIHourScheduleModel {
    
    var hour: Int
    var days: [UIDayScheduleModel]
    
    init(hour: Int, days: [UIDayScheduleModel]) {
        self.hour = hour
        self.days = days
    }
}


