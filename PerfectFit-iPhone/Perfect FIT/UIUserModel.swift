

import Foundation

class UIUserModel {
    
    var fullName: String
    
    var imgUrl: String
    
    var gender: String
    
    var age: Int
    
    var city: String
    
    var weight: Float
    
    var height: Float
    
    var email: String
    
    var phoneNumber: String
 
    var isOnline: Bool = true
    
    init(fullName: String, imgUrl: String, gender: String, age: Int, city: String, weight: Float, height: Float, email: String, phoneNumber: String) {
        self.fullName = fullName
        self.imgUrl = imgUrl
        self.gender = gender
        self.age = age
        self.city = city
        self.weight = weight
        self.height = height
        self.email = email
        self.phoneNumber = phoneNumber
    }
    
}
