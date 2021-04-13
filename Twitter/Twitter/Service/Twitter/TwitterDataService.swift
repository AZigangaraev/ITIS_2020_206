//
//  TwitterDataService.swift
//  Twitter
//
//  Created by Teacher on 09.02.2021.
//

import Foundation

class MockTwitterDataService: TwitterDataService {
    var tweets: [Tweet] = [
        Tweet(id: "1", username: "User 1", text: "Hello world 1", likes: 42),
        Tweet(id: "2", username: "User 2", text: "Hello world 2", likes: 44),
        Tweet(id: "3", username: "User 3", text: "Hello world 3", likes: 4),
        Tweet(id: "4", username: "User 4", text: "Hello world 4", likes: 2),
        Tweet(id: "5", username: "User 5", text: "Hello world 5", likes: 0),
    ]

    func retweet(tweet: Tweet, completion: @escaping (Result<Tweet, TwitterError>) -> Void) {
        let result = Tweet(id: UUID().uuidString, username: "admin", text: tweet.text, likes: 0)
        tweets.insert(result, at: 0)
        completion(.success(result))
    }

    func like(tweet: Tweet, completion: @escaping (Result<Tweet, TwitterError>) -> Void) {
        if let index = tweets.firstIndex(where: { $0.id == tweet.id }) {
            let result = Tweet(id: tweet.id, username: tweet.username, text: tweet.text, likes: tweet.likes + 1)
            tweets[index] = result
            completion(.success(result))
        } else {
            completion(.failure(.tweetNotFound))
        }
    }
}
