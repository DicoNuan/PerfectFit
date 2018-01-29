

import UIKit

class HistoryInfoTableViewController: UITableViewController {

    
    @IBOutlet weak var whomPayedLabel: UILabel!
    @IBOutlet weak var paymentMethodLabel: UILabel!
    @IBOutlet weak var sumPayedLabel: UILabel!
    @IBOutlet weak var dayPayedLabel: UILabel!
    @IBOutlet weak var hoursPayedLabel: UILabel!
    
    
    var payment: UIPaymentModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = hexStringToUIColor(hex: "FFFFFF")
        
        setupContent()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }


    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0 && indexPath.row == 0 {
            // navigate to user
            
            performSegue(withIdentifier: "TrainerSegue", sender: nil)
        }
    }

    
    private func setupContent() {
        if let payment = payment {
            whomPayedLabel.text = payment.whomPayed.fullName
            paymentMethodLabel.text! = payment.paymentMethod
            sumPayedLabel.text! = "\(payment.sumPayed)" + payment.currencyPayed
            dayPayedLabel.text! = payment.dayPayed
            hoursPayedLabel.text! = payment.hoursPayed[0] + " - " + payment.hoursPayed[1]
        }
    }
}
