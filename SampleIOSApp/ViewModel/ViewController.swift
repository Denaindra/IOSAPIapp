
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
    private let clientUtitlity = ClientUtility()
    private var dataResponse:[FBResponse] = []
    
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
        listView.rowHeight = UITableView.automaticDimension
        listView.estimatedRowHeight = 10
    }
    
    func IntialSeteupFBLoginButton() {
        FBButton.readPermissions = ["public_profile","email"]
        FBButton.delegate = self
        if FBSDKAccessToken.current() != nil {
            ChnageButtonText(btntitle:"Logout")
            self.ListviewVisibility(hidden: false)
            LoadData()
        }
            
        else {
            ChnageButtonText(btntitle:"Logging")
            self.ListviewVisibility(hidden: true)
        }
    }
    func LoadData() {
        clientUtitlity.RetriveDetailList(completion: {
            let result = self.clientUtitlity.GetResultDetails()["data"]
           
            for item in result.arrayValue {
                let fbresponse = FBResponse()
                fbresponse.title = item["title"].stringValue
                fbresponse.description = item["description"].stringValue
                fbresponse.address = item["address"].stringValue
                self.dataResponse.append(fbresponse)
            }
            self.listView.reloadData()
        })
    }
    
    func ChnageButtonText(btntitle:String) {
        loginButton.setTitle(btntitle, for: .normal)
    }
    
    func ListviewVisibility(hidden:Bool) {
        listView.isHidden = hidden
    }
}


extension ViewController : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataResponse.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = listView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
        cell.title.text = self.dataResponse[indexPath.row].title
        return cell
    }
    
}

extension ViewController : FBSDKLoginButtonDelegate {
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result:
        FBSDKLoginManagerLoginResult!, error: Error!) {
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
                    self.ListviewVisibility(hidden: false)
                }
                else {
                    print("Error Getting Info \(error!)");
                }
            })
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        ChnageButtonText(btntitle:"Logging")
        self.ListviewVisibility(hidden: true)
    }
    
    func UpdateuserDetails(value:JSON){
        self.userName.text = value["name"].string
        self.Email.text = value["email"].string
    }
}
