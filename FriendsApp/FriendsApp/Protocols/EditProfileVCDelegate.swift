//
//  EditProfileVCDelegate.swift
//  FriendsApp
//
//  Created by Denis Nefedov on 10.11.2019.
//  Copyright © 2019 X. All rights reserved.
//

import Foundation

public protocol EditProfileVCDelegate: class {
    func editProfileVCDelegate(_ viewController: EditProfileVC,
                                  didEdited user: User)
}
