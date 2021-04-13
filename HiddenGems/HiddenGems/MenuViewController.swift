//
//  MenuViewController.swift
//  HiddenGems
//
//  Created by Eduardo Barreto-Mendoza on 4/5/21.
//

import UIKit
import Parse

class MenuViewController: UIViewController {
    
    @IBAction func onBackMenu(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onLogout(_ sender: Any) {
        PFUser.logOut()
        let main = UIStoryboard(name: "Main", bundle: nil )
        let loginViewController = main.instantiateViewController(withIdentifier: "LoginViewController")
    
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            let delegate = windowScene.delegate as? SceneDelegate
          else {
            
            return
          }
        delegate.window?.rootViewController = loginViewController
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
