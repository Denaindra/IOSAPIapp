//
//  DetailViewController.swift
//  SampleIOSApp
//
//  Created by gayan perera on 1/1/19.
//  Copyright © 2019 gayan perera. All rights reserved.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageTitle: UILabel!
    @IBOutlet weak var imageDescription: UILabel!
    var dataResponse = FBResponse()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetDataFromSegu()
    }
    
    func SetDataFromSegu() {
        imageTitle.text = dataResponse.title
        imageDescription.text = dataResponse.description
        //imageView.sd_setImage(with: URL(string:dataResponse.image.small!))
        imageView.sd_setImage(with: URL(string: dataResponse.image.large!)) { (image, error, cache, url) in
            // Your code inside completion block
        }
      
    }
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    
}
