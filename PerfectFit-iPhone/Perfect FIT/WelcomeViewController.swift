

import UIKit

class WelcomeViewController: UIViewController, BottomSheetViewControllerDelegate {
    
    // MARK: lets
    
    let SIGN_UP_PHONE_SEGUE = "SignUpPhoneSegue"
    let SIGN_UP_EMAIL_SEGUE = "SignUpEmailSegue"
    
    
    // MARK: vars
    
    var closeTapGesture: UITapGestureRecognizer?
    var bottomSheetVC: BottomSheetViewController?
    
    
    // MARK: Overriden methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar(navigationController?.navigationBar)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Actions
    
    @IBAction func onSignUpButtonPressed() {
        addBottomSheetView()
    }
    
    func onCloseViewTapped() {
        if let bottomSheetVC = bottomSheetVC {
            bottomSheetVC.close()
            
            if let recognizer = closeTapGesture {
                view.removeGestureRecognizer(recognizer)
            }
            
            closeTapGesture = nil
            self.bottomSheetVC = nil
        }
    }
    
    
    // MARK: delegate methods
    
    func bottomSheetPhoneTapped(_ bottomSheet: BottomSheetViewController) {
        performSegue(withIdentifier: SIGN_UP_PHONE_SEGUE, sender: nil)
    }
    
    func bottomSheetFacebookTapped(_ bottomSheet: BottomSheetViewController) {
        print("facebook tapped")
    }
    
    func bottomSheetEmailTapped(_ bottomSheet: BottomSheetViewController) {
        performSegue(withIdentifier: SIGN_UP_EMAIL_SEGUE, sender: nil)
    }
    
    
    // MARK: private methods
    
    private func addBottomSheetView() {
        // 1- Init bottomSheetVC
        bottomSheetVC = BottomSheetViewController()
        
        guard let bottomSheetVC = bottomSheetVC else {
            return
        }
        
        bottomSheetVC.delegate = self
        
        // 2- Add bottomSheetVC as a child view
        self.addChildViewController(bottomSheetVC)
        self.view.addSubview(bottomSheetVC.view)
        bottomSheetVC.didMove(toParentViewController: self)
        
        // 3- Adjust bottomSheet frame and initial position.
        let height = view.frame.height
        let width  = view.frame.width
        bottomSheetVC.view.frame = CGRect(x: 0, y: self.view.frame.maxY, width: width, height: height)
        
        // 4- add tap gesture for listening removement
        closeTapGesture = UITapGestureRecognizer(target: self, action: #selector(onCloseViewTapped))
        guard let closeTapGesture = closeTapGesture else {
            return
        }
        view.addGestureRecognizer(closeTapGesture)
    }
}

