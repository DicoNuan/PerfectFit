
import Foundation

class UITrainerModel: UIUserModel {
    
    var activity: String
    
    init(fullName: String, imgUrl: String, gender: String, age: Int, city: String, weight: Float, height: Float, email: String, phoneNumber: String, activity: String) {
        self.activity = activity
        super.init(fullName: fullName, imgUrl: imgUrl, gender: gender, age: age, city: city, weight: weight, height: height, email: email, phoneNumber: phoneNumber)
    }
    
}
