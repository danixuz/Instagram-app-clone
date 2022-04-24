//
//  Profile.swift
//  appTest
//
//  Created by Daniel Spalek on 23/04/2022.
//

import SwiftUI

struct Profile: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        Button {
            UserDefaults.standard.set(false, forKey: "isLoggedIn")
            userIsLoggedIn = false
        } label: {
            Image(systemName: "rectangle.portrait.and.arrow.right")
                .padding(.top, 3)
        }
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile()
    }
}
