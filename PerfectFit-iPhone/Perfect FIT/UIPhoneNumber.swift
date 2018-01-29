
import Foundation

struct UIPhoneNumber {
    
    let country: UICountryModel
    
    let numberString: String
    
    func getFullNumber() -> String {
        return country.phoneCode + " " + numberString
    }
    
}
