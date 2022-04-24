//
//  LoginView.swift
//  appTest
//
//  Created by Daniel Spalek on 23/04/2022.
//

import SwiftUI
import Firebase

enum currentLoginPage{
    case login
    case register
    case forgotPassword
}
struct LoginOrRegister: View{
    @EnvironmentObject var viewModel: ViewModel
    @State var currentPage: currentLoginPage = .login
    var body: some View{
        switch currentPage{
        case .login:
            LoginView(currentPage: $currentPage)
        case .register:
            SignUp(currentPage: $currentPage)
        case .forgotPassword:
            ForgotPassword(currentPage: $currentPage)
        }
    }
}
struct LoginView: View {
    @Binding var currentPage: currentLoginPage
    @State var email: String = ""
    @State var password: String = ""
    @State private var userIsLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
    var body: some View {
        if userIsLoggedIn{
            Home(userIsLoggedIn: $userIsLoggedIn)
        }else{
            content
        }
    } //end of body
    
    var content: some View{
        VStack{
            Image("Logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 160, height: 70)
            
            // MARK: Email field
            ZStack{
                RoundedRectangle(cornerRadius: 5)
                    .frame(height: 40)
                    .foregroundColor(Color(.secondarySystemBackground))
                    
                TextField("Email", text: $email)
                    .textInputAutocapitalization(.never)
                    .padding(.horizontal)
            }
            .padding()
            
            // MARK: Password field
            ZStack{
                RoundedRectangle(cornerRadius: 5)
                    .frame(height: 40)
                    .foregroundColor(Color(.secondarySystemBackground))
                    
                SecureField("Password", text: $password)
                    .textInputAutocapitalization(.never)
                    .padding(.horizontal)
            }
            .padding(.horizontal)
            
            // MARK: Forgot password?
            Button {
                withAnimation{
                    currentPage = .forgotPassword
                }
            } label: {
                Text("Forgot password?")
                    .bold()
                    .font(.system(size: 15))
            }
            .frame(width: screenSize.width - 30, height: 30, alignment: .trailing)

            // MARK: Log in button
            Button {
                login()
                
            } label: {
                Text("Log In")
            }
            .frame(width: screenSize.width - 30, height: 40)
            .foregroundColor(.white)
            .background(.blue)
            .cornerRadius(5)
            .padding(.horizontal)
            
            //MARK: Divider between log in button to sign up button
            ZStack{
                Rectangle()
                    .fill(Color(.systemGray4))
                    .frame(width: screenSize.width/2.95, height: 1)
                    .offset(x: -112)
                    Text("OR")
                    .foregroundColor(Color(.systemGray))
                Rectangle()
                    .fill(Color(.systemGray4))
                    .frame(width: screenSize.width/2.95, height: 1)
                    .offset(x: 112)
            }
            .padding(.top)
            
            // MARK: Sign up button
            HStack{
                Text("Don't have an account?")
                    .foregroundColor(Color(.systemGray))
                Button {
                    withAnimation {
                        currentPage = .register
                    }
                } label: {
                    Text("Sign Up.")
                        .bold()
                }
            }.offset(y: 10)
                .font(.system(size: 15))
        } //end of Vstack
//        .onAppear {
//            Auth.auth().addStateDidChangeListener { auth, user in
//                if user != nil{ //there is a user logged in
//                    userIsLoggedIn.toggle()
//                }
//            }
//        }
    }
    
    // MARK: Log in a user
    func login(){
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error != nil{
                print(error!.localizedDescription)
                return
            }
            UserDefaults.standard.set(true, forKey: "isLoggedIn")
            userIsLoggedIn = true //to trigger refresh
        }
    }
} //end of struct


struct SignUp: View{
    @EnvironmentObject var viewModel: ViewModel
    @Binding var currentPage: currentLoginPage
    @State var username: String = ""
    @State var password: String = ""
    @State var email: String = ""
    @State private var usernameTakenAlert = false
    @State private var userIsLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
    var body: some View{
        if userIsLoggedIn{
            Home(userIsLoggedIn: $userIsLoggedIn)
        }else{
            content
        }
    }
    var content: some View{
        VStack(spacing: 20){
            HStack{ // MARK: Back button
                Button {
                    withAnimation {
                        currentPage = .login
                    }
                } label: {
                    HStack{
                        Image(systemName: "chevron.left")
                        Text("Back")
                    }
                }
                Spacer()
            }.padding(.horizontal)
            Spacer()

            Text("Create an account")
                .font(.title.weight(.light))
            Text("Pick a username for your new account, enter your email address and create a password.")
                .multilineTextAlignment(.center)
                .frame(width: screenSize.width - 50)
                .foregroundColor(.gray)
            ZStack{
                RoundedRectangle(cornerRadius: 5)
                    .frame(height: 40)
                    .foregroundColor(Color(.secondarySystemBackground))
                    
                TextField("Username", text: $username)
                    .padding(.horizontal)
                    .textInputAutocapitalization(.never)
            }.padding(.horizontal)
            ZStack{
                RoundedRectangle(cornerRadius: 5)
                    .frame(height: 40)
                    .foregroundColor(Color(.secondarySystemBackground))
                    
                TextField("Email", text: $email)
                    .padding(.horizontal)
                    .textInputAutocapitalization(.never)
            }.padding(.horizontal)
            ZStack{
                RoundedRectangle(cornerRadius: 5)
                    .frame(height: 40)
                    .foregroundColor(Color(.secondarySystemBackground))
                    
                SecureField("Password", text: $password)
                    .padding(.horizontal)
                    .textInputAutocapitalization(.never)
            }.padding(.horizontal)
            Button { //MARK: Perform checks to verify every field is legal.
                // MARK: Also check if the username is not taken:
                if isUsernameTaken(username: username){
                    usernameTakenAlert = true
                }else{
                    register()
                    UserDefaults.standard.set(true, forKey: "isLoggedIn")
                    userIsLoggedIn = true //to trigger refresh
                }
            } label: {
                Text("Continue")
            }
            .frame(width: screenSize.width - 30, height: 40)
            .foregroundColor(.white)
            .background(.blue)
            .cornerRadius(5)
            .padding(.horizontal)
            .alert("Username is taken.", isPresented: $usernameTakenAlert) {
                Button("OK", role: .cancel){}
            } message: {
                Text("The chosen Username has already been taken. Please choose a different Username.")
            }
            
            Spacer(minLength: 250)

            
        }
//        .onAppear {
//            Auth.auth().addStateDidChangeListener { auth, user in
//                if user != nil{ //there is a user logged in
//                    userIsLoggedIn.toggle()
//                }
//            }
//        }
    }
    
    
//    func isUsernameTaken(username: String, _ completion: @escaping (_ data: String?) -> Void){
//        let db = Firestore.firestore()
//        let ref = db.collection("users")
//        let userDocRef = ref.document(username)
//        userDocRef.getDocument { document, error in
//            guard let document = document, document.exists else{
//                print("user does not exist")
//                completion("DOESNOTEXIST")
//                return
//            }
//            completion(document.get("username") as? String)
//        }
//    }
    
    // MARK: Check if a username is taken or not.
    func isUsernameTaken(username: String) -> Bool{
        return viewModel.users[username] != nil
    }
    
    // MARK: Register a user
    func register() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error != nil{
                print(error!.localizedDescription)
            }
        }
    }
}

struct ForgotPassword: View{
    @Binding var currentPage: currentLoginPage
    var body: some View{
        
        VStack{
            Spacer()
            Button {
                currentPage = .login
            } label: {
                HStack{
                    Image(systemName: "chevron.left")
                    Text("Back")
                }
            }
            Spacer()

            Text("Forgot password?")
            Spacer()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginOrRegister()
        LoginOrRegister().preferredColorScheme(.dark)
    }
}
