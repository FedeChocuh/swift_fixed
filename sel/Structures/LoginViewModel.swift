//
//  LoginViewModel.swift
//  sel
//
//  Created by Fernando García on 28/09/23.
//

import XCTest

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
        XCTAssertTrue(loginViewModel.isAuthenticated)
    }
}
