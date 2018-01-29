

import UIKit

class ChatListTableViewController: UITableViewController {

    var chats: [UIChatModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar(navigationController?.navigationBar)
        
        tableView.separatorColor = UIColor.clear
        
        // load chats from back-end
        loadChats()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatTableViewCell", for: indexPath) as! ChatTableViewCell
        
        let model = chats[indexPath.row]
        if let url = URL(string: model.person.imgUrl) {
            cell.avatar.kf.setImage(with: url)
        } else {
            cell.avatar.image = UIImage(named: "ic_account_circle")
        }
        
        cell.personLabel.text! = model.person.fullName
        cell.messageLabel.text! = model.contentOfLastMessage
        cell.timeLabel.text! = model.timeLastMessageSent
        
        if model.person.isOnline {
            cell.onlineIndicator.isHidden = false
        } else {
            cell.onlineIndicator.isHidden = true
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chats.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        if let dialogViewController = storyboard?.instantiateViewController(withIdentifier: "DialogViewController") as? ChatViewController {
            dialogViewController.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(dialogViewController, animated: true)
        }
    }
    
    
    private func loadChats() {
        chats.append(UIChatModel(person: UIUserModel(fullName: "Andrey Prokhorenko", imgUrl: "", gender: "male", age: 123, city: "Chernihiv", weight: 123, height: 123, email: "prokho@gmi", phoneNumber: "1231312312"), timeLastMessageSent: "10:30", contentOfLastMessage: "Hello, how are you? I am ok, I was thinking about our partnership. We can develop this program together and ear billions with that? What do you think?"))
        
        chats.append(UIChatModel(person: UIUserModel(fullName: "Leha Siply", imgUrl: "", gender: "male", age: 123, city: "Chernihiv", weight: 123, height: 123, email: "prokho@gmi", phoneNumber: "1231312312"), timeLastMessageSent: "10:30", contentOfLastMessage: "Hello, how are you? I am ok, I was thinking about our partnership. We can develop this program together and ear billions with that? What do you think?"))
        
        chats.append(UIChatModel(person: UIUserModel(fullName: "Kirgiz Semenych", imgUrl: "", gender: "male", age: 123, city: "Chernihiv", weight: 123, height: 123, email: "prokho@gmi", phoneNumber: "1231312312"), timeLastMessageSent: "10:30", contentOfLastMessage: "Hello, how are you? I am ok, I was thinking about our partnership. We can develop this program together and ear billions with that? What do you think?"))
        
    }
}
