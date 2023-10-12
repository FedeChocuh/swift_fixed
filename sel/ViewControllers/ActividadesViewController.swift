//
//  ActividadesViewController.swift
//  sel
//
//  Created by José Andrés Rodríguez Ruiz on 04/10/23.
//

import UIKit



class ActividadesViewController: UIViewController, UIDocumentPickerDelegate {
    
    var actId: String = "1"
    let defaults = UserDefaults.standard
    var userId: String {
        return String(defaults.integer(forKey: "user_id"))
    }
    @IBOutlet var viewBg: UIView!
    @IBOutlet weak var textView1: UITextView!

    
    
    
    @IBAction func startUp(_ sender: Any) {
        selectFile()
    }


    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FileTransferUtility.shared.checkFileExists(userId: userId, activityId: actId) { result in
                switch result {
                case .success(let fileExists):
                    if fileExists {
                        self.downloadAndDisplayFile()
                    } else {
                        self.showUploadOption()
                    }
                case .failure(let error):
                    print("Error checking file existence: \(error)")
                }
            }
        
        viewBg.backgroundColor = UIColor(named: "azulTec")
        
        let bulletPoint: String = "\u{2022}" // El carácter de viñeta
                
        let firstNormalText = "1.Haz una lluvia de ideas sobre problemas sociales o ambientales que se dan en tu entorno."
        
        let firstListText = """
        \n\(bulletPoint) ¿Cuáles identificas?
        \(bulletPoint) Mínimo deben poder identificar 5 problemáticas.
        \(bulletPoint) ¿Cómo te afectan estos problemas? ¿Has escuchado que le afecten a alguien cercano?
        \(bulletPoint) ¿Por qué se consideran un problema?
        """
        
        let secondNormalText = "\n 2.-Ahora, entrevista a una persona respecto a la misma idea:"
        
        let secondListText = """
        \n\(bulletPoint) ¿Qué problemas ambientales o sociales identificas en tu casa, colonia o ciudad o país?
        \(bulletPoint) ¿Por qué son un problema?
        \(bulletPoint) ¿Quiénes intervienen en el problema?
        \(bulletPoint) ¿Te has visto afectado por este problema? ¿Cómo?
        """
        
        let thirdNormalText = "\n3.Por último, has un recorrido por tu colonia o ciudad y registra lo que ves relacionado con la situación ambiental o social. Busca identificar situaciones que no te agraden o problemas ya identificados."
        
        let thirdListText = """
        \n\(bulletPoint) ¿Que viste?
        \(bulletPoint) ¿Dónde lo viste?
        \(bulletPoint) ¿Había alguien ocasionándolo o atendiéndolo?
        """
        
        let fourthNormalText = "\n¿Qué debes entregar?"
        
        let fourthListText = """
        \n\(bulletPoint) Conclusión de la reflexión inicial
        \(bulletPoint) Conclusión de la entrevista
        \(bulletPoint) Tabla con el registro de lo observado
        """
        
        let fullText = "\(firstNormalText)\(firstListText)\(secondNormalText)\(secondListText)\(thirdNormalText)\(thirdListText)\(fourthNormalText)\(fourthListText)"
        
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
        
        let fourthNormalTextRange = NSRange(location: firstNormalText.count + firstListText.count + secondNormalText.count + secondListText.count + thirdNormalText.count + thirdListText.count, length: fourthNormalText.count)
        attributedText.addAttributes([.font: boldFont, .paragraphStyle: fourthParagraphStyle], range: fourthNormalTextRange)
        
        // Cambiar el tamaño de fuente para los textos en lista y ajustar el espacio antes
        let listFont = UIFont.systemFont(ofSize: 14.0) // Tamaño de fuente para el texto en viñetas
        
        let firstListTextRange = NSRange(location: firstNormalText.count, length: firstListText.count)
        attributedText.addAttributes([.font: listFont, .paragraphStyle: listParagraphStyle], range: firstListTextRange)
        
        let secondListTextRange = NSRange(location: firstNormalText.count + firstListText.count + secondNormalText.count, length: secondListText.count)
        attributedText.addAttributes([.font: listFont, .paragraphStyle: listParagraphStyle], range: secondListTextRange)
        
        let thirdListTextRange = NSRange(location: firstNormalText.count + firstListText.count + secondNormalText.count + secondListText.count + thirdNormalText.count, length: thirdListText.count)
        attributedText.addAttributes([.font: listFont, .paragraphStyle: listParagraphStyle], range: thirdListTextRange)
        
        let fourthListTextRange = NSRange(location: firstNormalText.count + firstListText.count + secondNormalText.count + secondListText.count + thirdNormalText.count + thirdListText.count, length: fourthListText.count)
        attributedText.addAttributes([.font: listFont, .paragraphStyle: listParagraphStyle], range: fourthListTextRange)
                        
        textView1.attributedText = attributedText
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

        FileTransferUtility.shared.uploadFile(userId: userId, activityId: actId, fileURL: selectedFileURL) { result in
            switch result {
            case .success():
                print("File uploaded successfully")
                self.downloadAndDisplayFile()
            case .failure(let error):
                print("Error uploading file: \(error)")
            }
        }
    }


            // Here, you can handle the selected file (e.g., upload it to a server, process it, etc.)
            // selectedFileURL contains the URL of the selected file.

        func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
            // This function is called when the user cancels the file selection.
        }


    func downloadAndDisplayFile() {
        FileTransferUtility.shared.downloadFile(userId: userId, activityId: actId) { result in
            switch result {
            case .success(let fileURL):
                // Display the file using fileURL
                print("File downloaded: \(fileURL)")
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
