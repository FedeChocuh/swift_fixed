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
            Webservice().login(name: loginViewModel.name, password: loginViewModel.password) { result in
                switch result {
                case .success(let token):
                    // Set the JWT token in UserDefaults.
                    UserDefaults.standard.setValue(token, forKey: "jsonwebtoken")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }

            // Wait for the main queue to finish processing the login response.
            RunLoop.current.run(until: Date(timeIntervalSinceNow: 0.1))

            // Verify that the user is authenticated.
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

            Webservice().login(name: name, password: password) { result in
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
    
    /*
    
    class RegisterViewModelTests: XCTestCase {
        
        func testRegister() {
            // Configura tu implementación real del servicio web (Reemplaza YourWebServiceImplementation)
            let webService = Webservice() // Sustituye YourWebServiceImplementation con tu implementación real del servicio web
            
            // Crea una instancia de RegisterViewModel y proporciona la implementación del servicio web
            let viewModel = RegisterViewModel(webService: webService)
            
            // Configura datos de prueba en el ViewModel
            viewModel.name = "usuario_prueba"
            viewModel.password = "contraseña_prueba"
            viewModel.country_id = "123"
            viewModel.gender = "masculino"
            viewModel.age = 30
            viewModel.email = "test@example.com"
            viewModel.university_id = 456
            
            // Simula una respuesta exitosa del servicio web
            let expectedResponse: [String: Any] = ["status": "success", "message": "Registro exitoso"]
            
            // Mock del servicio web (puedes crear una versión de prueba del servicio)
            let mockWebService = MockWebService(response: .success(expectedResponse))
            
            // Asigna el servicio web mock al ViewModel
            viewModel.webService = mockWebService
            
            // Llama a la función Register() para iniciar el registro
            viewModel.Register()
            
            // Verifica que el valor se haya guardado correctamente en UserDefaults
            let savedValue = UserDefaults.standard.value(forKey: "../db") as? [String: Any]
            XCTAssertEqual(savedValue, expectedResponse)
            
            
        }
    }
    
    
*/
    
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
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    

}
