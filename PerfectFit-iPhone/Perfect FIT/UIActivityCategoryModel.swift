

import Foundation

class UIActivityCategoryModel {
    
    var title: String
    var activities: [UIActivityModel]
    
    init(title: String, activities: [UIActivityModel]) {
        self.title = title
        self.activities = activities
    }
    
}
