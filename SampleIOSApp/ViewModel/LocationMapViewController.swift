//
//  LocationMapViewController.swift
//  SampleIOSApp
//
//  Created by gayan perera on 1/6/19.
//  Copyright © 2019 gayan perera. All rights reserved.
//

import UIKit
import GoogleMaps

class LocationMapViewController: UIViewController {

    public var dataResponse = FBResponse()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        //print("\(dataResponse.address) \(dataResponse.latitude) \(dataResponse.longitude)")
    }
    
    
    override func loadView() {

        let camera = GMSCameraPosition.camera(withLatitude: Double(dataResponse.latitude!) ?? 0, longitude: Double(dataResponse.longitude!) ?? 0, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: Double(dataResponse.latitude!) ?? 0, longitude: Double(dataResponse.longitude!) ?? 0)
        marker.title = dataResponse.address
        marker.map = mapView
    }
    
    override func viewDidAppear(_ animated: Bool) {

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
