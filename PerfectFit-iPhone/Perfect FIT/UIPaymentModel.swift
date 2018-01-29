

import Foundation

class UIPaymentModel {
    
    var whomPayed: UITrainerModel
    var paymentMethod: String
    var sumPayed: Int
    var currencyPayed: String
    var dayPayed: String
    var hoursPayed: [String]
    
    
    init(whomPayed: UITrainerModel, paymentMethod: String, sumPayed: Int, currencyPayed: String, dayPayed: String, hoursPayed: [String]) {
        self.whomPayed = whomPayed
        self.paymentMethod = paymentMethod
        self.sumPayed = sumPayed
        self.currencyPayed = currencyPayed
        self.dayPayed = dayPayed
        self.hoursPayed = hoursPayed
    }
    
}
