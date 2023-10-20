//
//  viewPitch.swift
//  sel
//
//  Created by Fernando García on 20/10/23.
//

import Foundation
import UIKit

class viewPitch: UIViewController,UIDocumentPickerDelegate {
    var actId: String = "5"
    let defaults = UserDefaults.standard
    var userId: String {
        return String(defaults.integer(forKey: "user_id"))
    }
    
    @IBOutlet weak var viewBlanca: UIView!
    
    @IBOutlet weak var imagenact: UIImageView!
    
    @IBOutlet weak var subirarchivo: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        estiloBotones()
        downloadAndDisplayFile()
        
    }
    
    func estiloBotones(){
        viewBlanca.layer.cornerRadius = 15
        
        subirarchivo.tintColor = UIColor(named: "azulTec")
        subirarchivo.layer.cornerRadius = 25
        subirarchivo.clipsToBounds = true
        

    }
    
    
    func selectFile() {
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.data])
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false // Change to true if you want to allow multiple file selection
        
        present(documentPicker, animated: true, completion: nil)
    }
    
    //extension ActividadesViewController: UIDocumentPickerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let selectedFileURL = urls.first else {
            return
        }

        FileTransferUtility.shared.uploadFile(url: selectedFileURL, userId: userId, activityId: actId) { result in
            switch result {
            case .success():
                print("File uploaded successfully")
                self.downloadAndDisplayFile()
            case .failure(let error):
                print("Error uploading file: \(error)")
            }
        }
    }


     
        func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        }


    func downloadAndDisplayFile() {
        FileTransferUtility.shared.downloadFile(userId: userId, activityId: actId) { result in
            switch result {
            case .success(let fileURL):
                // Load the image from the file URL
                if let data = try? Data(contentsOf: fileURL), let image = UIImage(data: data) {
                    // Update UI on the main thread
                    DispatchQueue.main.async {
                        self.imagenact.image = image
                    }
                    let defaults = UserDefaults.standard
                    defaults.set(true, forKey: "Activity1Completed")
                    let userInfo = ["completedActivity": "Activity1"]
                    NotificationCenter.default.post(name: Notification.Name("ActivityCompletedNotification"), object: nil, userInfo: userInfo)
                } else {
                    print("Failed to load image from \(fileURL)")
                }
            case .failure(let error):
                print("Error downloading file: \(error)")
            }
        }
    }

    func showUploadOption() {
        let alert = UIAlertController(title: "Upload File", message: "No file found for this activity. Would you like to upload one?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Upload", style: .default) { _ in
            self.selectFile()
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
}

