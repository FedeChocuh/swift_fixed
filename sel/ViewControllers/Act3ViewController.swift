//
//  Act3ViewController.swift
//  sel
//
//  Created by José Andrés Rodríguez Ruiz on 07/10/23.
//

import UIKit

class Act3ViewController: UIViewController{
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let bulletPoint: String = "\u{2022}" // El carácter de viñeta
                
        let firstNormalText = "Antes de arrojarnos a proponer posibles soluciones, es importante que veamos que se hace al respecto en otros lugares. Para ello, te sugerimos que hagas una investigación sobre acciones concretas que se hacen internacional, nacional o localmente para atender el problema que elegiste."
        
        let firstListText = """
        \n\(bulletPoint) ¿Quién ha propuesto acciones para atender este problema -una empresa, una escuela, una persona, un gobierno, una asociación-?
        \(bulletPoint) ¿Qué se hace?
        \(bulletPoint) ¿Cómo ha mejorado estas acciones la vida de las personas?
        """
        
        let secondNormalText = "\n Reflexiona sobre el hecho de que innovar no siempre es la generación de algo único u original, sino que muchas ocasiones, el innovar puede ser una adaptación a un entorno, momento o grupo poblacional concreto. En ocasiones, lo que se hace en otro contexto puede resultar novedoso en nuestra localidad, lo que lo vuelve innovador. O también, puede haber acciones que se apliquen a cierta población, pero que también pueda ser valioso para otros grupos.\n\n Por ejemplo: Acciones para reducir la basura en las empresas que puedan adaptarse para las escuelas; o acciones que se lleven a cabo en Colombia que podrían adoptarse para la propia ciudad o colonia. \n\n Una vez reflexionado esto, analiza las acciones que identificaste en el punto anterior, cuestionando:"
        
        let secondListText = """
        \n\(bulletPoint) Si la solución que identificaste no es del lugar donde vives, ¿Se podría llevar a cabo en este?
        \(bulletPoint) Si la solución que identificaste es del lugar donde vives, ¿Se podría aplicar en otra ciudad o país?
        \(bulletPoint) ¿Quiénes más podrían adoptar la solución que identificaste? ¿Podría realizarse por tus profesores, tu familia o tus vecinos?
        \(bulletPoint) ¿Cómo podrías sumarte? ¿Qué necesitarías?
        \(bulletPoint) ¿Qué harías diferente? ¿Podrías mejorar algo?
        \(bulletPoint) ¿Por qué sería una propuesta innovadora?
        \(bulletPoint) ¿Qué nombre le pondrías a su propuesta de solución?
        """
        
        let thirdNormalText = "\n Como cierre de este proceso de ideación deberías poder identificar una acción concreta que pudieras adaptar, mejorar y proponer para resolver el problema elegido.."
        
        
        let fourthNormalText = "\n¿Qué debes entregar?"
        
        let fourthListText = """
        \n\(bulletPoint) Identificación de posibles soluciones internacionales, nacionales o locales
        \(bulletPoint) Reflexión sobre la manera en que podrías adoptar y adaptar alguna de estas posibles propuestas de solución, respondiendo a las preguntas sugeridas.
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
        
        let fourthNormalTextRange = NSRange(location: firstNormalText.count + firstListText.count + secondNormalText.count + secondListText.count + thirdNormalText.count, length: fourthNormalText.count)
        attributedText.addAttributes([.font: boldFont, .paragraphStyle: fourthParagraphStyle], range: fourthNormalTextRange)
        
        // Cambiar el tamaño de fuente para los textos en lista y ajustar el espacio antes
        let listFont = UIFont.systemFont(ofSize: 14.0) // Tamaño de fuente para el texto en viñetas
        
        let firstListTextRange = NSRange(location: firstNormalText.count, length: firstListText.count)
        attributedText.addAttributes([.font: listFont, .paragraphStyle: listParagraphStyle], range: firstListTextRange)
        
        let secondListTextRange = NSRange(location: firstNormalText.count + firstListText.count + secondNormalText.count, length: secondListText.count)
        attributedText.addAttributes([.font: listFont, .paragraphStyle: listParagraphStyle], range: secondListTextRange)
        
        let fourthListTextRange = NSRange(location: firstNormalText.count + firstListText.count + secondNormalText.count + secondListText.count + thirdNormalText.count , length: fourthListText.count)
        attributedText.addAttributes([.font: listFont, .paragraphStyle: listParagraphStyle], range: fourthListTextRange)
                        
        textView.attributedText = attributedText
    }
    
        

}


