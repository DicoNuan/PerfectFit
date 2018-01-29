

import UIKit

class PaymentTableViewController: UITableViewController, UITextFieldDelegate {
    
    // MARK: lets
    let PAYMENT_VISA_TABLE_VIEW_CELL_ID = "PaymentVisaTableViewCell"
    let PAYMENT_MASTERCARD_TABLE_VIEW_CELL_ID = "PaymentMasterCardTableViewCell"
    let PAYMENT_AMEX_TABLE_VIEW_CELL_ID = "PaymentAmexTableViewCell"
    let PAYMENT_PAYPAL_TABLE_VIEW_CELL_ID = "PaymentPaypalTableViewCell"
    let PAYMENT_KNET_TABLE_VIEW_CELL_ID = "PaymentKNETTableViewCell"
    let PAYMENT_CASH_TABLE_VIEW_CELL_ID = "PaymentCashTableViewCell"
    let PAYMENT_CARDHOLDER_TABLE_VIEW_CELL_ID = "PaymentCardholderTableViewCell"
    let PAYMENT_NUMBER_TABLE_VIEW_CELL_ID = "PaymentNumberTableViewCell"
    let PAYMENT_CARD_EXPIRE_TABLE_VIEW_CELL_ID = "PaymentCardExpireTableViewCell"
    let PAYMENT_PAYMENT_INFO_TABLE_VIEW_CELL_ID = "PaymentPaymentInfoTableViewCell"
    let PAYMENT_TRAINER_TABLE_VIEW_CELL_ID = "PaymentTrainerTableViewCell"
    let PAYMENT_PRICE_TABLE_VIEW_CELL_ID = "PaymentPriceTableViewCell"
    let PAYMENT_DAY_TABLE_VIEW_CELL_ID = "PaymentDayTableViewCell"
    let PAYMENT_HOURS_TABLE_VIEW_CELL_ID = "PaymentHoursTableViewCell"
    let PAYMENT_ADD_TO_CALENDAR_TABLE_VIEW_CELL_ID = "PaymentAddToCalendarTableViewCell"
    let PAYMENT_EMAIL_TABLE_VIEW_CELL_ID = "PaymentEmailTableViewCell"
    let PAYMENT_PASSWORD_TABLE_VIEW_CELL_ID = "PaymentPasswordTableViewCell"
    let PAYMENT_SELECT_YOUR_BANK_TABLE_VIEW_CELL_ID = "PaymentSelectYourBankTableViewCell"
    let PAYMENT_PREFIX_TABLE_VIEW_CELL_ID = "PaymentPrefixTableViewCell"
    let PAYMENT_EXPIRE_TABLE_VIEW_CELL_ID = "PaymentExpireTableViewCell"
    let PAYMENT_PIN_TABLE_VIEW_CELL_ID = "PaymentPINTableViewCell"
    let PAYMENT_SAVE_PAYMENT_METHODS_TABLE_VIEW_CELL_ID = "PaymentSavePaymentMethodTableViewCell"
    let PAYMENT_PAY_TABLE_VIEW_CELL_ID = "PaymentPayTableViewCell"
    
    let SECTION_PAYMENT_TYPE_TITLE = "Payment type"
    
    let PAY_TABLE_VIEW_CELL_HEIGHT: CGFloat = 82
    
    let CARD_HOLDER_CELL_TAG = 10000
    let CARD_NUMBER_CELL_TAG = 10001
    let CARD_EXPIRE_CELL_TAG = 10002
    let EMAIL_CELL_TAG = 10003
    let PASSWORD_CELL_TAG = 10004
    let CONFIRM_PASSWORD_CELL_TAG = 10005
    let BANK_CELL_TAG = 10006
    let PREFIX_CELL_TAG = 10007
    let EXPIRE_CELL_TAG = 10008
    let PIN_CELL_TAG = 10009
    let PRICE_CELL_TAG = 10010
    
    
    let SECTION_ONE_NUMBER_OF_CELLS = 6
    let SECTION_THREE_NUMBER_OF_CELLS = 2
    let NUMBER_OF_SECTIONS = 3
    
    // MARK: vars
    
    var isVisaChecked = false
    var isMasterCardChecked = false
    var isAmexChecked = false
    var isPayPalChecked = false
    var isKnetChecked = false
    var isCashChecked = true
    
    let NUMBER_OF_CELLS_FOR_CARD = 3
    let NUMBER_OF_CELLS_FOR_PAY_SYSTEM = 2
    let NUMBER_OF_CELLS_FOR_BANK_ACCOUNT = 4
    let NUMBER_OF_CELLS_FOR_CASH = 0
    
    var alert: UIAlertController?
    
    weak var newPassTextField: UITextField?
    weak var confirmPassTextField: UITextField?
    
    
    // MARK: overriden methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        alert = nil
        newPassTextField = nil
        confirmPassTextField = nil
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        let row = indexPath.row
        
        if section == 0 {
            if row == 0 {
                // visa
                return makeVisaTableViewCell(indexPath)
            } else if row == 1 {
                // mastercard
                return makeMasterCardTableViewCell(indexPath)
            } else if row == 2 {
                // amex
                return makeAmexTableViewCell(indexPath)
            } else if row == 3 {
                // paypal
                return makePayPalTableViewCell(indexPath)
            } else if row == 4 {
                // knet
                return makeKnetTableViewCell(indexPath)
            } else {
                // cash
                return makeCashTableViewCell(indexPath)
            }
        } else if section == 1 {
            
            if isVisaChecked || isMasterCardChecked || isAmexChecked {
                if row == 0 {
                    // cardholder
                    return makeCardHolderTableViewCell(indexPath)
                } else if row == 1 {
                    // number
                    return makeCardNumberTableViewCell(indexPath)
                } else if row == 2 {
                    // expire
                    return makeCardExpireTableViewCell(indexPath)
                } else if row == 3 {
                    // payment info
                    return makePaymentInfoTableViewCell(indexPath)
                } else if row == 4 {
                    // trainer
                    return makeTrainerTableViewCell(indexPath)
                } else if row == 5 {
                    // price
                    return makePriceTableViewCell(indexPath)
                } else if row == 6 {
                    // day
                    return makeDayTableViewCell(indexPath)
                } else if row == 7 {
                    // hours
                    return makeHoursTableViewCell(indexPath)
                } else {
                    // add to calendar
                    return makeAddToCalendarTableViewCell(indexPath)
                }
            } else if isPayPalChecked {
                if row == 0 {
                    // email
                    return makeEmailTableViewCell(indexPath)
                } else if row == 1 {
                    // password
                    return makePasswordTableViewCell(indexPath)
                } else if row == 2 {
                    // payment info
                   return  makePaymentInfoTableViewCell(indexPath)
                } else if row == 3 {
                    // trainer
                    return makeTrainerTableViewCell(indexPath)
                } else if row == 4 {
                    // price
                    return makePriceTableViewCell(indexPath)
                } else if row == 5 {
                    // day
                    return makeDayTableViewCell(indexPath)
                } else if row == 6 {
                    // hours
                    return makeHoursTableViewCell(indexPath)
                } else {
                    // add to calendar
                    return makeAddToCalendarTableViewCell(indexPath)
                }
                
            } else if isKnetChecked {
                if row == 0 {
                    // select your bank
                    return makeSelectYourBankTableViewCell(indexPath)
                } else if row == 1 {
                    // prefix
                    return makePrefixTableViewCell(indexPath)
                } else if row == 2 {
                    // expire
                    return makeExpireTableViewCell(indexPath)
                } else if row == 3 {
                    // pin
                    return makePINTableViewCell(indexPath)
                } else if row == 4 {
                    // payment info
                    return  makePaymentInfoTableViewCell(indexPath)
                } else if row == 5 {
                    // trainer
                    return makeTrainerTableViewCell(indexPath)
                } else if row == 6 {
                    // price
                    return makePriceTableViewCell(indexPath)
                } else if row == 7 {
                    // day
                    return makeDayTableViewCell(indexPath)
                } else if row == 8 {
                    // hours
                    return makeHoursTableViewCell(indexPath)
                } else {
                    // add to calendar
                    return makeAddToCalendarTableViewCell(indexPath)
                }
            } else {
                // cash
                if row == 0 {
                    // payment info
                    return  makePaymentInfoTableViewCell(indexPath)
                } else if row == 1 {
                    // trainer
                    return makeTrainerTableViewCell(indexPath)
                } else if row == 2 {
                    // price
                    return makePriceTableViewCell(indexPath)
                } else if row == 3 {
                    // day
                    return makeDayTableViewCell(indexPath)
                } else if row == 4 {
                    // hours
                    return makeHoursTableViewCell(indexPath)
                } else {
                    // add to calendar
                    return makeAddToCalendarTableViewCell(indexPath)
                }
            }
        } else {
            if row == 0 {
                return makeSavePaymentMethodTableViewCell(indexPath)
            } else {
                return makePayTableViewCell(indexPath)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 2 && indexPath.row == 1 {
            return PAY_TABLE_VIEW_CELL_HEIGHT
        } else {
            return super.tableView(tableView, heightForRowAt: indexPath)
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return SECTION_PAYMENT_TYPE_TITLE
        } else {
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return SECTION_ONE_NUMBER_OF_CELLS
        } else if section == 1 {
            let minimumNumberOfCells = 6
            let additiveNumberOfCells: Int
            if isVisaChecked || isMasterCardChecked || isAmexChecked {
                additiveNumberOfCells = NUMBER_OF_CELLS_FOR_CARD
            } else if isPayPalChecked {
                additiveNumberOfCells = NUMBER_OF_CELLS_FOR_PAY_SYSTEM
            } else if isKnetChecked {
                additiveNumberOfCells = NUMBER_OF_CELLS_FOR_BANK_ACCOUNT
            } else {
                additiveNumberOfCells = NUMBER_OF_CELLS_FOR_CASH
            }
            
            let numberOfCells = minimumNumberOfCells + additiveNumberOfCells
            
            return numberOfCells
        } else {
            return SECTION_THREE_NUMBER_OF_CELLS
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return NUMBER_OF_SECTIONS
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let section = indexPath.section
        let row = indexPath.row
        if section == 0 {
            if row == 0 {
                // Visa
                checkVisaCell()
            }
            if row == 1 {
                // MasterCard
                checkMasterCardCell()
            }
            if row == 2 {
                // Amex
                checkAmexCell()
            }
            if row == 3 {
                // PayPal
                checkPayPalCell()
            }
            if row == 4 {
                // KNET
                checkKnetCell()
            }
            if row == 5 {
                // Cash
                checkCashCell()
            }
            tableView.reloadData()
        }
        
        if section == 1 {
            if isVisaChecked || isMasterCardChecked || isAmexChecked {
                if row == 0 {
                    // card holder
                    onCardHolderCellClicked()
                }
                if row == 1 {
                    // card number
                    onCardNumberCellClicked()
                }
                if row == 2 {
                    // expire
                    onCardExpireCellClicked()
                }
                if row == 4 {
                    // trainer
                    onTrainerCellClicked()
                }
                if row == 5 {
                    // price
                    onPriceCellClicked()
                }
                if row == 6 {
                    // day
                    onDayCellClicked()
                }
                if row == 7 {
                    // hours
                    onHoursCellClicked()
                }
            } else if isPayPalChecked {
                if row == 0 {
                    // email
                    onEmailCellClicked()
                }
                if row == 1 {
                    // password
                    onPasswordCellClicked()
                }
                if row == 3 {
                    // trainer
                    onTrainerCellClicked()
                }
                if row == 4 {
                    // price
                    onPriceCellClicked()
                }
                if row == 5 {
                    // day
                    onDayCellClicked()
                }
                if row == 6 {
                    // hours
                    onHoursCellClicked()
                }
            } else if isKnetChecked {
                if row == 0 {
                    // select bank name
                    onSelectBankCellClicked()
                }
                if row == 1 {
                    // prefix
                    onPrefixCellClicked()
                }
                if row == 2 {
                    // expire
                    onExpireCellClicked()
                }
                if row == 3 {
                    // PIN
                    onPinCellClicked()
                }
                if row == 5 {
                    // trainer
                    onTrainerCellClicked()
                }
                if row == 6 {
                    // price
                    onPriceCellClicked()
                }
                if row == 7 {
                    // day
                    onDayCellClicked()
                }
                if row == 8 {
                    // hours
                    onHoursCellClicked()
                }
            } else {
                // cash
                if row == 1 {
                    // trainer
                    onTrainerCellClicked()
                }
                if row == 2 {
                    // price
                    onPriceCellClicked()
                }
                if row == 3 {
                    // day
                    onDayCellClicked()
                }
                if row == 4 {
                    // hours
                    onHoursCellClicked()
                }
            }
        }
    }
    
    // MARK: actions
    
    @IBAction func payButtonPressed() {
        let alert = UIAlertController(title: "TRAINR", message: "You're all set for your session", preferredStyle: .alert)
        alert.view.tintColor = hexStringToUIColor(hex: greenColor)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    
    // MARK: delegate methods
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let alert = alert {
            switch textField.tag {
            case PASSWORD_CELL_TAG:
                let isTyping = !string.isEmpty
                
                let newPassText: String
                if !isTyping {
                    let copy = newPassTextField!.text!
                    let index = copy.index(before: copy.endIndex)
                    newPassText = copy.substring(to: index)
                } else {
                    newPassText = newPassTextField!.text! + string
                }
                
                let confirmPassText = confirmPassTextField!.text!
                
                let isEnabled = !(newPassText.isEmpty) && !(confirmPassText.isEmpty) && newPassText == confirmPassText
                
                alert.actions[0].isEnabled = isEnabled
            case CONFIRM_PASSWORD_CELL_TAG:
                let isTyping = !string.isEmpty
                
                let newPassText = newPassTextField!.text!
                let confirmPassText: String
                if !isTyping {
                    let copy = confirmPassTextField!.text!
                    let index = copy.index(before: copy.endIndex)
                    confirmPassText = copy.substring(to: index)
                } else {
                    confirmPassText = confirmPassTextField!.text! + string
                }
                
                let isEnabled = !(newPassText.isEmpty) && !(confirmPassText.isEmpty) && newPassText == confirmPassText
                
                alert.actions[0].isEnabled = isEnabled
            default:
                let isTyping = !string.isEmpty
                let fullText: String
                if !isTyping {
                    let copy = textField.text!
                    let index = copy.index(before: copy.endIndex)
                    fullText = copy.substring(to: index)
                } else {
                    fullText = textField.text! + string
                }
                alert.actions[0].isEnabled = !fullText.isEmpty
            }
        }
        return true
    }

    
    
    
    // MARK: private methods
    
    private func checkVisaCell() {
        isVisaChecked = true
        isMasterCardChecked = false
        isAmexChecked = false
        isPayPalChecked = false
        isKnetChecked = false
        isCashChecked = false
    }
    
    private func checkMasterCardCell() {
        isVisaChecked = false
        isMasterCardChecked = true
        isAmexChecked = false
        isPayPalChecked = false
        isKnetChecked = false
        isCashChecked = false
    }
    
    private func checkAmexCell() {
        isVisaChecked = false
        isMasterCardChecked = false
        isAmexChecked = true
        isPayPalChecked = false
        isKnetChecked = false
        isCashChecked = false
    }
    
    private func checkPayPalCell() {
        isVisaChecked = false
        isMasterCardChecked = false
        isAmexChecked = false
        isPayPalChecked = true
        isKnetChecked = false
        isCashChecked = false
    }
    
    private func checkKnetCell() {
        isVisaChecked = false
        isMasterCardChecked = false
        isAmexChecked = false
        isPayPalChecked = false
        isKnetChecked = true
        isCashChecked = false
    }
    
    private func checkCashCell() {
        isVisaChecked = false
        isMasterCardChecked = false
        isAmexChecked = false
        isPayPalChecked = false
        isKnetChecked = false
        isCashChecked = true
    }
    
    
    private func onCardHolderCellClicked() {
        alert = UIAlertController(title: "Enter card holder", message: nil, preferredStyle: .alert)
        alert!.addTextField(configurationHandler: {
            field in
            field.tag = self.CARD_HOLDER_CELL_TAG
            field.delegate = self
            field.keyboardAppearance = .default
            field.keyboardType = .default
            field.placeholder = "Type card holder here"
        })
        
        alert!.addAction(UIAlertAction(title: "Done", style: .default, handler: {
            action in
            
            // action here
            
        }))
        
        alert!.actions[0].isEnabled = false
        alert!.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        
        
        present(alert!, animated: true, completion: nil)
    }
    
    private func onCardNumberCellClicked() {
        alert = UIAlertController(title: "Enter card number", message: nil, preferredStyle: .alert)
        alert!.addTextField(configurationHandler: {
            field in
            field.tag = self.CARD_NUMBER_CELL_TAG
            field.delegate = self
            field.keyboardAppearance = .default
            field.keyboardType = .numberPad
            field.placeholder = "Type card number here"
        })
        
        alert!.addAction(UIAlertAction(title: "Done", style: .default, handler: {
            action in
            
            // action here
            
        }))
        
        alert!.actions[0].isEnabled = false
        alert!.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        
        
        present(alert!, animated: true, completion: nil)
    }
    
    private func onCardExpireCellClicked() {
        alert = UIAlertController(title: "Enter expire date", message: nil, preferredStyle: .alert)
        alert!.addTextField(configurationHandler: {
            field in
            field.tag = self.CARD_EXPIRE_CELL_TAG
            field.delegate = self
            field.keyboardAppearance = .default
            field.keyboardType = .default
            field.placeholder = "Type expire date here"
        })
        
        alert!.addAction(UIAlertAction(title: "Done", style: .default, handler: {
            action in
            
            // action here
            
        }))
        
        alert!.actions[0].isEnabled = false
        alert!.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        
        
        present(alert!, animated: true, completion: nil)
  
    }
    
    private func onEmailCellClicked() {
        alert = UIAlertController(title: "Enter email", message: nil, preferredStyle: .alert)
        alert!.addTextField(configurationHandler: {
            field in
            field.tag = self.EMAIL_CELL_TAG
            field.delegate = self
            field.keyboardAppearance = .default
            field.keyboardType = .emailAddress
            field.placeholder = "Type email here"
        })
        
        alert!.addAction(UIAlertAction(title: "Done", style: .default, handler: {
            action in
            
            // action here
            
        }))
        
        alert!.actions[0].isEnabled = false
        alert!.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        
        
        present(alert!, animated: true, completion: nil)
    }
    
    private func onPasswordCellClicked() {
        alert = UIAlertController(title: "Enter password", message: nil, preferredStyle: .alert)
        
        alert!.addTextField(configurationHandler: {
            field in
            field.tag = self.PASSWORD_CELL_TAG
            field.delegate = self
            field.keyboardAppearance = .default
            field.keyboardType = .default
            field.isSecureTextEntry = true
            field.placeholder = "Type password here"
            self.newPassTextField = field
        })
        
        alert!.addTextField(configurationHandler: {
            field in
            field.tag = self.CONFIRM_PASSWORD_CELL_TAG
            field.delegate = self
            field.keyboardAppearance = .default
            field.keyboardType = .default
            field.isSecureTextEntry = true
            field.placeholder = "Confirm password here"
            self.confirmPassTextField = field
        })
        
        
        
        alert!.addAction(UIAlertAction(title: "Save", style: .default, handler: {
            action in
            // save password to back-end
        }))
        
        alert!.actions[0].isEnabled = false
        
        
        alert!.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        
        present(alert!, animated: true, completion: nil)
    }
    
    private func onTrainerCellClicked() {
        alert = UIAlertController(title: "This is trainer option, it is still in development", message: nil, preferredStyle: .alert)
        
        alert!.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alert!, animated: true, completion: nil)
    }
    
    
    private func onPriceCellClicked() {
        alert = UIAlertController(title: "Enter price", message: nil, preferredStyle: .alert)
        alert!.addTextField(configurationHandler: {
            field in
            field.tag = self.PRICE_CELL_TAG
            field.delegate = self
            field.keyboardAppearance = .default
            field.keyboardType = .decimalPad
            field.placeholder = "Type price here"
        })
        
        alert!.addAction(UIAlertAction(title: "Done", style: .default, handler: {
            action in
            
            // action here
            
        }))
        
        alert!.actions[0].isEnabled = false
        alert!.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alert!, animated: true, completion: nil)
    }
    
    private func onDayCellClicked() {
        // to do: add picker here
        alert = UIAlertController(title: "This is day option, it is still in development", message: nil, preferredStyle: .alert)
        
        alert!.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alert!, animated: true, completion: nil)
    }
    
    private func onHoursCellClicked() {
        // to do: add picker here
        alert = UIAlertController(title: "This is hours option, it is still in development", message: nil, preferredStyle: .alert)
        
        alert!.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alert!, animated: true, completion: nil)
    }
    
    
    private func onSelectBankCellClicked() {
        alert = UIAlertController(title: "Enter bank name", message: nil, preferredStyle: .alert)
        alert!.addTextField(configurationHandler: {
            field in
            field.tag = self.BANK_CELL_TAG
            field.delegate = self
            field.keyboardAppearance = .default
            field.keyboardType = .default
            field.placeholder = "Type bank name here"
        })
        
        alert!.addAction(UIAlertAction(title: "Done", style: .default, handler: {
            action in
            
            // action here
            
        }))
        
        alert!.actions[0].isEnabled = false
        alert!.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alert!, animated: true, completion: nil)
    }
    
    private func onPrefixCellClicked() {
        alert = UIAlertController(title: "Enter prefix", message: nil, preferredStyle: .alert)
        alert!.addTextField(configurationHandler: {
            field in
            field.tag = self.PREFIX_CELL_TAG
            field.delegate = self
            field.keyboardAppearance = .default
            field.keyboardType = .default
            field.placeholder = "Type prefix here"
        })
        
        alert!.addAction(UIAlertAction(title: "Done", style: .default, handler: {
            action in
            
            // action here
            
        }))
        
        alert!.actions[0].isEnabled = false
        alert!.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alert!, animated: true, completion: nil)
    }
    
    private func onExpireCellClicked() {
        alert = UIAlertController(title: "Enter expiration date", message: nil, preferredStyle: .alert)
        alert!.addTextField(configurationHandler: {
            field in
            field.tag = self.EXPIRE_CELL_TAG
            field.delegate = self
            field.keyboardAppearance = .default
            field.keyboardType = .default
            field.placeholder = "Type expiration here"
        })
        
        alert!.addAction(UIAlertAction(title: "Done", style: .default, handler: {
            action in
            
            // action here
            
        }))
        
        alert!.actions[0].isEnabled = false
        alert!.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alert!, animated: true, completion: nil)
    }
    
    private func onPinCellClicked() {
        alert = UIAlertController(title: "Enter PIN", message: nil, preferredStyle: .alert)
        alert!.addTextField(configurationHandler: {
            field in
            field.tag = self.PIN_CELL_TAG
            field.delegate = self
            field.keyboardAppearance = .default
            field.keyboardType = .numberPad
            field.placeholder = "Type PIN here"
        })
        
        alert!.addAction(UIAlertAction(title: "Done", style: .default, handler: {
            action in
            
            // action here
            
        }))
        
        alert!.actions[0].isEnabled = false
        alert!.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alert!, animated: true, completion: nil)
    }
    
    
    private func makeVisaTableViewCell(_ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PAYMENT_VISA_TABLE_VIEW_CELL_ID, for: indexPath)
        cell.accessoryType = isVisaChecked ? .checkmark : .none
        return cell
    }
    
    private func makeMasterCardTableViewCell(_ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PAYMENT_MASTERCARD_TABLE_VIEW_CELL_ID, for: indexPath)
        cell.accessoryType = isMasterCardChecked ? .checkmark : .none
        return cell
    }
    
    private func makeAmexTableViewCell(_ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PAYMENT_AMEX_TABLE_VIEW_CELL_ID, for: indexPath)
        cell.accessoryType = isAmexChecked ? .checkmark : .none
        return cell
    }
    
    private func makePayPalTableViewCell(_ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PAYMENT_PAYPAL_TABLE_VIEW_CELL_ID, for: indexPath)
        cell.accessoryType = isPayPalChecked ? .checkmark : .none
        return cell
    }
    
    private func makeKnetTableViewCell(_ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PAYMENT_KNET_TABLE_VIEW_CELL_ID, for: indexPath)
        cell.accessoryType = isKnetChecked ? .checkmark : .none
        return cell
    }
    
    private func makeCashTableViewCell(_ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PAYMENT_CASH_TABLE_VIEW_CELL_ID, for: indexPath)
        cell.accessoryType = isCashChecked ? .checkmark : .none
        return cell
    }
    
    private func makeCardHolderTableViewCell(_ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PAYMENT_CARDHOLDER_TABLE_VIEW_CELL_ID, for: indexPath)
        return cell
    }
    
    private func makeCardNumberTableViewCell(_ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PAYMENT_NUMBER_TABLE_VIEW_CELL_ID, for: indexPath)
        return cell
    }
    
    private func makeCardExpireTableViewCell(_ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PAYMENT_CARD_EXPIRE_TABLE_VIEW_CELL_ID, for: indexPath)
        return cell
    }
    
    private func makeEmailTableViewCell(_ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PAYMENT_EMAIL_TABLE_VIEW_CELL_ID, for: indexPath)
        return cell
    }
    
    private func makePasswordTableViewCell(_ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PAYMENT_PASSWORD_TABLE_VIEW_CELL_ID, for: indexPath)
        return cell
    }
    
    private func makeSelectYourBankTableViewCell(_ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PAYMENT_SELECT_YOUR_BANK_TABLE_VIEW_CELL_ID, for: indexPath)
        return cell
    }
    
    private func makePrefixTableViewCell(_ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PAYMENT_PREFIX_TABLE_VIEW_CELL_ID, for: indexPath)
        return cell
    }
    
    private func makeExpireTableViewCell(_ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PAYMENT_EXPIRE_TABLE_VIEW_CELL_ID, for: indexPath)
        return cell
    }
    
    private func makePINTableViewCell(_ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PAYMENT_PIN_TABLE_VIEW_CELL_ID, for: indexPath)
        return cell
    }

    private func makePaymentInfoTableViewCell(_ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PAYMENT_PAYMENT_INFO_TABLE_VIEW_CELL_ID, for: indexPath)
        return cell
    }
    
    private func makeTrainerTableViewCell(_ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PAYMENT_TRAINER_TABLE_VIEW_CELL_ID, for: indexPath)
        return cell
    }
    
    private func makePriceTableViewCell(_ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PAYMENT_PRICE_TABLE_VIEW_CELL_ID, for: indexPath)
        return cell
    }
    
    private func makeDayTableViewCell(_ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PAYMENT_DAY_TABLE_VIEW_CELL_ID, for: indexPath)
        return cell
    }
    
    private func makeHoursTableViewCell(_ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PAYMENT_HOURS_TABLE_VIEW_CELL_ID, for: indexPath)
        return cell
    }
    
    private func makeAddToCalendarTableViewCell(_ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PAYMENT_ADD_TO_CALENDAR_TABLE_VIEW_CELL_ID, for: indexPath)
        return cell
    }
    
    private func makeSavePaymentMethodTableViewCell(_ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PAYMENT_SAVE_PAYMENT_METHODS_TABLE_VIEW_CELL_ID, for: indexPath)
        return cell
    }
    
    private func makePayTableViewCell(_ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PAYMENT_PAY_TABLE_VIEW_CELL_ID, for: indexPath)
        return cell
    }
    
}
