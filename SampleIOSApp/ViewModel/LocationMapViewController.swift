//
//  LocationMapViewController.swift
//  SampleIOSApp
//
//  Created by gayan perera on 1/6/19.
//  Copyright © 2019 gayan perera. All rights reserved.
//

import UIKit

class LocationMapViewController: UIViewController {

    public var dataResponse = FBResponse()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("\(dataResponse.address) \(dataResponse.latitude) \(dataResponse.longitude)")
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
