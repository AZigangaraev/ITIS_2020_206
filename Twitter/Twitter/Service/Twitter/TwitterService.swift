//
//  TwitterService.swift
//  Twitter
//
//  Created by Teacher on 16.02.2021.
//

enum TwitterError: Error {
    case tweetNotFound
}

protocol TwitterDataService {
    var tweets: [Tweet] { get }
    func retweet(tweet: Tweet, completion: @escaping (Result<Tweet, TwitterError>) -> Void)
    func like(tweet: Tweet, completion: @escaping (Result<Tweet, TwitterError>) -> Void)
}
