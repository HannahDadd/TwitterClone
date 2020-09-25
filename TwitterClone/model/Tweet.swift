//
//  Tweet.swift
//  TwitterClone
//
//  Created by Hannah Billingsley-Dadd on 25/09/2020.
//  Copyright © 2020 hannah. All rights reserved.
//

import Foundation

struct Tweet: Identifiable {
    var id: String

    var message: String
    var retweets: String
    var likes: String
    var name: String
    var image: String
    var url: String
}
