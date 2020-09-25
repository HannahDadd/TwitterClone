//
//  ContentView.swift
//  TwitterClone
//
//  Created by Hannah Billingsley-Dadd on 25/09/2020.
//  Copyright © 2020 hannah. All rights reserved.
//

import SwiftUI
import Firebase

struct ContentView: View {
    @State private var selection = 2
    @ObservedObject var session = FirebaseSession()

    var body: some View {
        TabView(selection: $selection){
            Text("Profile")
                .tabItem {
                    Image(systemName: "person.fill")
            }
            .tag(0)
            Text("Profile")
                .tabItem {
                    Image(systemName: "magnifyingglass")
            }
            .tag(1)
            HomeView().environmentObject(self.session)
                .tabItem {
                    Image(systemName: "house")
            }
            .tag(2)
            Text("Profile")
                .tabItem {
                    Image(systemName: "message")
            }
            .tag(3)
        }.accentColor(.blue)
    }
}

struct HomeView: View {
    @EnvironmentObject var session: FirebaseSession
    @State var showingComposeMessage = false
    @State private var tweet: String = ""

    var body: some View {
        NavigationView {
            ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom)) {
                VStack {
                    List(self.session.data) { i in
                        TweetCell(tweet: i)
                    }
                }

                Button(action: { self.showingComposeMessage.toggle() }) {
                    Image(uiImage: UIImage(systemName: "plus.bubble.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 50, weight: .ultraLight, scale: .medium))!).padding().accentColor(.blue)
                }
            }
            .navigationBarTitle(Text("Home"), displayMode: .inline)
        }.sheet(isPresented: self.$showingComposeMessage) {
            VStack{
                HStack{
                    Button(action: { self.showingComposeMessage.toggle() }) {
                        Text("Cancel")
                    }
                    Spacer()
                    Button(action: {
                        self.session.postTweet(msg: self.tweet)
                        self.showingComposeMessage.toggle()
                    }) {
                        Text("Tweet").padding()
                    }
                }
                TextField("Enter your tweet", text: self.$tweet)

            }.padding()
        }
    }
}

struct TweetCell: View {
    let tweet: Tweet

    var body: some View {
        VStack {
//                AnimatedImage(url: URL(string: tweet.image)!).resizable().frame(width: 50, height: 50).clipShape(Circle())
            Text(tweet.name).bold()
            Text(tweet.message)
            HStack {
                Button(action: {}) {
                    Image(uiImage: UIImage(systemName: "bubble.right", withConfiguration: UIImage.SymbolConfiguration(pointSize: 10, weight: .ultraLight, scale: .medium))!)
                }
                Spacer()
                Button(action: {}) {
                    Image(uiImage: UIImage(systemName: "hand.thumbsup", withConfiguration: UIImage.SymbolConfiguration(pointSize: 10, weight: .ultraLight, scale: .medium))!)
                }
                Spacer()
                Button(action: {}) {
                    Image(uiImage: UIImage(systemName: "arrow.up.to.line.alt", withConfiguration: UIImage.SymbolConfiguration(pointSize: 10, weight: .ultraLight, scale: .medium))!)
                }
                Spacer()
                Button(action: {}) {
                    Image(uiImage: UIImage(systemName: "repeat", withConfiguration: UIImage.SymbolConfiguration(pointSize: 10, weight: .ultraLight, scale: .medium))!)
                }
            }.padding()
        }
    }
}
