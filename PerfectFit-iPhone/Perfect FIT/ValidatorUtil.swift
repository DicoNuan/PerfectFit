

import Foundation


func validateEmail(_ email: String?) -> String? {
    if let emptyEmailError = validateIsEmpty(email) {
        return "Email " + emptyEmailError
    }
    if let email = email {
        if !email.contains("@") {
            return "Invalid email"
        }
    }
    
    return nil
}


func validatePassword(_ pass: String?) -> String? {
    if let emptyPassError = validateIsEmpty(pass) {
        return "Password " + emptyPassError
    }
    
    return nil
}


func validatePhoneNumber(_ phone: String?) -> String? {
    if let emptyPhoneError = validateIsEmpty(phone) {
        return "Phone number " + emptyPhoneError;
    }
    
    if (phone! as NSString).length < 14 {
        return "Phone number is too short"
    }
    
    return nil
}

func validateIsEmpty(_ field: String?) -> String? {
    if field == nil {
        return "field is empty"
    } else if field!.isEmpty {
        return "field is empty"
    }
    
    return nil
}

