//
//  TwitterViewController.swift
//  Twitter
//
//  Created by Teacher on 09.02.2021.
//

import UIKit

class TwitterViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet var tableView: UITableView!

    private var cells: [Tweet] = []

    var viewModel: TwitterViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.tweets = { [unowned self] in
            cells = $0
            tableView.reloadData()
        }
        viewModel.loadData()

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log out", style: .plain, target: self, action: #selector(logOutTap))
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cells.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? TweetCell else {
            fatalError("Could not dequeue cell")
        }
        let tweet = cells[indexPath.row]
        cell.tweet = tweet
        cell.likeTap = { [unowned self] in
            viewModel.like(tweet: tweet)
        }
        cell.retweetTap = { [unowned self] in
            viewModel.retweet(tweet: tweet)
        }
        return cell
    }

    @objc private func logOutTap() {
        viewModel.logOut()
    }
}
