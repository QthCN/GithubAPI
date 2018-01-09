//
//  NotificationsVC.swift
//  GithubAPI_Example
//
//  Created by Serhii Londar on 1/9/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import GithubAPI

class NotificationsVC: UIViewController {
    var authentication: Credentials! = nil
    @IBOutlet weak var tableView: UITableView! = nil
    var notifications: [NotificationsResponse] = [NotificationsResponse]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.estimatedRowHeight = 40.0
        
        let data = try? Data(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "credentials", ofType: "json")!))
        self.authentication = try? JSONDecoder().decode(Credentials.self, from: data!)
        
        NotificationsAPI(authentication: TokenAuthentication(token: (self.authentication.token?.token)!)).notifications(all: true) { (response, error) in
            if let response = response {
                self.notifications = response
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else {
                print(error ?? "")
            }
        }
    }
}

extension NotificationsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.notifications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationsCell", for: indexPath) as! NotificationsCell
        let notification = self.notifications[indexPath.row]
        if let type = notification.subject?.type {
            if type == "PullRequest" {
                cell.notificationEventIcon.image = UIImage(named: "git-pull-request")
            } else if type == "Issue" {
                cell.notificationEventIcon.image = UIImage(named: "issue-opened")                
            } else {
                cell.notificationEventIcon.image = nil
            }
        }
        cell.notificationNameLabel.text = notification.subject?.title
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return -1
    }
}