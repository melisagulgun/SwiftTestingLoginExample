//
//  LoginViewModel.swift
//  SwiftTestingLoginExample
//
//  Created by Melisa Gülgün on 3.08.2024.
//

import SwiftUI
import RegexBuilder

class LoginViewModel: ObservableObject {
    @Published var emailError: String? = nil
    @Published var passwordError: String? = nil
    @Published var isFormValid: Bool = false
    
    func validateForm(email: String, password: String) {
        let emailError = validateEmail(emailText: email)
        let passwordError = validatePassword(passwordText: password)
        self.isFormValid = ((emailError ?? "").isEmpty) && ((passwordError ?? "").isEmpty)
    }
    
    func checkFormInputs(email: String, password: String) {
        self.emailError = validateEmail(emailText: email)
        self.passwordError = validatePassword(passwordText: password)
    }
    
    private func validateEmail(emailText: String) -> String? {
        if emailText.isEmpty {
            return Constants.emptyMailError
        }
        if !chcekEmailIsValid(email: emailText) {
            return Constants.emptyMalformattedError
        }
        return nil
    }
    
    private func chcekEmailIsValid(email: String) -> Bool {
        let emailRegex = Regex {
            Anchor.startOfLine
            Repeat(3...) {
                CharacterClass(
                    .word,
                    .anyOf("._-")
                )
            }
            One("@")
            OneOrMore {
                CharacterClass(
                    .word
                )
            }
            One(".")
            Repeat(2...) {
                CharacterClass(
                    .word,
                    .anyOf(".")
                )
            }
            Optionally(
                Repeat(2...) {
                    CharacterClass(
                        .word
                    )
                }
            )
            
            Anchor.endOfLine
        }
        return email.firstMatch(of: emailRegex) != nil
    }
    
    private func validatePassword(passwordText: String) -> String? {
        if passwordText.isEmpty {
            return Constants.emptyPasswordError
        }
        if passwordText.count <= 3 {
            return Constants.passwordFormatError
        }
        return nil
    }
    
}
