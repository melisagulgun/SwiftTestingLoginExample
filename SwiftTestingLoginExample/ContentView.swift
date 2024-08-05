//
//  ContentView.swift
//  SwiftTestingLoginExample
//
//  Created by Melisa Gülgün on 31.07.2024.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = LoginViewModel()
    @Binding var emailText: String
    @Binding var passwordText: String
    
    var body: some View {
        LazyVStack(alignment: .leading, content: {
            LazyVStack(alignment: .leading, content: {
                TextField("Email", text: $emailText)
                    .frame(maxWidth: .infinity)
                    .onChange(of: emailText) { oldValue, newValue in
                        viewModel.validateForm(email: newValue, password: passwordText)
                    }
                Divider()
                    .overlay(viewModel.emailError != nil ? Color.red : Color.black)
                
                if let emailError = viewModel.emailError {
                    Text(emailError)
                        .font(.footnote)
                        .foregroundStyle(Color.red)
                }
            })
            .frame(height: viewModel.passwordError != nil ? 60 : 50)

            
            LazyVStack(alignment: .leading, content: {
                SecureField("Password", text: $passwordText)
                    .frame(maxWidth: .infinity)
                    .onChange(of: passwordText) { oldValue, newValue in
                        viewModel.validateForm(email: self.emailText, password: newValue)
                    }
                
                Divider()
                    .overlay(viewModel.passwordError != nil ? Color.red : Color.black)
                
                if let passwordError = viewModel.passwordError {
                    Text(passwordError)
                        .font(.footnote)
                        .foregroundStyle(Color.red)
                }
            })
            .frame(height: viewModel.passwordError != nil ? 60 : 50)
            
           
            Button {
                viewModel.checkFormInputs(email: self.emailText, password: self.passwordText)
                print(viewModel.isFormValid)
            } label: {
                Text("Login")
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(viewModel.isFormValid ? Color.black : Color.gray)
                    .foregroundColor(Color.white)
                    .allowsTightening(viewModel.isFormValid ? false : true)
            }
            .cornerRadius(5)
        })
            .padding()
        
    }
}

#Preview {
    ContentView(emailText: .constant(""), passwordText: .constant(""))
}
