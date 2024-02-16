//
//  LoginView.swift
//  CryptoPulse
//
//  Created by Magdalena Samuel on 04/07/22.
//



import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var viewModel: AuthViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: 32) {
                    VStack(alignment: .leading) {
                        Text("Hello")
                            .font(.system(size: 32))
                            .fontWeight(.semibold)
                        
                        Text("Welcome Back")
                            .font(.system(size: 32))
                            .fontWeight(.semibold)
                    }
                    .padding(.top, 32)
                    .foregroundColor(Color.theme.accent)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                    
                    VStack(spacing: 12) {
                        CustomInputField(text: $email,
                                         title: "Email Address",
                                         placeholder: "name@example.com")
                            .padding()
                        
                        CustomInputField(text: $password,
                                         title: "Password",
                                         placeholder: "Enter your password",
                                         isSecureField: true)
                            .padding()
                    }
                    
                    AuthenticationButton(config: .login) {
                        viewModel.signIn(withEmail: email, password: password)
                    }
                    
                    Spacer()
                    
                    NavigationLink(
                        destination: RegistrationView().navigationBarHidden(true),
                        label: {
                            HStack {
                                Text("Don't have an account?")
                                    .font(.system(size: 14))
                                Text("Sign Up")
                                    .font(.system(size: 14, weight: .semibold))
                            }
                            .foregroundColor(Color.theme.accent)
                        })
                        .padding(.bottom, 24)
                }
                .blur(radius: viewModel.isAuthenticating ? 4 : 0)
                
                if viewModel.isAuthenticating {
                    CustomProgressView()
                }
            }
            .navigationBarHidden(true)
            .onReceive(viewModel.$userSession) { userSession in
                if userSession != nil {
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .preferredColorScheme(.dark)
    }
}
