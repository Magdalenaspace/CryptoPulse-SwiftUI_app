//
//  AuthenticationButton.swift
//  CryptoPulse
//
//  Created by Magdalena Samuel on 04/07/22.
//



import SwiftUI

enum AuthButtonConfig {
    case login
    case register
    
    var title: String {
        switch self {
        case .login: return "SIGN IN"
        case .register: return "SIGN UP"
        }
    }
}

struct AuthenticationButton: View {
    
    let config: AuthButtonConfig
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text(config.title)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                
                Image(systemName: "arrow.right")
                    .font(.subheadline)
            }
            .foregroundColor(.white)
            .frame(width: UIScreen.main.bounds.width - 64, height: 50)
            .background(LinearGradient(colors: [Color(#colorLiteral(red: 0.6722137332, green: 0.5048282743, blue: 0.9994676709, alpha: 1)), Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1))], startPoint: .center, endPoint: .bottomTrailing))
            .cornerRadius(25)
        }
    }
}

struct AuthenticationButton_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationButton(config: .login) {
            print("Hello")
        }
    }
}
