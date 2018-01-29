
import UIKit

class PaymentHistoryTableViewController: UITableViewController {

    var payments: [UIPaymentModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = hexStringToUIColor(hex: "FFFFFF")
        tableView.separatorColor = UIColor.clear
        
        // load all payments from back-end
        loadPayments()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return payments.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "HistoryInfoSegue", sender: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "TRANSACTIONS"
        } else {
            return nil
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PaymentHistoryCell", for: indexPath) as! PaymentTableViewCell
        
        cell.whomPayed.text! = payments[indexPath.row].whomPayed.fullName
        cell.datePayed.text! = payments[indexPath.row].dayPayed
        cell.whatPayed.text! = "\(payments[indexPath.row].sumPayed)" + payments[indexPath.row].currencyPayed
        
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let id = segue.identifier {
            if id == "HistoryInfoSegue" {
                if let indexPath = sender as? IndexPath {
                    let payment = payments[indexPath.row]
                    let controller = segue.destination as! HistoryInfoTableViewController
                    controller.payment = payment
                }
            }
        }
    }
    
    
    private func loadPayments() {
        payments.append(UIPaymentModel(whomPayed: UITrainerModel(fullName: "Amanda Fisher", imgUrl: "", gender: "male", age: 15, city: "China", weight: 124, height: 142, email: "ss@gmail.com", phoneNumber: "+34091841029", activity: "Trainer"), paymentMethod: "MasterCard", sumPayed: 100, currencyPayed: "KD", dayPayed: "10 Oct", hoursPayed: ["10:00", "11:00"]))
        payments.append(UIPaymentModel(whomPayed: UITrainerModel(fullName: "George Washington", imgUrl: "", gender: "male", age: 142, city: "Somwhere", weight: 1234, height: 123, email: "mail@mgila.com", phoneNumber: "1239812039812", activity: "MMA"), paymentMethod: "Visa", sumPayed: 500, currencyPayed: "KD", dayPayed: "15 Nov", hoursPayed: ["15:00", "16:00"]))
        payments.append(UIPaymentModel(whomPayed: UITrainerModel(fullName: "Harry Potter", imgUrl: "", gender: "female", age: 124, city: "Aszkaban", weight: 123, height: 123, email: "hh@gmail.com", phoneNumber: "1312938102", activity: "Killer"), paymentMethod: "Paypal", sumPayed: 10220, currencyPayed: "USD", dayPayed: "22 Jun", hoursPayed: ["09:00", "11:00"]))
    }
}
