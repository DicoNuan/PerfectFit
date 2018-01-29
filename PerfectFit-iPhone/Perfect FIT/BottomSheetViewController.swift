

import UIKit

protocol BottomSheetViewControllerDelegate: class {
    
    func bottomSheetPhoneTapped(_ bottomSheet: BottomSheetViewController)
    
    func bottomSheetFacebookTapped(_ bottomSheet: BottomSheetViewController)
    
    func bottomSheetEmailTapped(_ bottomSheet: BottomSheetViewController)
    
}

class BottomSheetViewController: UIViewController {

    // MARK: outlets
    
    @IBOutlet weak var phoneCellView: UIView!
    @IBOutlet weak var facebookCellView: UIView!
    @IBOutlet weak var emailCellView: UIView!
    
    
    // MARK: vars
    
    weak var delegate: BottomSheetViewControllerDelegate?
    

    var phoneTapGesture: UITapGestureRecognizer?
    var facebookTapGesture: UITapGestureRecognizer?
    var emailTapGesture: UITapGestureRecognizer?
    
    // MARK: overriden methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        phoneTapGesture = UITapGestureRecognizer.init(target: self, action: #selector(BottomSheetViewController.onPhoneItemPressed(recognizer:)))
        facebookTapGesture = UITapGestureRecognizer.init(target: self, action: #selector(BottomSheetViewController.onFacebookItemPressed(recognizer:)))
        emailTapGesture = UITapGestureRecognizer.init(target: self, action: #selector(BottomSheetViewController.onEmailItemPressed(recognizer:)))
        

        phoneCellView.addGestureRecognizer(phoneTapGesture!)
        facebookCellView.addGestureRecognizer(facebookTapGesture!)
        emailCellView.addGestureRecognizer(emailTapGesture!)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if let recognizer = phoneTapGesture {
            phoneCellView.removeGestureRecognizer(recognizer)
        }
        
        if let recognizer = facebookTapGesture {
            facebookCellView.removeGestureRecognizer(recognizer)
        }
        
        if let recognizer = emailTapGesture {
            emailCellView.removeGestureRecognizer(recognizer)
        }
        

        phoneTapGesture = nil
        facebookTapGesture = nil
        emailTapGesture = nil
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

        phoneTapGesture = nil
        facebookTapGesture = nil
        emailTapGesture = nil
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.3) { [weak self] in
            let frame = self?.view.frame
            let yComponent = UIScreen.main.bounds.height - 180
            self?.view.frame = CGRect(x: CGFloat(integerLiteral: 0), y: yComponent, width: frame!.width, height: frame!.height)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }

    
    // MARK: delegate methods
    
    
    func onPhoneItemPressed(recognizer: UITapGestureRecognizer) {
        delegate?.bottomSheetPhoneTapped(self)
    }
    
    func onFacebookItemPressed(recognizer: UITapGestureRecognizer) {
        delegate?.bottomSheetFacebookTapped(self)
    }
    
    func onEmailItemPressed(recognizer: UITapGestureRecognizer) {
        delegate?.bottomSheetEmailTapped(self)
    }
    
    // MARK: public methods
    
    func close() {
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            let frame = self?.view.frame
            let yComponent = UIScreen.main.bounds.height
            self?.view.frame = CGRect(x: CGFloat(integerLiteral: 0), y: yComponent, width: frame!.width, height: frame!.height)
            }, completion: { (finished: Bool) in
                self.view.removeFromSuperview()
                self.dismiss(animated: true, completion: nil)
        })
    }

    
}
