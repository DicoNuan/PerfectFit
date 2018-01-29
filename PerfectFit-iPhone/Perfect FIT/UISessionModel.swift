
import Foundation

class UISessionModel {
    
    var trainer: UITrainerModel
    var review: UIRatingModel?
    var day: String
    var hours: [String]
    var length: String
    var payment: UIPaymentModel
    
    init(trainer: UITrainerModel, review: UIRatingModel?, day: String, hours: [String], length: String, payment: UIPaymentModel) {
        self.trainer = trainer
        self.review = review
        self.day = day
        self.hours = hours
        self.length = length
        self.payment = payment
    }
    
    
}
