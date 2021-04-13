//
//  TweetCell.swift
//  Twitter
//
//  Created by Teacher on 09.02.2021.
//

import UIKit

class TweetCell: UITableViewCell {
    var tweet: Tweet? {
        didSet {
            guard let tweet = tweet else { return }

            usernameLabel.text = tweet.username
            messageLabel.text = tweet.text
            likeButton.setTitle("Likes \(tweet.likes)", for: .normal)
        }
    }
    var retweetTap: (() -> Void)?
    var likeTap: (() -> Void)?

    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var likeButton: UIButton!

    @IBAction func likeTap(_ sender: Any) {
        likeTap?()
    }
    @IBAction func retweetTap(_ sender: Any) {
        retweetTap?()
    }
}
