//
//  AddProfileVC.swift
//  FriendsApp
//
//  Created by Denis Nefedov on 09.11.2019.
//  Copyright © 2019 X. All rights reserved.
//

import UIKit

public class AddProfileVC: UIViewController {

    public weak var delegate: AddProfileVCDelegate?
    
    override public func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addedNewProfile(_ sender: UIButton) {
        delegate?.addProfileVCDelegate(self, didAdded: User(id: 1, firstName: "a", lastName: "a", email: "a", imageUrl: "a", dateCreated: Date()))
        dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
