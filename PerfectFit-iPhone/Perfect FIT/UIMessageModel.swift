

import Foundation


class UIMessageModel {
    
    var senderName: String
    var content: String
    var wasSentByMe: Bool
    
    init(senderName: String, content: String, wasSentByMe: Bool) {
        self.senderName = senderName
        self.content = content
        self.wasSentByMe = wasSentByMe
    }
    
}
