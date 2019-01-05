
import UIKit
import FacebookLogin
import FBSDKLoginKit
import SwiftyJSON
import SDWebImage


class ViewController: UIViewController{
    
    //UI outlets
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var listView: UITableView!
    
    //properties
    private let FBButton = FBSDKLoginButton()
    private var selectedData = FBResponse()
    private let clientUtitlity = ClientUtility()
    private let userDefault = UserDefault()
    private var dataResponse:[FBResponse] = []
    private let imageSync = ImageSync()
    
    
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
                fbresponse.image.small = item["image"]["small"].stringValue
                fbresponse.image.large = item["image"]["large"].stringValue
                self.dataResponse.append(fbresponse)
            }
            self.listView.reloadData()
        })
        self.name.text = userDefault.GetUserDafultValue(key: "name")
        self.email.text = userDefault.GetUserDafultValue(key: "email")
    }
    
    func ChnageButtonText(btntitle:String) {
        loginButton.setTitle(btntitle, for: .normal)
    }
    
    func ListviewVisibility(hidden:Bool) {
        listView.isHidden = hidden
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegu" {
            if let destinationVC = segue.destination as? DetailViewController {
                 destinationVC.dataResponse = self.selectedData
            }
        }
    }
}


extension ViewController : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataResponse.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = listView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
        cell.title.text = self.dataResponse[indexPath.row].title
        cell.address.text = self.dataResponse[indexPath.row].address
        cell.uiImageView.sd_setImage(with: URL(string:self.dataResponse[indexPath.row].image.small!))
        imageSync.GetImageFromUrl(imageUrl:dataResponse[indexPath.row].image.small!, image:  cell.uiImageView)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedData = dataResponse[indexPath.row]
        performSegue(withIdentifier: "detailSegu", sender: nil)
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
                    self.LoadData()
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
        self.name.text = ""
        self.email.text = ""
        userDefault.RemoveUserDefault(key: "name")
        userDefault.RemoveUserDefault(key: "email")

    }
    
    func UpdateuserDetails(value:JSON) {
        self.name.text = value["name"].string
        self.email.text = value["email"].string
        userDefault.SetUserDafaultparameter(value: value["name"].string!, key: "name")
        userDefault.SetUserDafaultparameter(value: value["email"].string!, key: "email")

    }
}
