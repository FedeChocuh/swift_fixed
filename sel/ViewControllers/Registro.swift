//
//  Registro.swift
//  sel
//
//  Created by Fernando García on 26/09/23.
//

import UIKit
class CellClass: UITableViewCell {
    
}


class ViewRegistro: UIViewController, UITableViewDelegate, UITableViewDataSource {
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
    
    
    
    @IBOutlet weak var buttonCheck: UIButton!
    
    @IBOutlet weak var buttonRegistrarme: UIButton!
    
    
    @IBOutlet weak var layerNombre: UITextField!
    
    @IBOutlet weak var layerPais: UITextField!
    
    @IBOutlet weak var layerGenero: UIButton!
    
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
        layerEdad.layer.borderColor = UIColor.black.cgColor
        
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
    
    func addTransparentView(frames:CGRect){
        let window = UIApplication.shared.keyWindow
        transparentView.frame = window?.frame ?? self.view.frame
        self.view.addSubview(transparentView)
        
        tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
        self.view.addSubview(tableView)
        tableView.layer.cornerRadius = 5
        
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        tableView.reloadData()
        
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(removeTransparentView))
        transparentView.addGestureRecognizer(tapgesture)
        
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0,initialSpringVelocity: 1.0 ,options: .curveEaseInOut ,animations: {
            self.transparentView.alpha = 0.5
            self.tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height + 5, width: frames.width, height: CGFloat(self.dataSource.count * 50))
        }, completion: nil)
    }
    
    @objc func removeTransparentView(){
        let frames = selectedButton.frame
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0,initialSpringVelocity: 1.0 ,options: .curveEaseInOut ,animations: {
            self.transparentView.alpha = 0
            self.tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 200)
        }, completion: nil)
    }
    
    @IBAction func onClickGender(_ sender: Any) {
        dataSource = ["Masculino", "Femenino","No-binario", "Otro", "Prefiero-no-contestar"]
        selectedButton = layerGenero
        addTransparentView(frames: layerGenero.frame)
    }
    

    
    
    @IBAction func AlreadyRegistered(_ sender: UIButton) {
        guard
               let username = layerNombre.text,
               let password = layerPassword.text,
               let country = layerPais.text,
               let ageText = layerEdad.text,
                let age = Int(ageText),
               let email = layerEmail.text,
               let gender = layerGenero.title(for: .normal) ?? "",
               let universidad = layerUniversidad.text
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
               university: universidad
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
