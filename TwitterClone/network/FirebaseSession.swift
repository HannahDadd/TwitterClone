//
//  FirebaseSession.swift
//  Twitter Clone
//
//  Created by Hannah Billingsley-Dadd on 30/06/2020.
//  Copyright © 2020 hannah. All rights reserved.
//

import SwiftUI
import FirebaseFirestore

class FirebaseSession: ObservableObject {
    public var data: [Tweet] = []

    init() {

        Firestore.firestore().collection("tweets").addSnapshotListener { (snap, err) in
            print("Hello?")
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }
            for i in snap!.documentChanges {

                guard let name = i.document.get("name") as? String else { return }
                guard let message = i.document.get("msg") as? String else { return }
                guard let image = i.document.get("pic") as? String else { return }
                guard let url = i.document.get("url") as? String else { return }
                guard let retweets = i.document.get("retweet") as? String else { return }
                guard let likes = i.document.get("likes") as? String else { return }

                let id = i.document.documentID
                print("Hello?")

                DispatchQueue.main.async {
                    self.data.append(Tweet(id: id, message: message, retweets: retweets, likes: likes, name: name, image: image, url: url))
                }
            }
        }
    }

    func postTweet(msg : String){

        Firestore.firestore().collection("tweets").document().setData(["name" : "Hannah","id":"@hannah","msg":msg,"retweet":"0","likes":"0","pic":"","url":" Image URL "]) { (err) in

            if err != nil{
                print((err?.localizedDescription)!)
                return
            }
            print("success")
        }
    }
}
