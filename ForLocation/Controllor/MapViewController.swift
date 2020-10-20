//
//  ViewController.swift
//  ForLocation
//
//  Created by Zhaoyang Li on 6/29/20.
//  Copyright © 2020 Zhaoyang Li. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class MapViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var longituteLabel: UILabel! {
        didSet {
            longituteLabel.textAlignment = .center
            longituteLabel.text = "longitute"
        }
    }
    @IBOutlet weak var latituteLabel: UILabel! {
        didSet {
            latituteLabel.textAlignment = .center
            latituteLabel.text = "latitute"
        }
    }
    @IBOutlet weak var altituteLabel: UILabel! {
        didSet {
            altituteLabel.textAlignment = .center
            altituteLabel.text = "altitute"
        }
    }
    @IBOutlet weak var mapView: MKMapView! {
        didSet {
            mapView.delegate = self
            mapView.showsUserLocation = true
        }
    }
    @IBOutlet weak var LatituteTextField: UITextField! {
        didSet {
            LatituteTextField.delegate = self
        }
    }
    @IBOutlet weak var LongituteTextField: UITextField! {
        didSet {
            LongituteTextField.delegate = self
        }
    }
    @IBOutlet weak var pinImageView: UIImageView! {
        didSet {
            pinImageView.image = UIImage(systemName: "arrow.down")
            pinImageView.tintColor = .black
//            pinImageView.isHidden = true
        }
    }
    @IBOutlet weak var searchController: UISearchBar! {
        didSet {
            searchController.delegate = self
        }
    }
    let pinAnnotationView: MKAnnotationView = {
        let view = MKAnnotationView()
        view.backgroundColor = .lightGray
        let size = CGSize(width: 30, height: 60)
        view.image = UIImage(systemName: "arrow.down")
        view.frame = CGRect(origin: .zero, size: size)
        return view
    }()
    lazy var locationManger: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.pausesLocationUpdatesAutomatically = true
        return locationManager
    }()
    
    let annotation = MKPointAnnotation()
    var pendingReqequestWorkItem: DispatchWorkItem?
    var bestLocation: CLLocation?
    var selectedLocationCoordinate: CLLocationCoordinate2D?
    var selectedAddress: String?
    var allArtsInfo: [Art]?
    var testView: MKAnnotationView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkAuthrization()
        showAllArtsOnAnnotation()
//        DispatchQueue.global(qos: .background).async {
//            self.mapView.addSubview(self.pinImageView)
//        }
        
    }
    
    private func showAllArtsOnAnnotation() {
        guard let allArtsInfo = ServiceManager().fetchBasicData() else { return }
        for art in allArtsInfo {
            let annotation = MKPointAnnotation()
            if let latitute = art.latitude,
                let doubleLatitute = Double(latitute),
                let longitude = art.longitude,
                let doubleLongitude = Double(longitude),
                let title = art.title {
                annotation.coordinate.latitude = doubleLatitute
                annotation.coordinate.longitude = doubleLongitude
                annotation.title = title
                mapView.addAnnotation(annotation)
            }
        }
    }
    //change back to delegate
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(bestLocationButtonInCalloutViewTapped), name: AppConstants.bestLocationNotificationName, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(destinationButtonInCalloutViewTapped), name: AppConstants.destinationNotificationName, object: nil)
    }
    
    private func checkAuthrization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways:
            showCenterOfUser()
        case .denied:
            break
        case .restricted:
            break
        case .authorizedWhenInUse:
            break
        case .notDetermined:
            locationManger.requestAlwaysAuthorization()
        default:
            break
        }
    }
    
    //MARK: - button tapped
    @IBAction func reCenterButtonTapped(_ sender: Any) {
        showCenterOfUser()
    }
    
    @IBAction func goPinButtonTapped(_ sender: Any) {
        showPins()
    }
    
    private func showPins() {
        //apple La 37.3318 lo -122.0312
        //origin version
//        if let latituteCo = Double(LatituteTextField.text ?? ""), let longituteCo = Double(LongituteTextField.text ?? "") {
//            annotation.coordinate = CLLocationCoordinate2D(latitude: latituteCo, longitude: longituteCo)
//            annotation.title = "THIS IS WHERE YOU WANT"
//            annotation.subtitle = "this is where you want"
//            mapView.addAnnotations([annotation])
//            let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 1_000, longitudinalMeters: 1_000)
//            mapView.setRegion(region, animated: true)
//        }
        
        locationManger.stopUpdatingLocation()
        if let latituteCo = Double(LatituteTextField.text ?? ""), let longituteCo = Double(LongituteTextField.text ?? "") {
            let chosenCoordinate = CLLocation(latitude: latituteCo, longitude: longituteCo)
            let customPin = CustomAnnotation(coordinate: chosenCoordinate.coordinate, locationName: "customName")
            customPin.title = "this is the title"
            customPin.subtitle = "Subtitle"
            mapView.addAnnotation(customPin)
            let region = MKCoordinateRegion(center: chosenCoordinate.coordinate, latitudinalMeters: 1_000, longitudinalMeters: 1_000)
            mapView.setRegion(region, animated: true)
        }
    }
    
    @objc func bestLocationButtonInCalloutViewTapped() {
        let alertController = UIAlertController(title: "For best location", message: "bestlocationCoordiate:\(bestLocation?.coordinate.longitude ?? CLLocationDegrees()) and \(bestLocation?.coordinate.latitude ?? CLLocationDegrees())", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Close", style: .default, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func destinationButtonInCalloutViewTapped() {
        let alertController = UIAlertController(title: "For destination", message: "destinationAddress: \(selectedAddress ?? "not detected")", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Close", style: .default, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
    
    private func getCenterLocation(for mapView: MKMapView) -> CLLocation {
        let centerLatitude = mapView.centerCoordinate.latitude
        let centerLongitute = mapView.centerCoordinate.longitude
        return CLLocation(latitude: centerLatitude, longitude: centerLongitute)
    }
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        print("now you are at \n\n", locations)
   
        if let lastlocation = self.bestLocation {
            if lastlocation.horizontalAccuracy < bestLocation!.horizontalAccuracy, lastlocation.verticalAccuracy < bestLocation!.verticalAccuracy {
                bestLocation = lastlocation
            } else {
                locationManger.stopUpdatingLocation()
            }
        } else {
            self.bestLocation = locations.last
        }
        
        if let bestLocation = bestLocation {
            longituteLabel.text = "BestLong \(String(describing: bestLocation.coordinate.longitude))"
            altituteLabel.text = "BestLa \(String(describing: bestLocation.horizontalAccuracy))"
            latituteLabel.text = "BestAccuracy \(String(describing: bestLocation.coordinate.latitude))"
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        let alertBackUp = UIAlertController(title: "wrong", message: "wrongwrongwrong", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "ok", style: .default, handler: nil)
        alertBackUp.addAction(alertAction)
        present(alertBackUp, animated: true, completion: nil)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkAuthrization()
    }

    private func showCenterOfUser() {
        locationManger.startUpdatingLocation()
        if let cneteredLocation = locationManger.location?.coordinate {
            let region = MKCoordinateRegion(center: cneteredLocation, latitudinalMeters: 2_000, longitudinalMeters: 2_000)
            mapView.setRegion(region, animated: true)
        }
    }
    
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        let identifierAnnotationView = "idAV"
        var annotationView = self.mapView.dequeueReusableAnnotationView(withIdentifier: identifierAnnotationView)
        if annotationView == nil {
            annotationView = CustomAnnotationView(annotation: annotation, reuseIdentifier: identifierAnnotationView)
            annotationView?.canShowCallout = false
        } else {
            annotationView?.annotation = annotation
        }
        annotationView?.image = UIImage(systemName: "arrow.down")
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let center = getCenterLocation(for: mapView)
        let geocoder = CLGeocoder()
        print("region changed")
        geocoder.reverseGeocodeLocation(center) { (placeMark, error) in
            guard let placeMark = placeMark?.first else {return}
            self.processPlacemraks([placeMark])
        }
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let centerCoordinate = view.annotation?.coordinate {
            let region = MKCoordinateRegion(center: centerCoordinate, latitudinalMeters: 2000, longitudinalMeters: 2000)
            mapView.setRegion(region, animated: true)
        }
        
        let views = Bundle.main.loadNibNamed(AppConstants.nibName, owner: nil, options: nil)
        let calloutView = views?.first as! CustomCalloutViewNibs
        calloutView.bestlocationButton.addTarget(self, action: #selector(self.bestLocationButtonInCalloutViewTapped), for: .touchUpInside)
        calloutView.destinationButton.addTarget(self, action: #selector(self.destinationButtonInCalloutViewTapped), for: .touchUpInside)
        if let latitude = view.annotation?.coordinate.latitude, let longitute = view.annotation?.coordinate.longitude {
            var latitudeString = String(latitude) as NSString
            var longituteString = String(longitute) as NSString
            if latitudeString.length > 6 {
                latitudeString = latitudeString.substring(with: NSRange(location: 0, length: 7)) as NSString
            }
            if longituteString.length > 6 {
                longituteString = longituteString.substring(with: NSRange(location: 0, length: 7)) as NSString
            }
            
            calloutView.titleLabel.text = "La\(latitudeString)"
            calloutView.subtitleLabel.text = "Lo\(longituteString)"
        }

        calloutView.center = CGPoint(x: view.bounds.size.width / 2, y: view.bounds.size.height / 2 - 100)
        view.addSubview(calloutView)
        
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        if view.isKind(of: CustomAnnotationView.self) {
            for subview in view.subviews {
                subview.removeFromSuperview()
            }
        }
    }
}

extension MapViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        pendingReqequestWorkItem?.cancel()
        pendingReqequestWorkItem = DispatchWorkItem { [weak self] in //trimmming
            self?.resultsLoader(forQuery: searchText)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: pendingReqequestWorkItem!) //unwrapping
    }
    
    func resultsLoader(forQuery: String) {
        print("para\n", forQuery)
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = forQuery
        request.region = mapView.region
        
        let search = MKLocalSearch(request: request)
        search.start { (response, error) in
            
            guard let response = response else {return}
            print(response.mapItems.count)
            for item in response.mapItems {
                let annotation = MKPointAnnotation()
                annotation.coordinate = item.placemark.coordinate
                annotation.title = item.name
                self.mapView.addAnnotation(annotation)
            }
        }
    }
    
    func processPlacemraks(_ placemarks: [CLPlacemark]) {
        guard let placemark = placemarks.first else { return }
        selectedAddress = placemark.completeAddress
    }
}

extension CLPlacemark {
    var completeAddress: String? {
        if let name = self.name {
            var address = name
            if let postalCode = self.postalCode  {
                address += ", \(postalCode)"
            }
            if let areaOfInterest = self.areasOfInterest?.first {
                address += ", \(areaOfInterest)"
            }
            return address
        }
        return nil
    }
}
