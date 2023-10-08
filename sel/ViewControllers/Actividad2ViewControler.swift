//
//  Actividad2ViewControler.swift
//  sel
//
//  Created by José Andrés Rodríguez Ruiz on 07/10/23.
//

import UIKit

class Actividad2ViewControler: UIViewController{
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bulletPoint: String = "\u{2022}" // El carácter de viñeta
                
        let firstNormalText = "1.  Reflexiona acerca de los problemas que identificaste en la Actividad 1. Teniéndolos en mente, haz una investigación sobre los Objetivos de Desarrollo Sostenible. Te sugerimos los siguientes enlaces:"
        
        let firstListText = """
        \n\(bulletPoint) <a href="https://www.youtube.com/watch?v=MCKH5xk8X-g">Vínculo a Youtube?</a>
        \(bulletPoint) <a href="https://www.undp.org/es/sustainable-development-goals"> Vínculo a UNDP </a>
        """
        
        let secondNormalText = "\n Revisa cada uno de los objetivos y sus metas e investiga como es que estos se relacionan con los problemas que identificaste."
        
        let secondListText = """
        \n\(bulletPoint) ¿Cuál es el ODS que consideras se relaciona mejor con cada problematica?
        \(bulletPoint) ¿Cómo se relaciona con estos temas?
        \(bulletPoint) ¿Hay alguna meta de dicho ODS que de manera concreta hable de esta relación?
        """
        

        let thirdNormalText = "\n2.Los ODS nos permiten comprender como es que estas problemáticas son consideradas Retos y Desafíos para todo el Mundo, sin embargo, es importante que podamos conocer cuál es la situación actual. Como segunda parte de esta actividad, te pedimos que de las 5 problemáticas identificadas en la actividad 1, elijas 3 y realices una investigación que responda las siguientes preguntas:"
        
        let thirdListText = """
        \n\(bulletPoint) ¿Cuál es la situación de estas problemáticas a nivel internacional, regional, nacional y local?
        \(bulletPoint) ¿Hay registro de afectaciones en la vida de las personas?
        \(bulletPoint) ¿Qué tanto afecta a tu localidad?
        """
        
        
        let fourthNormalText = "\n¿Con esta investigación, reflexiona sobre cuál es la problemática que consideras valioso atender. Debes conseguir elegir 1, para apoyarte en este proceso de elección, te sugerimos considerar:"

        let fourthListText = """
        \n\(bulletPoint) Que sea un problema que afecte directamente a tu entorno
        \(bulletPoint) Que tenga un impacto en la calidad de vida de las personas
        \(bulletPoint) Que sea una problemática cercana a nosotros o a alguien que conozcamos
        """
        
        let fifthNormalText = "\n 3.  Como último punto de esta actividad, y habiendo elegido 1 problemática, es necesario que hagas un Árbol de Causas y Consecuencias."
       
        let sixthNormalText = "\n Los problemas suelen ser como árboles, con causas que se enraízan en la sociedad y con ramas y hojas que se dividen en múltiples consecuencias que afectan a muchas personas, realidades y entornos. Tomemos de ejemplo la contaminación, la cual puede tener múltiples causas, y sus consecuencias pueden impactar tanto al medioambiente, como a las personas, el clima, la economía, el desarrollo de las ciudades, la salud, etc. Para poder hacer algo al respecto, es importante poder identificar qué es lo que está detonando los problemas, ya que solo así se podrán atender posibles consecuencias. \n Una vez hecha esta reflexión, haz una investigación que considere por lo menos 3 posibles causas del problema seleccionado, así como 5 posibles consecuencias. Es relevante que se tomes en cuenta sus consecuencias en el entorno, la sociedad, las personas, la economía u cualquier otra área de abordaje.\n Aunque se sugiere que la investigación sea documental, también es posible que te apoyes con entrevistas a especialistas, profesores, familiares o conocedores del tema. \n Una vez se haya hecho esta investigación, podrás hacer tu árbol de causas y consecuencias. El tronco del árbol es el problema seleccionado; las raíces son las causas; las ramas y hojas son las consecuencias. Puedes dividir las consecuencias por su impacto internacional, nacional y local. \n Se sugiere que esta representación sea gráfica y con base en las herramientas propias que tengas. \n\n En la parte inferior del árbol se sugiere respondas lo siguiente:"
        
        let fifthListText = """
        \n\(bulletPoint) A partir de esta información, ¿Por qué es importante atender este problema?
        """
        
        
        let seventhNormalText = "\n¿Qué debes entregar?"
        
        let seventhListText = """
        \n\(bulletPoint) Relación entre ODS y problemas ambientales
        \(bulletPoint) Investigación sobre la situación internacional, nacional y local de las problemáticas
        \(bulletPoint) Árbol de causas y consecuencias del problema seleccionado
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
                        
        textView.attributedText = attributedText
    }
}

