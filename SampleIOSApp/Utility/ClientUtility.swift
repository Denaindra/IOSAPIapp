//
//  ClientUtility.swift
//  SampleIOSApp
//
//  Created by gayan perera on 12/28/18.
//  Copyright © 2018 gayan perera. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class ClientUtility{
    
    private let WEB_URL = "https://dl.dropboxusercontent.com/s/6nt7fkdt7ck0lue/hotels.json"
    private var result:JSON?
    
    func RetriveDetailList(completion : @escaping ()->())  {
        Alamofire.request(self.WEB_URL, method: .get, parameters: nil).responseJSON {
            responses in
            if responses.result.isSuccess {
                self.result = JSON(responses.result.value ?? "")
            }
            completion()
        }
    }
    
    func GetResultDetails() -> JSON {
        return result ?? []
    }
}
