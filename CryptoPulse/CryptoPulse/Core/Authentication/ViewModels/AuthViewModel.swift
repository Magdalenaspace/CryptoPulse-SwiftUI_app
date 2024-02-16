//
//  AuthViewModel.swift
//  CryptoPulse
//
//  Created by Magdalena Samuel on 04/07/22.
//



import SwiftUI
//import GoogleSignIn
import Firebase
import FirebaseFirestoreSwift
import Combine

class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var isAuthenticating = false
    @Published var error: Error?
    @Published var user: User?
    
    static let shared = AuthViewModel()
    
    private let service = UserService()
    
    private var cancellables = Set<AnyCancellable>()

    init() {
        userSession = Auth.auth().currentUser
        addSubscribers()
    }

    func addSubscribers() {
        service.$user
            .sink { [weak self] user in
                self?.user = user
            }
            .store(in: &cancellables)
    }

    func signIn(withEmail email: String, password: String) {
        self.isAuthenticating = true

        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: Failed to sign in with error: \(error.localizedDescription)")
                self.isAuthenticating = false
                self.error = error
                return
            }

            self.isAuthenticating = false
            self.userSession = result?.user
            self.service.fetchUser()
        }
    }

    func registerUser(withEmail email: String, fullname: String, password: String) {
        self.isAuthenticating = true

        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: Failed to sign in with error: \(error.localizedDescription)")
                self.isAuthenticating = false
                self.error = error
                return
            }

            guard let user = result?.user else { return }
            self.userSession = user
            self.isAuthenticating = false

            let data: [String: Any] = ["email": email,
                                       "fullname": fullname]

            self.uploadUserData(user: user, data: data)
        }
    }

//    func signInWithGoogle() {
//        guard let app = FirebaseApp.app() else { return }
//        guard let clientID = app.options.clientID else { return }
//        let config = GIDConfiguration(clientID: clientID)
//
//        guard let rootVC = window?.rootViewController else { return }
//
//        GIDSignIn.sharedInstance.signIn(with: config, presenting: rootVC) { user, error in
//            self.isAuthenticating = true
//
//            if let error = error {
//                print("DEBUG: Google sign in failed with error: \(error.localizedDescription)")
//                self.isAuthenticating = false
//                self.error = error
//                return
//            }
//
//            guard let googleUser = user else { return }
//            guard let authToken = googleUser.authentication.idToken else { return }
//            let accessToken = googleUser.authentication.accessToken
//            let credential = GoogleAuthProvider.credential(withIDToken: authToken, accessToken: accessToken)
//
//            guard let profile = googleUser.profile else { return }
//
//            Auth.auth().signIn(with: credential) { result, error in
//                if let error = error {
//                    print("DEBUG: Failed to sign in with error: \(error.localizedDescription)")
//                    self.isAuthenticating = false
//                    self.error = error
//                    return
//                }
//
//                guard let firebaseUser = result?.user else { return }
//                self.userSession = firebaseUser
//                self.isAuthenticating = false
//
//                let data: [String: Any] = ["email": profile.email,
//                                           "fullname": profile.name]
//
//                self.uploadUserData(user: firebaseUser, data: data)
//            }
//        }
//    }

    func signOut() {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
            self.user = nil
        } catch let error {
            print("DEBUG: Failed to sign out with error \(error.localizedDescription)")
        }
    }

    private func uploadUserData(user: FirebaseAuth.User, data: [String: Any]) {
        COLLECTION_USERS.document(user.uid).setData(data) { _ in
            self.service.fetchUser()
        }
    }
}
