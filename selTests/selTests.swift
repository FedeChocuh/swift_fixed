//
//  selTests.swift
//  selTests
//
//  Created by Fernando García on 31/08/23.
//
import Foundation
import XCTest
@testable import sel
//@testable import WebServiceProtocol





final class selTests: XCTestCase {

    //test checar loging
    class LoginViewModelTests: XCTestCase {

        func testLogin() {
            let loginViewModel = LoginViewModel()
            loginViewModel.name = "test"
            loginViewModel.password = "password"

            // Simulate a successful login response from the webservice.
            Webservice().login(email: loginViewModel.name, password: loginViewModel.password) { result in
                switch result {
                case .success(let token):
                    // Set the JWT token in UserDefaults.
                    UserDefaults.standard.setValue(token, forKey: "jsonwebtoken")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }

            RunLoop.current.run(until: Date(timeIntervalSinceNow: 0.1))

            XCTAssertEqual(loginViewModel.isAuthenticated, true)
        }
    }

    // Define the LoginViewModel class in the same file as the test class.
    class LoginViewModel {
        var name: String = ""
        var password: String = ""
        @Published var isAuthenticated: Bool = false

        func Login() {

            let defaults = UserDefaults.standard

            Webservice().login(email: name, password: password) { result in
                switch result {
                case .success(let token):
                    defaults.setValue(token, forKey: "jsonwebtoken")
                    DispatchQueue.main.async {
                        self.isAuthenticated = true
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    //Login negativo
    class LoginViewNegModelTests: XCTestCase {

        func testLoginNeg() {
            let loginViewModel = LoginViewModel()
            loginViewModel.name = "testNeg"
            loginViewModel.password = "passwordNeg"

            // Simulate a successful login response from the webservice.
            Webservice().login(email: loginViewModel.name, password: loginViewModel.password) { result in
                switch result {
                case .success(let token):
                    // Set the JWT token in UserDefaults.
                    UserDefaults.standard.setValue(token, forKey: "jsonwebtoken")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }

            RunLoop.current.run(until: Date(timeIntervalSinceNow: 0.1))

            XCTAssertEqual(loginViewModel.isAuthenticated, false)
        }
    }

    class LoginNegViewModel {
        var name: String = ""
        var password: String = ""
        @Published var isAuthenticated: Bool = false

        func Login() {

            let defaults = UserDefaults.standard

            Webservice().login(email: name, password: password) { result in
                switch result {
                case .success(let token):
                    defaults.setValue(token, forKey: "jsonwebtoken")
                    DispatchQueue.main.async {
                        self.isAuthenticated = true
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
  
    class ViewRegistroTests: XCTestCase {
        var viewRegistro: ViewRegistro!
        
        override func setUp() {
            super.setUp()
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            viewRegistro = storyboard.instantiateViewController(withIdentifier: "ViewRegistro") as? ViewRegistro
            
            viewRegistro.loadView()
            viewRegistro.viewDidLoad()
            viewRegistro.viewWillAppear(false)
        }
        
        override func tearDown() {
            viewRegistro = nil
            super.tearDown()
        }


        func testTermsButton() {
            XCTAssertTrue(viewRegistro.unchecked)
            
            viewRegistro.Terms(UIButton())
            
            XCTAssertFalse(viewRegistro.unchecked)
        }

        func testRegistrationWithValidData() {
            // Establece datos de prueba
            viewRegistro.layerNombre.text = "UsuarioPrueba"
            viewRegistro.layerPassword.text = "ContraseñaPrueba"
            viewRegistro.layerPais.text = "México"
            viewRegistro.layerEdad.text = "25"
            viewRegistro.layerEmail.text = "correo@ejemplo.com"
            viewRegistro.layerGenero.text = "Masculino"
            viewRegistro.layerUniversidad.text = "123"

            viewRegistro.AlreadyRegistered(UIButton())


        }


    }
    
    class ViewPerfilTests: XCTestCase {
        var viewPerfil: ViewPerfil!

        override func setUp() {
            super.setUp()

            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            viewPerfil = storyboard.instantiateViewController(withIdentifier: "ViewPerfil") as? ViewPerfil

            viewPerfil.loadView()
            viewPerfil.viewDidLoad()
        }

        override func tearDown() {
            viewPerfil = nil
            super.tearDown()
        }


        func testLogoutButtonTapped() {
            UserDefaults.standard.set("jwtToken", forKey: "jsonwebtoken")

            XCTAssertEqual(UserDefaults.standard.string(forKey: "jsonwebtoken"), "jwtToken")

            viewPerfil.logoutButtonTapped(UIButton())

            XCTAssertNil(UserDefaults.standard.string(forKey: "jsonwebtoken"))
        }

        func testButtonStyle() {
            viewPerfil.estiloBotones()

        }

        func testShowLabelData() {
            UserDefaults.standard.set("UsuarioPrueba", forKey: "UsernameKey")

            viewPerfil.showLabelData()

            XCTAssertEqual(viewPerfil.labelNombre.text, "UsuarioPrueba")

            UserDefaults.standard.removeObject(forKey: "UsernameKey")
        }
    }
 
    
    // Mock del servicio web para pruebas
    class MockWebService: Webservice{
        var response: Result<[String: Any], Error>
        
        init(response: Result<[String: Any], Error>) {
            self.response = response
        }
        
        func register(name: String, password: String, country_id: String, gender: String, age: Int, email: String, university_id: Int, completion: @escaping (Result<[String: Any], Error>) -> Void) {
            completion(response)
        }
        

    }

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {

    }

    func testPerformanceExample() throws {
        self.measure {
        }
    }
    
    

}
