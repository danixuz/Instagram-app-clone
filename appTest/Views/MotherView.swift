//
//  MotherView.swift
//  appTest
//
//  Created by Daniel Spalek on 23/04/2022.
//

import SwiftUI

struct MotherView: View {
    @State var userIsLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
    var body: some View {
        if userIsLoggedIn{
            Home(userIsLoggedIn: $userIsLoggedIn)
        }else{
            LoginOrRegister()
        }
    }
}

struct MotherView_Previews: PreviewProvider {
    static var previews: some View {
        MotherView()
    }
}
