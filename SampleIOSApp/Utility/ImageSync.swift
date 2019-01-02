//
//  ImageSync.swift
//  SampleIOSApp
//
//  Created by gayan perera on 1/2/19.
//  Copyright © 2019 gayan perera. All rights reserved.
//

import Foundation
import UIKit

class ImageSync{

    func GetImageFromUrl(imageUrl:String,image:UIImageView){
       image.sd_setImage(with: URL(string:imageUrl))
    }
}
