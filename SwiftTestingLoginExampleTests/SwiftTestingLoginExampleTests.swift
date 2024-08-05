//
//  SwiftTestingLoginExampleTests.swift
//  SwiftTestingLoginExampleTests
//
//  Created by Melisa Gülgün on 31.07.2024.
//

import Testing
@testable import SwiftTestingLoginExample

struct SwiftTestingLoginExampleTests {
    let viewModel: LoginViewModel?
    
    init() {
        self.viewModel = LoginViewModel()
    }
    
    @Test(
        "Check invalid emails", .tags(.emailValidation), .enabled(if: Constants.isTestEnabled),
        arguments:
            ["",
             "m@m..",
             "m.com",
             "*^+@m.com",
             "mel@mel.",
             "abc@@abc.com"
             ]
    )
    func check_Invalid_Emails(email: String) async throws {
        self.viewModel?.checkFormInputs(email: email, password: "")
        #expect(self.viewModel?.emailError != nil)
    }
    
    @Test(
        "Check invalid passwords", .tags(.passwordValidation), .disabled("Disabled because of the bug"),
        arguments:
            ["",
             "abc",
             "a",
             "ab"
             ]
    )
    func check_Invalid_Passwords(password: String) async throws {
        self.viewModel?.checkFormInputs(email: "", password: password)
        #expect(self.viewModel?.passwordError != nil)
    }

@Suite("Form Validations", .tags(.formValidation)) struct LoginFormValidationTests {
    let viewModel: LoginViewModel?
    
    init() {
        self.viewModel = LoginViewModel()
    }
    
    @Test(
        "Check isFormValid with valid inputs",
        arguments:
            ["mel@mel.com", "melisa@melisa.com.tr"], ["password", "abcd"]
    )
    func check_IsFormValid_With_Valid_Inputs(email: String, password: String) async throws {
        self.viewModel?.validateForm(email: email, password: password)
        #expect(self.viewModel?.isFormValid == true)
    }
    
    @Test(
        "Check isFormValid with invalid inputs",
        arguments:
            ["m@mel", "melisa@.com"], ["", "pas"]
    )
    func check_IsFormValid_With_InValid_Inputs(email: String, password: String) async throws {
        self.viewModel?.validateForm(email: email, password: password)
        #expect(self.viewModel?.isFormValid == false)
    }
    
    @Test(
        "Check invalid emails and valid passwords", .tags(.formValidation),
        arguments:
            zip(["m@m.c", "mel@."], ["password", "password"])
    )
    func check_Invalid_Emails_Valid_Passwords(email: String, password: String) async throws {
        self.viewModel?.checkFormInputs(email: email, password: password)
        try #require(self.viewModel?.emailError != nil)
        #expect(self.viewModel?.passwordError == nil)
    }
    
    @Test(
        "Check valid emails and invalid passwords", .tags(.formValidation),
        arguments:
            zip(["mel@mel.com", "melisa@melisa.com.tr"], ["", "pas"])
    )
    func check_Valid_Emails_Invalid_Passwords(email: String, password: String) async throws {
        self.viewModel?.checkFormInputs(email: email, password: password)
        #expect(self.viewModel?.emailError == nil)
        #expect(self.viewModel?.passwordError != nil)
    }
}
}
