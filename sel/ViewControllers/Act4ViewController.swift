//
//  Act4ViewController.swift
//  sel
//
//  Created by José Andrés Rodríguez Ruiz on 07/10/23.
//

import UIKit

class Act4ViewController: UIViewController, UIDocumentPickerDelegate{
    
    var actId: String = "4"
    let defaults = UserDefaults.standard
    var userId: String {
        return String(defaults.integer(forKey: "user_id"))
    }
    
    @IBOutlet var viewBg: UIView!
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var imagenact: UIImageView!
    
    @IBAction func startUp(_ sender: Any) {
        selectFile()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewBg.backgroundColor = UIColor(named: "azulTec")
        
        let bulletPoint: String = "\u{2022}" // El carácter de viñeta
                
        let firstNormalText = "Una habilidad relevante de cualquier emprendedor social es que pueda comunicar su propuesta para sumar a más personas a la acción. Por ende, esta actividad tiene el objetivo de recibir retroalimentación de otras personas sobre la propuesta. \n\n Debes identificar a 1 persona que pudiera dar retroalimentación sobre la propuesta de solución. Puede sugerirse un familiar, vecino, profesor o alguien cercano. De preferencia busca a alguien que pudiera ser un posible usuario de tu propuesta de solución.\n\n Para realizar esta entrevista, se debe tener claridad de lo que se compartirá por lo que se sugiere que antes de reunirte con esta persona, tengas claro los siguientes puntos:"
        
        let firstListText = """
        \n\(bulletPoint) Nombre de la propuesta de solución
        \(bulletPoint) Problema que atiende
        \(bulletPoint) Lugar o personas que se ven actualmente afectadas por el problema en lo local
        \(bulletPoint) Acción concreta que se propone
        \(bulletPoint) Por qué es innovadora
        \(bulletPoint) Quienes podrían sumarse a esta propuesta
        """
        
        let secondNormalText = "\n Una vez se tenga esta información, se puede realizar la entrevista. Se sugiere que primero se presente la propuesta considerando los puntos anteriormente desarrollados. Después, será necesario detonar algunas preguntas para recibir retroalimentación:"
        
        let secondListText = """
        \n\(bulletPoint) ¿Consideras que es una propuesta viable, es decir, que si puede realizarse?
        \(bulletPoint) ¿Consideras que es una propuesta valiosa, es decir, que puede impactar positivamente en donde vivimos?
        \(bulletPoint) ¿Te podrías sumar a la propuesta? ¿Cómo lo harías?
        \(bulletPoint) ¿Qué sugerirías para que la propuesta fuera más viable, aplicable o tuviera un mayor impacto?
        """
        
        let thirdNormalText = "\n3 Deberás recabar esta información de tu entrevistado y hacer adecuaciones a tu propuesta en caso de haber tenido alguna retroalimentación valiosa."
        
        let fourthNormalText = "\n¿Qué debes entregar?"
        
        let fourthListText = """
        \n\(bulletPoint) Video, Audio o Transcripción de las entrevistas
        \(bulletPoint) Reflexión sobre la retroalimentación recibida
        """
        
        let fullText = "\(firstNormalText)\(firstListText)\(secondNormalText)\(secondListText)\(thirdNormalText)\(fourthNormalText)\(fourthListText)"
        
        let attributedText = NSMutableAttributedString(string: fullText)
        
        // Estilo de párrafo para el primer texto normal con espacio después
        let firstParagraphStyle = NSMutableParagraphStyle()
        firstParagraphStyle.alignment = .left
        firstParagraphStyle.firstLineHeadIndent = 10.0 // Espaciado para la viñeta
        firstParagraphStyle.paragraphSpacing = 20.0 // Espaciado después del firstNormalText
        
        // Estilo de párrafo para el segundo texto normal con espacio después
        let secondParagraphStyle = NSMutableParagraphStyle()
        secondParagraphStyle.alignment = .left
        secondParagraphStyle.firstLineHeadIndent = 10.0 // Espaciado para la viñeta
        secondParagraphStyle.paragraphSpacing = 20.0 // Espaciado después del secondNormalText
        
        // Estilo de párrafo para el tercer texto normal con espacio después
        let thirdParagraphStyle = NSMutableParagraphStyle()
        thirdParagraphStyle.alignment = .left
        thirdParagraphStyle.firstLineHeadIndent = 10.0 // Espaciado para la viñeta
        thirdParagraphStyle.paragraphSpacing = 20.0 // Espaciado después del thirdNormalText
        
        // Estilo de párrafo para el cuarto texto normal
        let fourthParagraphStyle = NSMutableParagraphStyle()
        fourthParagraphStyle.alignment = .left
        fourthParagraphStyle.firstLineHeadIndent = 10.0 // Espaciado para la viñeta
        fourthParagraphStyle.paragraphSpacing = 20.0 // Espaciado después del thirdNormalText

        
        // Estilo de párrafo para los textos en lista
        let listParagraphStyle = NSMutableParagraphStyle()
        listParagraphStyle.alignment = .left
        listParagraphStyle.firstLineHeadIndent = 10.0 // Espaciado para la viñeta
        
        // Aplicar negrita a todos los textos normales
        let boldFont = UIFont.boldSystemFont(ofSize: 17.0) // Tamaño de fuente en negrita para el texto normal
        
        let firstNormalTextRange = NSRange(location: 0, length: firstNormalText.count)
        attributedText.addAttributes([.font: boldFont, .paragraphStyle: firstParagraphStyle], range: firstNormalTextRange)
        
        let secondNormalTextRange = NSRange(location: firstNormalText.count + firstListText.count, length: secondNormalText.count)
        attributedText.addAttributes([.font: boldFont, .paragraphStyle: secondParagraphStyle], range: secondNormalTextRange)
        
        let thirdNormalTextRange = NSRange(location: firstNormalText.count + firstListText.count + secondNormalText.count + secondListText.count, length: thirdNormalText.count)
        attributedText.addAttributes([.font: boldFont, .paragraphStyle: thirdParagraphStyle], range: thirdNormalTextRange)
        
        let fourthNormalTextRange = NSRange(location: firstNormalText.count + firstListText.count + secondNormalText.count + secondListText.count + thirdNormalText.count , length: fourthNormalText.count)
        attributedText.addAttributes([.font: boldFont, .paragraphStyle: fourthParagraphStyle], range: fourthNormalTextRange)
        
        // Cambiar el tamaño de fuente para los textos en lista y ajustar el espacio antes
        let listFont = UIFont.systemFont(ofSize: 14.0) // Tamaño de fuente para el texto en viñetas
        
        let firstListTextRange = NSRange(location: firstNormalText.count, length: firstListText.count)
        attributedText.addAttributes([.font: listFont, .paragraphStyle: listParagraphStyle], range: firstListTextRange)
        
        let secondListTextRange = NSRange(location: firstNormalText.count + firstListText.count + secondNormalText.count, length: secondListText.count)
        attributedText.addAttributes([.font: listFont, .paragraphStyle: listParagraphStyle], range: secondListTextRange)
        
        let fourthListTextRange = NSRange(location: firstNormalText.count + firstListText.count + secondNormalText.count + secondListText.count + thirdNormalText.count, length: fourthListText.count)
        attributedText.addAttributes([.font: listFont, .paragraphStyle: listParagraphStyle], range: fourthListTextRange)
                        
        textView.attributedText = attributedText
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
                    defaults.set(true, forKey: "Activity4Completed")
                    let userInfo = ["completedActivity": "Activity4"]
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


