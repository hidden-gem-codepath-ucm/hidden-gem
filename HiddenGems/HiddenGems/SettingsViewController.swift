//
//  SettingsViewController.swift
//  HiddenGems
//
//  Created by Kenny Jung on 4/13/21.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var milesLabel: UILabel!
    
    @IBAction func onBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onSliide(_ sender: UISlider) {
        let value = sender.value
        milesLabel.text = "\(value)"
        
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
