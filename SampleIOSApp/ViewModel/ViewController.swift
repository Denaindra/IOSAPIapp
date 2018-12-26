
import UIKit
import FacebookLogin
import FBSDKLoginKit
import SwiftyJSON

class ViewController: UIViewController{
    
    //UI outlets
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var Email: UILabel!
    @IBOutlet weak var listView: UITableView!
    
    
    //properties
    private let FBButton = FBSDKLoginButton()
    private let animals: [String] = ["Horse", "Cow", "Camel", "Sheep", "Goat"]

    
    
    @IBAction func LoginButtonClick(_ sender: UIButton) {
        FBButton.sendActions(for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.listView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        IntialSeteupFBLoginButton()
        InitialSteupForUItableView()
    }
    
    func InitialSteupForUItableView(){

    }
    
    func IntialSeteupFBLoginButton() {
        FBButton.readPermissions = ["public_profile","email"]
        FBButton.delegate = self
        if FBSDKAccessToken.current() != nil {
            ChnageButtonText(btntitle:"Logout")
            listView.isHidden = false;
        }
            
        else {
            ChnageButtonText(btntitle:"Logging")
            listView.isHidden = true;
        }
    }
    
    func ChnageButtonText(btntitle:String) {
        loginButton.setTitle(btntitle, for: .normal)
        
    }
}


extension ViewController : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return animals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = listView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
        cell.title.text = self.animals[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}

extension ViewController : FBSDKLoginButtonDelegate {
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print ("Here there is erro \(error!)")
        }
        else if result.isCancelled{
            print ("user can cle login ")
        }
        else {
            FBSDKGraphRequest(graphPath:"me", parameters: ["fields":"email,name"]).start(completionHandler: { (connection, result, error) in
                if error == nil {
                    let value : JSON = JSON(result!)
                    self.UpdateuserDetails(value: value)
                    self.ChnageButtonText(btntitle:"Logout")
                    self.listView.isHidden = false;
                }
                else {
                    print("Error Getting Info \(error!)");
                }
            })
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        ChnageButtonText(btntitle:"Logging")
        listView.isHidden = true;
    }
    
    func UpdateuserDetails(value:JSON){
        self.userName.text = value["name"].string
        self.Email.text = value["email"].string
    }
}
