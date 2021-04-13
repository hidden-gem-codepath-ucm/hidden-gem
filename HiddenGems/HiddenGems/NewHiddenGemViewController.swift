//
//  NewHiddenGemViewController.swift
//  HiddenGems
//
//  Created by Eduardo Barreto-Mendoza on 4/5/21.
//

import UIKit
import CoreLocation
import Parse

class NewHiddenGemViewController: UIViewController {
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var cityField: UITextField!
    @IBOutlet weak var stateField: UITextField!
    @IBOutlet weak var zipField: UITextField!
    @IBOutlet weak var descriptionField: UITextView!
    
    
    @IBAction func onAdd(_ sender: Any) {
        let geocoder = CLGeocoder()
        var addressString = addressField.text
        addressString = (addressString! + ", " + cityField.text!) as String?
        addressString = (addressString! + ", " + stateField.text!) as String?
        addressString = (addressString! + ", " + zipField.text!) as String?
        geocoder.geocodeAddressString(addressString!) { (placemarks, error) in
                if error == nil {
                    if let placemark = placemarks?[0] {
                        let location = placemark.location!
                        
                        let hiddenGem = PFObject(className:"HiddenGems")
                        hiddenGem["title"] = self.nameField.text
                        hiddenGem["description"] = self.descriptionField.text
                        hiddenGem["author"] = PFUser.current()
                        hiddenGem["location"] = PFGeoPoint(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                        hiddenGem.saveInBackground { (succeeded, error)  in
                            if (succeeded) {
                                print("Success in creating HiddenGem")
                                self.dismiss(animated: true, completion: nil)
                            } else {
                                print("Error in creating HiddenGem: \(error)")
                            }
                        }
                        return
                    }
                }
                else{
                    print("Error in converting address to GeoCode: \(error)")
                }
                    
                
            }
    }
    
    
    
    @IBAction func cancelHiddenGem(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
