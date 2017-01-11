//
//  SightingDetailsViewController.swift
//  WildlifeSighting
//
//  Created by Sabrina Ip on 1/9/17.
//  Copyright © 2017 Sabrina, Vic, Tom. All rights reserved.
//

import UIKit

class SightingDetailsViewController: UIViewController {

    var sighting: Sighting!
    var sightingIndexPath: IndexPath!
    
    @IBOutlet weak var imageDetailsLabel: UILabel!
    @IBOutlet weak var sightingImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var editSaveButton: UIButton!
    @IBOutlet weak var detailsTextView: UITextView!
    @IBOutlet weak var dateWeatherLocationTextView: UITextView!
    
//    var mainContext: NSManagedObjectContext {
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        return appDelegate.persistentContainer.viewContext
//    }
    
    //let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext

    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateLabels()
        self.automaticallyAdjustsScrollViewInsets = false
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SightingDetailsViewController.dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
    }
    
    
    func updateLabels() {
        titleLabel.text = sighting.name!
        
        detailsTextView.text = sighting.details ?? ""
        if let image = sighting.fullImageData as? Data {
            sightingImageView.image = UIImage(data: image)
        }
        var dateWeatherText = ""
        dateWeatherText += sighting.dateAndTime
        if sighting.latitude != 0 && sighting.longitude != 0 {
            dateWeatherText += "\nLatitude: " + String(sighting.latitude)
            dateWeatherText += "\nLongitude: " + String(sighting.longitude)
            //TODO: Get Placemark
        }
        
        if let weather = sighting.weatherDescription, weather != "" {
            dateWeatherText += "\nWeather: " + weather
        }
        dateWeatherLocationTextView.text = dateWeatherText
    }
    
    @IBAction func editSaveButtonPressed(_ sender: UIButton) {

        
        
        if editSaveButton.titleLabel?.text == "Edit" {

            titleLabel.isHidden = true
            titleTextField.isHidden = false
            detailsTextView.isEditable = true
            titleTextField.text = titleLabel.text
            let borderColor = UIColor(red: 215.0 / 255.0, green: 215.0 / 255.0, blue: 215.0 / 255.0, alpha: 1)
            detailsTextView.layer.borderColor = borderColor.cgColor
            detailsTextView.layer.borderWidth = 0.6;
            detailsTextView.layer.cornerRadius = 6.0;
            editSaveButton.setTitle("Save", for: .normal)
        } else {
            guard let sightingName = titleTextField.text, sightingName.characters.count > 0 else {
                showAlertWith(title: "No Name", message: "Please make sure you've entered a name for this sighting.")
                return
            }
            guard let sightingDetail = detailsTextView.text, sightingDetail.characters.count > 0 else {
                showAlertWith(title: "No Details", message: "Please make sure you've entered details for this sighting.")
                return
            }
            titleTextField.isHidden = true
            titleLabel.isHidden = false
            detailsTextView.isEditable = false
            titleLabel.text = titleTextField.text
            editSaveButton.setTitle("Edit", for: .normal)
            detailsTextView.layer.borderColor = UIColor.clear.withAlphaComponent(0.0).cgColor
        }
    }
    
    func showAlertWith(title: String, message: String, completion: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: completion)
        alert.addAction(okayAction)
        present(alert, animated: true, completion: nil)
    }
    
    func saveToCoreData() {
        
//        let predicate = NSPredicate(format: "objectID == %@", objectIDFromNSManagedObject)
//        
//        let fetchRequest = NSFetchRequest(entityName: "Sighting")
//        fetchRequest.predicate = predicate
//        
//        do {
//            let fetchedEntities = try mainContext.executeFetchRequest(fetchRequest) as! [MyEntity]
//            fetchedEntities.first?.FirstPropertyToUpdate = NewValue
//            fetchedEntities.first?.SecondPropertyToUpdate = NewValue
//            // ... Update additional properties with new values
//        } catch {
//            // Do something in response to error condition
//        }
//        
//        do {
//            try self.mainObjectContext.save()
//        } catch {
//            // Do something in response to error condition
//        }
        
//        
//        
//        let newSightingObject = Sighting(context: mainContext)
//        newSightingObject.name = sightingName
//        newSightingObject.details = sightingDetail
//        newSightingObject.date = NSDate()
//        if let currentWeatherInfo = currentWeather {
//            newSightingObject.temperature = currentWeatherInfo.temp
//            newSightingObject.weatherDescription = currentWeatherInfo.summary
//        }
//        if let currentLocationInfo = currentLocation {
//            newSightingObject.latitude = currentLocationInfo.coordinate.latitude
//            newSightingObject.longitude = currentLocationInfo.coordinate.longitude
//        }
//        if let image = sightingPhoto, let asset = image.imageAsset,
//            let thumbData = UIImageJPEGRepresentation(image, 0.4),
//            let fullData = UIImageJPEGRepresentation(image, 1.0) {
//            
//            newSightingObject.imageAssetURL = String(describing: asset)
//            newSightingObject.fullImageData = NSData(data: thumbData)
//            newSightingObject.thumbImageData = NSData(data: fullData)
//        }
//        do {
//            try mainContext.save()
//        }
//        catch let error {
//            fatalError("Failed to save context: \(error)")
//        }
//        
//        showAlertWith(title: "Success", message: "Sighting Added Succesfully") { (_) in
//            _ = self.navigationController?.popViewController(animated: true) }
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
}
