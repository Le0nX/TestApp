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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "friendCell", for: indexPath) as? FriendCell else {
            fatalError("no cell") // TODO: - обработать
        }
        cell.emailLabel.text = "test"
        cell.nameLabel.text = "testName"
        return cell
    }
    
    //MARK: - Segue prepare
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // подготавливаемся к переходу
        guard let vc = segue.destination as? EditProfileVC else {return}
        //vc.questionStrategy = RandomQuestionStrategy(questionGroup: selectedQuestionGroup)
        vc.delegate = self // передаем себя в качестве делегата questionVC'ру
    }
    
    
}

extension FriendsListVC: EditProfileVCDelegate {
    func editProfileVCDelegate(_ viewController: EditProfileVC, didEdited user: User) {
        navigationController?.popViewController(animated: true)
    }
}

extension FriendsListVC: AddProfileVCDelegate {
    func addProfileVCDelegate(_ viewController: AddProfileVC, didAdded newUser: User) {
        navigationController?.popViewController(animated: true)
    }
}
