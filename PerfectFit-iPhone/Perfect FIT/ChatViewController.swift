

import UIKit

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextViewDelegate {

    
    // MARK: outlets
    
    
    @IBOutlet weak var sendButton: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var enterMessageTextView: UITextView!
    
    
    // MARK: lets
    let TEST_AVATAR_IMAGE = "test_ava"
    let MIN_NUMBER_OF_ROWS = 1
    let DUMMY_TABLE_VIEW_CELL_ID = "DummyCell"
    let ESTIMATED_ROW_HEIGHT: CGFloat = 140
    let TRAINER_SEGUE = "TrainerSegue"
    let ENTER_MESSAGE_TEXT_FIELD_BORDER_COLOR = "#c7c7cc"
    let ENTER_MESSAGE_TEXT_FIELD_CORNER_RADIUS: CGFloat = 18
    let ENTER_MESSAGE_TEXT_FIELD_BORDER_WIDTH: CGFloat = 2
    let AVATAR_CORNER_RADIUS: CGFloat = 21
    let AVATAR_TITLE_VIEW_WIDTH: CGFloat = 45
    let AVATAR_TITLE_VIEW_HEIGHT: CGFloat = 45
    let NAVIGATION_BAR_DIVIDER_HEIGHT: CGFloat = 1
    let ENTER_MESSAGE_TEXT_FIELD_LEFT_INSET: CGFloat = 8
    let ENTER_MESSAGE_TEXT_FIELD_RIGHT_INSET: CGFloat = 8
    let ENTER_MESSAGE_TEXT_FIELD_HINT_TEXT = "Enter message"
    static let DEFAULT_FOOTER_HEIGHT: CGFloat = 44
    let NUMBER_OF_SECTIONS_FOR_CHAT = 2
    
    // MARK: vars
    
    var tapGestureRecognizer: UITapGestureRecognizer?
    var sendButtonClickRecognizer: UITapGestureRecognizer?
    var enterMessageTextViewY: CGFloat?
    var footerHeight = ChatViewController.DEFAULT_FOOTER_HEIGHT
    
    
    var messages: [UIMessageModel] = []
    
    
    // MARK: overriden methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // load messages
        loadMessages()
        self.setupBar()
        self.setupEnterMessageTextField()
       
        tableView.separatorColor = UIColor.clear
    
        
        tableView.dataSource = self
        tableView.delegate = self
        enterMessageTextView.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        tapGestureRecognizer = nil
        sendButtonClickRecognizer = nil
        enterMessageTextView = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        sendButtonClickRecognizer = UITapGestureRecognizer(target: self, action: #selector(sendMessageButtonPressed))
        sendButton.addGestureRecognizer(sendButtonClickRecognizer!)
        
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGestureRecognizer!)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: Notification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: Notification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.endEditing(true)
        
        if tapGestureRecognizer != nil {
            view.removeGestureRecognizer(tapGestureRecognizer!)
        }
        tapGestureRecognizer = nil
        
        if sendButtonClickRecognizer != nil {
            sendButton.removeGestureRecognizer(sendButtonClickRecognizer!)
        }
        sendButtonClickRecognizer = nil
        
        NotificationCenter.default.removeObserver(self, name: Notification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: Notification.Name.UIKeyboardWillHide, object: nil)
    }
    
    
    // MARK: actions
    
    func keyboardWillShow(notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let oldTextFieldFrame = enterMessageTextView.frame
            enterMessageTextView.frame = CGRect(x: oldTextFieldFrame.origin.x, y: (oldTextFieldFrame.origin.y - keyboardRectangle.height) , width: oldTextFieldFrame.width, height: oldTextFieldFrame.height)
            
            footerHeight += keyboardRectangle.height
            
            let oldButtonFrame = sendButton.frame
            let newButtonFrame = CGRect(x: oldButtonFrame.origin.x, y: oldButtonFrame.origin.y - keyboardRectangle.height, width: oldButtonFrame.width, height: oldButtonFrame.height)
            sendButton.frame = newButtonFrame
            
            tableView.reloadSections([1], with: .none)
        }
    }
    
    func keyboardWillHide(notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let oldTextFieldFrame = enterMessageTextView.frame
            enterMessageTextView.frame = CGRect(x: oldTextFieldFrame.origin.x, y: oldTextFieldFrame.origin.y + keyboardRectangle.height, width: oldTextFieldFrame.width, height: oldTextFieldFrame.height)
            
            footerHeight -= keyboardRectangle.height
            
            let oldButtonFrame = sendButton.frame
            let newButtonFrame = CGRect(x: oldButtonFrame.origin.x, y: oldButtonFrame.origin.y + keyboardRectangle.height, width: oldButtonFrame.width, height: oldButtonFrame.height)
            sendButton.frame = newButtonFrame
         
            tableView.reloadSections([1], with: .none)
        }
    }
    
    func dismissKeyboard(recognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    func sendMessageButtonPressed(recognizer: UITapGestureRecognizer) {
        if validateIsEmpty(enterMessageTextView.text) != nil {
            return
        }
        
        
        sendMessage()
    }
    
    
    @IBAction func infoButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: TRAINER_SEGUE, sender: nil)
    }
    
    
    // MARK: delegate methods
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return NUMBER_OF_SECTIONS_FOR_CHAT
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? messages.count + MIN_NUMBER_OF_ROWS : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ChatDateTitleTableViewCell.CELL_ID, for: indexPath) as! ChatDateTitleTableViewCell
            return cell
        } else {
            let index = (indexPath.row - 1)
            let model = messages[index]
            
            if model.wasSentByMe {
                let cell = tableView.dequeueReusableCell(withIdentifier: SentFromMeTableViewCell.CELL_ID, for: indexPath) as! SentFromMeTableViewCell
                cell.messageTextView.text = model.content
                cell.messageTextView.layer.cornerRadius = cell.messageTextView.frame.height / 20.0
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: SentToMeTableViewCell.CELL_ID, for: indexPath) as! SentToMeTableViewCell
                cell.messageTextView.text = model.content
                cell.messageTextView.layer.cornerRadius = cell.messageTextView.frame.height / 20.0
                return cell
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return ESTIMATED_ROW_HEIGHT
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : footerHeight
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == hexStringToUIColor(hex: hintColor) {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = ENTER_MESSAGE_TEXT_FIELD_HINT_TEXT
            textView.textColor = hexStringToUIColor(hex: hintColor)
        }
    }


    
    // MARK: private methods
    
    private func sendMessage() {
        if let message = enterMessageTextView.text {
            let index = messages.count + 1
            
            messages.append(UIMessageModel(senderName: "Amanda Fisher", content: message, wasSentByMe: true))
            let indexPath = IndexPath(row: index, section: 0)
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
    
    
    private func setupBar() {
        setupNavBar(navigationController?.navigationBar)
        
        let imageView = UIImageView(image: UIImage(named: TEST_AVATAR_IMAGE))
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = AVATAR_CORNER_RADIUS
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: AVATAR_TITLE_VIEW_WIDTH, height: AVATAR_TITLE_VIEW_HEIGHT))
        imageView.frame = titleView.bounds
        titleView.addSubview(imageView)
        
        if let navigationController = self.navigationController {
            
            let navigationBar = navigationController.navigationBar
            let navBorder: UIView = UIView(frame: CGRect(x: 0, y: navigationBar.frame.size.height, width: navigationBar.frame.size.width, height: NAVIGATION_BAR_DIVIDER_HEIGHT))
            // Set the color you want here
            navBorder.backgroundColor = hexStringToUIColor(hex: navigationBarBlack)
            navBorder.isOpaque = true
            self.navigationController?.navigationBar.addSubview(navBorder)
        }
        
        self.navigationItem.titleView = titleView
    }
    
    private func setupEnterMessageTextField() {
        
        enterMessageTextView.layer.borderWidth = ENTER_MESSAGE_TEXT_FIELD_BORDER_WIDTH
        enterMessageTextView.layer.borderColor = hexStringToUIColor(hex: ENTER_MESSAGE_TEXT_FIELD_BORDER_COLOR).cgColor
        enterMessageTextView.layer.masksToBounds = true
        enterMessageTextView.layer.cornerRadius = ENTER_MESSAGE_TEXT_FIELD_CORNER_RADIUS
        enterMessageTextView.textColor = hexStringToUIColor(hex: hintColor)
        enterMessageTextView.text = ENTER_MESSAGE_TEXT_FIELD_HINT_TEXT
        enterMessageTextViewY = enterMessageTextView.frame.origin.y
        
        let oldTextInsets = enterMessageTextView.textContainerInset
        enterMessageTextView.textContainerInset = UIEdgeInsets(top: oldTextInsets.top, left: ENTER_MESSAGE_TEXT_FIELD_LEFT_INSET, bottom: oldTextInsets.bottom, right: ENTER_MESSAGE_TEXT_FIELD_RIGHT_INSET)
    }
    
    
    private func loadMessages() {
        messages.append(UIMessageModel(senderName: "Amanda Fisher", content: "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.", wasSentByMe: true))
        messages.append(UIMessageModel(senderName: "Amanda Fisher", content: "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.", wasSentByMe: false))
        messages.append(UIMessageModel(senderName: "Amanda Fisher", content: "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.", wasSentByMe: true))
        messages.append(UIMessageModel(senderName: "Amanda Fisher", content: "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.", wasSentByMe: false))
        messages.append(UIMessageModel(senderName: "Amanda Fisher", content: "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.", wasSentByMe: true))
        messages.append(UIMessageModel(senderName: "Amanda Fisher", content: "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.", wasSentByMe: false))
        
    }
}


