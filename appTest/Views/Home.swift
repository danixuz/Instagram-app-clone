//
//  Home.swift
//  appTest
//
//  Created by Daniel Spalek on 23/04/2022.
//

import SwiftUI

struct Home: View {
    @EnvironmentObject var viewModel: ViewModel
    @Binding var userIsLoggedIn: Bool
    var body: some View {
        VStack{
            //MARK: Header
            HStack{
                Image("Logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 130, height: 50)
                Spacer()
                HStack(spacing: 25){ //MARK: Post, likes and DMs buttons
                    
                    Button(action: {
                        //TODO: Create a post page
                    }){
                        Image(systemName: "plus.square")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 21, height: 21)
                    }
                    .buttonStyle(.plain)
                    
                    Button(action: {
                        //TODO: Create a likes page
                    }){
                        Image(systemName: "heart")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 21, height: 21)
                    }
                    .buttonStyle(.plain)
                    
                    Button(action: {
                        //TODO: Create DMs page
                    }){
                        Image(systemName: "message")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 22, height: 22)
                    }
                    .buttonStyle(.plain)
                }
            }.padding(.horizontal) //end of header
                .padding(.bottom, -7) //to make less empty space between the header and contentview
            //MARK: Home page content
            ScrollView(.vertical, showsIndicators: false){
                VStack{
                    //MARK: Stories section:
                    StoriesSection(stories: viewModel.dailyStories, optionToUpload: true)
                        .padding(.horizontal)
                    Post(post: "Post1")
                    Post(post: "Post2")
                    Post(post: "Post3")
                    
                    Text("Users:")
                    VStack{
                        ForEach(Array(viewModel.users.keys), id: \.self){ username in
                            Text(username)
                        }
                    }
                    
                    
                }
            } //homepage content end
            
            //MARK: Bottom menu
            bottomMenu()
        }
    } //end of body
}

struct StoriesSection: View{
    var stories: [Story]
    var optionToUpload: Bool = false
    var body: some View{
        ScrollView(.horizontal, showsIndicators: false){
            HStack{
                if optionToUpload{
                    VStack{
                        ZStack{
                            Image("myProfilePicture")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 63, height: 63)
                                .clipShape(Circle())
                            ZStack{
                                Circle()
                                    .foregroundColor(Color(.systemBackground))
                                    .frame(width: 26, height: 26)
                                Image(systemName: "plus.circle.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 19, height: 19)
                                    .foregroundColor(.blue)
                            }
                            .offset(x: 20, y: 20)
                        }.padding(.bottom, 2)
                        Text("Your story")
                            .font(.system(size: 12).weight(.light))
                    }
                    .offset( y: 5)
                }
                ForEach(stories) { story in
                    story
                        .padding(.leading, 4)
                }
            }
            .padding(.horizontal, 10)
        }
    }
}

struct Story: View, Identifiable{
    let id = UUID().uuidString //generate random id
    var username: String
    var date: String
    var length: Int //in seconds
    var content: String //the key of the story user created
    var minimized: Bool = true
    let size: CGFloat = 63.0
    @State var seen: Bool = false
    var body: some View{
        if minimized{
            VStack(spacing: 0){
                //MARK: Profile image w/ stroke
                ZStack{
                    if username != "Your story"{
                        if seen{
                            Circle()
                                .stroke(lineWidth: 1)
                                .foregroundColor(Color(.systemGray3))
                                .frame(width: size+9, height: size+9)
                        }else{
                            LinearGradient(colors: [.orange, .pink], startPoint: .bottomLeading, endPoint: .topTrailing)
                                .clipShape(Circle().stroke(lineWidth: 2))
                                .frame(width: size+8, height: size+8)
                        }
                    }
                    Image(username)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size, height: size)
                        .clipShape(Circle())
                }.frame(width: size+15, height: size+20)
                .onTapGesture {
                    //MARK: View the story
                    seen = true
                }
                Text(username)
                    .frame(width: size+15)
                    .font(.system(size: 12).weight(.light))
                    .lineLimit(1)
            }
        }else{
            //MARK: Get the image from the database
            Image(content)
        }
    }
}

struct bottomMenu: View{

    @Environment(\.colorScheme) var colorScheme //need to add this to manually choose color by current color scheme

    @State var postingActive = false
    @State var openCameraRoll = false
    @State var imageSelected = UIImage()

    var body: some View{
        HStack{
            Spacer()
            Group{
                SFSymbols.homeFilled
                    .resizable()
                    .frame(width: 30, height: 25)
                Spacer(minLength: 50)
                SFSymbols.explore
                    .resizable()
                    .frame(width: 23, height: 24)
                Spacer(minLength: 50)

                //add post button
                Button(action: {
                    postingActive = true
                    openCameraRoll = true
                }){
                    if postingActive{
                        SFSymbols.addPostFilled
                            .resizable()
                            .frame(width: 23, height: 23)
                    }else{
                        SFSymbols.addPost
                            .resizable()
                            .frame(width: 23, height: 23)
                    }
                }.sheet(isPresented: $openCameraRoll){
//                    ImagePicker(selectedImage: $imageSelected, sourceType: .photoLibrary)
                }.foregroundColor(colorScheme == .dark ? .white : .black)



                Spacer(minLength: 50)
                SFSymbols.heart
                    .resizable()
                    .frame(width: 25, height: 23)
                Spacer(minLength: 50)
                SFSymbols.profile
                    .resizable()
                    .frame(width: 25, height: 25)
            }
            Spacer()
        }
    }
}

//struct Home_Previews: PreviewProvider {
//    static var previews: some View {
//        Home(, userIsLoggedIn: $true).environmentObject(ViewModel())
//        Home().preferredColorScheme(.dark).environmentObject(ViewModel())
//        Story(username: "therock", date: "24/10/2002", length: 10, content: "Logo")
//    }
//}
