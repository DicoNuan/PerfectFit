
import UIKit


class BecomeATrainerViewController: UIViewController {

  
    
    @IBOutlet weak var becomeTrainerTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        // load text from back-end
        let msg = "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda."
        becomeTrainerTextView.text! = msg
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    @IBAction func becomeATrainerButtonPressed(_ sender: UIButton) {
        
    }
}
