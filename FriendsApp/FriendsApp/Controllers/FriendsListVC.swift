//
//  ViewController.swift
//  FriendsApp
//
//  Created by Denis Nefedov on 08.11.2019.
//  Copyright © 2019 X. All rights reserved.
//

import UIKit

class FriendsListVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


}

extension FriendsListVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "friendCell", for: indexPath) as? FriendCell else {
            fatalError("no cell") // TODO: - обработать
        }
        cell.emailLabel.text = "test"
        cell.nameLabel.text = "testName"
        return cell
    }
    
    
}

