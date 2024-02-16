//
//  RegistrationView.swift
//  CryptoPulse
//
//  Created by Magdalena Samuel on 04/07/22.
//



import SwiftUI

struct RegistrationView: View {
    @State var email = ""
    @State var fullname = ""
    @State var password = ""
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel: AuthViewModel

    var body: some View {
        ZStack {
            
            VStack(alignment: .leading, spacing: 12) {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.title)
                        .imageScale(.medium)
                        .padding(8)
                }
                
                Text("Create your account")
                    .font(.system(size: 40))
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.leading)
                    .frame(width: 250)
                
                Spacer()

                VStack {
                    VStack(spacing: 24) {
                        CustomInputField(text: $fullname, title: "Full Name", placeholder: "Enter your name")
                        CustomInputField(text: $email, title: "Email Address", placeholder: "name@exmaple.com")
                        CustomInputField(text: $password, title: "Create Password", placeholder: "Enter your password", isSecureField: true)
                    }
                    .padding(.leading)
                                        
                    AuthenticationButton(config: .register) {
                        viewModel.registerUser(withEmail: email, fullname: fullname, password: password)
                    }
                    .padding(.top, 24)
                    
                    Spacer()
                }
                .padding(.vertical)
                
                Spacer()
            }
            .ignoresSafeArea()
            .foregroundColor(Color.theme.accent)
            .padding(.top, 12)
            .blur(radius: viewModel.isAuthenticating ? 4 : 0)
            
            if viewModel.isAuthenticating {
                CustomProgressView()
            }
        }
        .onReceive(viewModel.$userSession) { userSession in
            if userSession != nil {
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}


struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
            .preferredColorScheme(.dark)
    }
}
