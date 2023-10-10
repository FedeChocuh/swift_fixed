//
//  Registro.swift
//  sel
//
//  Created by Fernando García on 26/09/23.
//

import UIKit
class CellClass: UITableViewCell {
    
}

struct Country {
    let country_id: String
    let name: String
}

class ViewRegistro: UIViewController, UITableViewDelegate, UITableViewDataSource,UIPickerViewDataSource, UIPickerViewDelegate {
    var countries = [Country]()  // New: Array to hold country data
    let countryPickerView = UIPickerView()  // New: Country picker view
    let genderPickerView = UIPickerView()
    let genderOptions = ["Masculino", "Femenino","No-binario", "Otro", "Prefiero no contestar"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == genderPickerView {
            return genderOptions.count
        } else if pickerView == countryPickerView {
            return countries.count
        }
        return 0
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == genderPickerView {
            return genderOptions[row]
        } else if pickerView == countryPickerView {
            return countries[row].name
        }
        return nil
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == genderPickerView {
            layerGenero.text = genderOptions[row]
        } else if pickerView == countryPickerView {
            layerPais.text = countries[row].name
        }
    }
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = dataSource[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func fetchCountries() {
            guard let url = URL(string: "http://localhost:3001/countries") else {
                print("Invalid URL")
                return
            }
            let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                guard let data = data, error == nil else {
                    print("Failed to fetch countries:", error ?? "Unknown error")
                    return
                }
                do {
                    if let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                       let countryArray = jsonObject["countries"] as? [[String: String]] {
                        self?.countries = countryArray.map { Country(country_id: $0["country_id"]!, name: $0["name"]!) }
                        DispatchQueue.main.async {
                            self?.countryPickerView.reloadAllComponents()
                        }
                    }
                } catch {
                    print("Failed to decode countries:", error)
                }
            }
            task.resume()
        }
    
    
    @IBOutlet weak var layerGenero: UITextField!
    
    @IBOutlet weak var buttonCheck: UIButton!
    
    @IBOutlet weak var buttonRegistrarme: UIButton!
    
    @IBOutlet weak var layerNombre: UITextField!
    
    @IBOutlet weak var layerPais: UITextField!
        
    @IBOutlet weak var layerEdad: UITextField!
    
    @IBOutlet weak var layerEmail: UITextField!
    
    @IBOutlet weak var layerPassword: UITextField!
    
    @IBOutlet weak var TerminosYCondiciones: UITextView!
    
    
    @IBOutlet weak var layerUniversidad: UITextField!
    private var registerVM = RegisterViewModel()
    
    let transparentView = UIView()
    let tableView = UITableView()
    var selectedButton = UIButton()
    var dataSource = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        estiloBotones()
        
        //Link para los terminos y condiciones
        TerminosYCondiciones.dataDetectorTypes = .link
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openLink))
        TerminosYCondiciones.addGestureRecognizer(tapGesture)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CellClass.self, forCellReuseIdentifier: "Cell")
        genderPickerView.delegate = self
            genderPickerView.dataSource = self
            layerGenero.inputView = genderPickerView
        fetchCountries()
            countryPickerView.delegate = self  // New: Configure country picker view
            countryPickerView.dataSource = self
            layerPais.inputView = countryPickerView
    }
    
    func estiloBotones(){
        buttonRegistrarme.tintColor = UIColor(named: "azulTec")
        buttonRegistrarme.layer.cornerRadius = 25
        buttonRegistrarme.clipsToBounds = true
        
        layerNombre.layer.cornerRadius = 25
        layerNombre.layer.borderWidth = 1
        layerNombre.layer.borderColor = UIColor.black.cgColor
        
        layerPais.layer.cornerRadius = 25
        layerPais.layer.borderWidth = 1
        layerPais.layer.borderColor = UIColor.black.cgColor
        
        layerPassword.layer.cornerRadius = 25
        layerPassword.layer.borderWidth = 1
        layerPassword.layer.borderColor = UIColor.black.cgColor
        
        layerEdad.layer.cornerRadius = 25
        layerEdad.layer.borderWidth = 1
        layerGenero.layer.cornerRadius = 25
        layerGenero.layer.borderWidth = 1
        layerGenero.layer.borderColor = UIColor.black.cgColor

        layerUniversidad.layer.cornerRadius = 25
        layerUniversidad.layer.borderWidth = 1
        layerUniversidad.layer.borderColor = UIColor.black.cgColor
        
        layerEmail.layer.cornerRadius = 25
        layerEmail.layer.borderWidth = 1
        layerEmail.layer.borderColor = UIColor.black.cgColor
        
    }
    
    @objc func openLink(sender: UITapGestureRecognizer) {
        if let url = URL(string: "https://tec.mx/es/aviso-de-privacidad-sel4c") {
            UIApplication.shared.open(url, options: [:],completionHandler: nil)
        }
    }
    
    var unchecked = true
    
    @IBAction func Terms(_ sender: UIButton) {
        if unchecked {
            buttonCheck.setImage(UIImage(named: "checkmark.square"), for: .normal)
            unchecked = false
        } else {
            buttonCheck.setImage(UIImage(named: "chemark.square.fill"), for: .normal)
            unchecked = true
            
        }
    }
    @IBAction func AlreadyRegistered(_ sender: UIButton) {
        guard
            let username = layerNombre.text,
            let password = layerPassword.text,
            let country = layerPais.text,
            let ageText = layerEdad.text,
            let age = Int(ageText),
            let email = layerEmail.text,
            let gender = layerGenero.text,
            let universidadText = layerUniversidad.text,
            let universidad = Int(universidadText)
        else {
            return
        }

         print(username,password,country,age,email,gender)
         let webService = Webservice()
         
         webService.register(
             name: username,
             password: password,
             country_id: country,
             gender: gender ,
             age: age,
             email: email,
             university_id: universidad
         ) { [weak self] result in
             DispatchQueue.main.async {
                 switch result {
                 case .success(let values):
                     self!.unchecked = false
                     print("Registration successful: \(values)")
                     self?.performSegue(withIdentifier: "AccessToPreTest", sender: self)
                 case .failure(let error):
                     self!.unchecked = true
                     print("Registration failed: \(error)")
                 }
             }
         }
     }
 }
