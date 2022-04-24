//
//  Post.swift
//  appTest
//
//  Created by Daniel Spalek on 23/04/2022.
//

import SwiftUI

struct Post: View {
    @Environment(\.colorScheme) var colorScheme //need to add this to manually choose color by current color scheme
    
    //default posts aspect ratio is 1x1
    var postSize = [screenSize.width, screenSize.width]
    var username: String = "myProfilePicture"
    var post = "Post2"
    @State var likeCount = 2
    @State var commentCount = 10
    @State var isLiked = false
    let date = "January 25"
    
    var body: some View{
        VStack(alignment: .leading){
            HStack{ //the poster name and image and options
                Image(username)
                    .resizable()
                    .frame(width: 32, height: 32)
                    .cornerRadius(16)
                Text("username").bold()
                    .font(.system(size: 15))
                Spacer()
                SFSymbols.dots
            }.padding(.horizontal)
            
            //MARK: Post images/ videos
            Image(post)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: postSize[0], height: postSize[1])
                .clipped()
            
            HStack(spacing: 9){ //like comment share save
                Button(action: {
                    isLiked.toggle()
                }){
                    if isLiked{
                        SFSymbols.heartFilled
                            .resizable()
                            .frame(width: 24, height: 21)
                            .padding(.trailing, 5)
                    }else{
                        SFSymbols.heart
                            .resizable()
                            .frame(width: 24, height: 21)
                            .padding(.trailing, 5)
                    }
                }
                .foregroundColor(colorScheme == .dark ? .white : .black)
                SFSymbols.comment
                    .resizable()
                    .frame(width: 22.5, height: 22.5)
                    .padding(.leading, 5)
                SFSymbols.shareIG
                    .resizable()
                    .frame(width: 22, height: 22)
                    .padding(.leading, 10)
                Spacer()
                SFSymbols.bookmark
                    .resizable()
                    .frame(width: 17, height: 25)
            }.padding(.horizontal).padding(.top, 5)
            
            VStack(alignment: .leading, spacing: 6){
                //Like count:
                if isLiked{
                    Text("\(likeCount+1) Likes").bold()
                        .font(.system(size: 15))
                }else{
                    Text("\(likeCount) Likes").bold()
                        .font(.system(size: 15))
                }
                
                //descrpition:
                Text("**\(username)** This is a test of a post description in the instagram clone app.")
                    .font(.system(size: 15))
                //TODO: Limit the amount of lines to 2 lines. add a "more..." button that when you press, you can see the rest of the description. add sliding animation when pressed.
                
                //comment count and clickable link to comment section of the post
                Text("View all \(commentCount) comments")
                    .foregroundColor(.gray)
                    .font(.system(size: 15))
                
                //date:
                Text(date)
                    .foregroundColor(.gray).font(.system(size: 14))
            }.padding(.horizontal)
            
            
        }.padding()
    }
}

struct Post_Previews: PreviewProvider {
    static var previews: some View {
        Post()
    }
}
