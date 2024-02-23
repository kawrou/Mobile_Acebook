//
//  SignUpView.swift
//  MobileAcebook
//
//  Created by Tom Mazzag on 19/02/2024.
//

import SwiftUI
struct SignUpView: View {
    
    let signUp = SignUp()
    
    @State public var username = ""
    @State private var email = ""
    @State private var password = ""
    @State private var avatar = ""
    @State private var isSignedUp = false
    @State private var isValidInput = false
    @EnvironmentObject var authenticationManager: AuthenticationManager

    var body: some View {
        NavigationView {
            VStack {
                Image("makers-logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .accessibilityIdentifier("makers-logo")
                
                Form {
                    Section {
                        TextField("Username", text: $username)
                    }
                    
                    Section {
                        TextField("Email", text: $email)
                            .autocapitalization(.none)
                    }
                    
                    Section {
                        SecureField("Password", text: $password)
                    }
                    
                    Button("Create an account") {
                        let user = User(username: username, password: password, email: email, avatar: avatar)
                        if signUp.isValidEmail(email: user.email) && signUp.isValidPassword(password: user.password) {
                            signUp.signUpUser(user: user) { success in
                                if success {
                                    DispatchQueue.main.async {
                                        authenticationManager.isLoggedIn = true
                                    }
                                    print("User signed up successfully!")
                                    let service = LoginService()
                                    let user = UserData(email: email, password: password)
                                    _ = service.login(user){ success in
                                        if success {
                                            email = ""
                                            password = ""
                                            self.isSignedUp = true
                                        } else {
                                            print("Error logging in")
                                        }
                                    }
                                } else {
                                    print("Error signing up!")
                                    self.isSignedUp = false
                                }
                            }
                        } else {
                            print("Invalid user details!")
                        }
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .background(.blue)
                    .listRowBackground(Color.blue)
                }
                
                if isSignedUp {
                    NavigationLink(
                        destination: ProfilePageView(username: username),
                            isActive: $isSignedUp) {
                            EmptyView()
                    }
                    .hidden()
                }
            }
        }
    }
}






//                .onAppear {
//                    isValidInput = signUp.isValidEmail(email: email) && signUp.isValidPassword(password: password)
//                }
