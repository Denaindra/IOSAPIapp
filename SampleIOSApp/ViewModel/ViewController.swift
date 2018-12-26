
import UIKit
import FacebookLogin
import FBSDKLoginKit
import SwiftyJSON

class ViewController: UIViewController{
    
    //UI outlets
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var Email: UILabel!
    
    
    //properties
    private let FBButton = FBSDKLoginButton()
    
    
    
    @IBAction func LoginButtonClick(_ sender: UIButton) {
        FBButton.sendActions(for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        intialSeteupFBLoginButton()
    }
    
    func intialSeteupFBLoginButton() {
        FBButton.readPermissions = ["public_profile","email"]
        FBButton.delegate = self
        if FBSDKAccessToken.current() != nil {
            ChnageButtonText(btntitle:"Logout")
        }
        else {
            ChnageButtonText(btntitle:"Logging")
        }
    }
    
    func ChnageButtonText(btntitle:String) {
        loginButton.setTitle(btntitle, for: .normal)

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
                }
                else {
                    print("Error Getting Info \(error!)");
                }
            })
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
       ChnageButtonText(btntitle:"Logging")
    }
    func UpdateuserDetails(value:JSON){
        self.userName.text = value["name"].string
        self.Email.text = value["email"].string
    }
}
