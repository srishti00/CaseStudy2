//
//  OrderViewController.swift
//  CaseStudy2
//
//  Created by Capgemini-DA204 on 9/24/22.
//

import UIKit
import MapKit

class OrderViewController: UIViewController, CLLocationManagerDelegate {

    //MARK: IBOutlet start
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var orderNowButtonLabel: UIButton!
    @IBOutlet weak var userMapView: MKMapView!
    
    //MARK: IBOutlet end
    
    //MARK: Variables
    
    var locationManager: CLLocationManager!
    var userLocation: CLLocation!
    var annotation: MKPointAnnotation!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "Checkout"
        self.navigationItem.backBarButtonItem?.tintColor = .white
        
        //adjust size for logo image
        logoImageView.layer.masksToBounds = false
        logoImageView.layer.cornerRadius = logoImageView.frame.height/2
        logoImageView.clipsToBounds = true
        
        orderNowButtonLabel.layer.cornerRadius = 10
        determineLocation()
    }
    
    //MARK: Map View functions
    
    func determineLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
    
    //It will update current location in map
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //get user's current location
        userLocation = locations[0] as CLLocation
        let center = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        userMapView.setRegion(region, animated: true)
        
        //create annotation
        annotation = MKPointAnnotation()
        annotation.coordinate = center
        setLocationName() {
            (address) in
            self.annotation.title = address
        }
        userMapView.addAnnotation(annotation)
    }
    
    //it will set user's current location as annotation title
    func setLocationName(handler: @escaping (String) -> Void) {
        let location = CLLocation(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location, completionHandler: {
            (placemark, error) in
               let placemark = placemark![0]
            let address = "\(placemark.subLocality ?? ""), \(placemark.locality ?? ""), \(placemark.administrativeArea ?? ""), \(placemark.country ?? ""), \(placemark.postalCode ?? "")"
            handler(address)
        })
    }
    
    //MARK: IBAction
    
    @IBAction func orderNowButtonClicked(_ sender: Any) {
        let notiVC = self.storyboard?.instantiateViewController(withIdentifier: "NotificationViewController") as! NotificationViewController
        self.navigationController?.pushViewController(notiVC, animated: true)
        notiVC.location = annotation.title
        
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
