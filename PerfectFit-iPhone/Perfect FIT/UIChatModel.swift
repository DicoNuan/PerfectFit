

import Foundation

class UIChatModel {
    
    var person: UIUserModel
    var timeLastMessageSent: String
    var contentOfLastMessage: String
    
    init(person: UIUserModel, timeLastMessageSent: String, contentOfLastMessage: String) {
        self.person = person
        self.timeLastMessageSent = timeLastMessageSent
        self.contentOfLastMessage = contentOfLastMessage
    }
    
    
    
}
