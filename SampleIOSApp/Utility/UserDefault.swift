//
//  UserDefault.swift
//  SampleIOSApp
//
//  Created by gayan perera on 12/31/18.
//  Copyright © 2018 gayan perera. All rights reserved.
//

import Foundation


class UserDefault {
    
    private let userDefaults = UserDefaults.standard
    
    
    func SetUserDafaultparameter(value:String,key:String){
        self.userDefaults.set(value, forKey: key)
    }
    
    func GetUserDafultValue(key:String) -> String {
        return userDefaults.string(forKey:key) ?? ""
    }
    
    func RemoveUserDefault(key:String) {
        UserDefaults.standard.removeObject(forKey:key)
    }
}
