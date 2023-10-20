//
//  ActividadesMain.swift
//  sel
//
//  Created by Fernando García on 08/10/23.
//

import UIKit




class ActividadesMain: UIViewController {
    
    
    @IBOutlet weak var viewAct1: UIView!
    @IBOutlet weak var buttonAct1: UIButton!
    
    @IBOutlet weak var viewAct2: UIView!
    @IBOutlet weak var buttonAct2: UIButton!
    
    @IBOutlet weak var viewAct3: UIView!
    @IBOutlet weak var buttonAct3: UIButton!
    
    @IBOutlet weak var viewAct4: UIView!
    @IBOutlet weak var buttonAct4: UIButton!
    
    @IBOutlet weak var viewFinal: UIView!
    @IBOutlet weak var buttonFinal: UIButton!
    
    @IBOutlet weak var ViewCierre: UIView!
    @IBOutlet weak var buttonCierre: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        estiloBotones()
        self.navigationItem.hidesBackButton = true
        updateActivityAccessBasedOnProgress()
        NotificationCenter.default.addObserver(self, selector: #selector(activityCompletedNotificationReceived(_:)), name: Notification.Name("ActivityCompletedNotification"), object: nil)
    }
    
    
    @objc func activityCompletedNotificationReceived(_ notification: Notification) {
        DispatchQueue.main.async {
            // Check which activity was completed from the notification's userInfo
            if let completedActivity = notification.userInfo?["completedActivity"] as? String {
                print("\(completedActivity) was completed!") // This line is optional, just for debugging
                self.updateActivityAccessBasedOnProgress()
            }
        }
    }


    
    func estiloBotones() {
        viewAct1.layer.cornerRadius = 15
        viewAct2.layer.cornerRadius = 15
        viewAct3.layer.cornerRadius = 15
        viewAct4.layer.cornerRadius = 15
        viewFinal.layer.cornerRadius = 15
        ViewCierre.layer.cornerRadius = 15
        
        buttonAct1.tintColor = UIColor(named: "azulTec")
        //buttonAct1.layer.cornerRadius = 25
        buttonAct1.clipsToBounds = true
        
        buttonAct2.tintColor = UIColor(named: "azulTec")
        //buttonAct2.layer.cornerRadius = 25
        buttonAct2.clipsToBounds = true
        
        buttonAct3.tintColor = UIColor(named: "azulTec")
        //buttonAct3.layer.cornerRadius = 25
        buttonAct3.clipsToBounds = true
        
        buttonAct4.tintColor = UIColor(named: "azulTec")
        //buttonAct4.layer.cornerRadius = 25
        buttonAct4.clipsToBounds = true
        
        buttonCierre.tintColor = UIColor(named: "azulTec")
        //buttonCierre.layer.cornerRadius = 25
        buttonCierre.clipsToBounds = true
        
        buttonFinal.tintColor = UIColor(named: "azulTec")
        //buttonFinal.layer.cornerRadius = 25
        buttonFinal.clipsToBounds = true
        
    }
    deinit {
        NotificationCenter.default.removeObserver(self, name: Notification.Name("ActivityCompletedNotification"), object: nil)
    }

    func updateActivityAccessBasedOnProgress() {
        let defaults = UserDefaults.standard
        
        // Check if Activity 1 is completed
        let isActivity1Completed = defaults.bool(forKey: "Activity1Completed")
        
        if isActivity1Completed {
            // If Activity 1 is completed, enable Activity 2
            viewAct2.alpha = 1.0
            buttonAct2.isEnabled = true
        } else {
            // If Activity 1 is NOT completed, disable Activity 2
            viewAct2.alpha = 0.5
            buttonAct2.isEnabled = false
        }
        
        // Similarly, add checks for other activities
        let isActivity2Completed = defaults.bool(forKey: "Activity2Completed")
        
        if isActivity2Completed {
            viewAct3.alpha = 1.0
            buttonAct3.isEnabled = true
        } else {
            viewAct3.alpha = 0.5
            buttonAct3.isEnabled = false
        }
        let isActivity3Completed = defaults.bool(forKey: "Activity3Completed")
        
        if isActivity3Completed {
            viewAct4.alpha = 1.0
            buttonAct4.isEnabled = true
        } else {
            viewAct4.alpha = 0.5
            buttonAct4.isEnabled = false
        }
        let isActivity4Completed = defaults.bool(forKey: "Activity4Completed")
        
        if isActivity4Completed {
            ViewCierre.alpha = 1.0
            buttonCierre.isEnabled = true
        } else {
            ViewCierre.alpha = 0.5
            buttonCierre.isEnabled = false
        }
        let isActivity5Completed = defaults.bool(forKey: "Activity5Completed")
        
        if isActivity5Completed {
            viewFinal.alpha = 1.0
            buttonFinal.isEnabled = true
        } else {
            viewFinal.alpha = 0.5
            buttonFinal.isEnabled = false
        }
        
        
        
    }
}
