
import Foundation
import UIKit

let blackColor = "#0d0d0d"
let greenColor = "#1ae68b"

func hexStringToUIColor (hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }
    
    if ((cString.characters.count) != 6) {
        return UIColor.gray
    }
    
    var rgbValue:UInt32 = 0
    Scanner(string: cString).scanHexInt32(&rgbValue)
    
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}


func setupNavBar(_ navigationBar: UINavigationBar?) {
    navigationBar?.barTintColor = hexStringToUIColor(hex: blackColor)
    navigationBar?.tintColor = hexStringToUIColor(hex: greenColor)
    navigationBar?.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
    navigationBar?.barStyle = UIBarStyle.black
}
