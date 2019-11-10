//
//  MainVCDelegate.swift
//  FriendsApp
//
//  Created by Denis Nefedov on 10.11.2019.
//  Copyright © 2019 X. All rights reserved.
//

import Foundation

public protocol AddProfileVCDelegate: class {
    func addProfileVCDelegate(_ viewController: AddProfileVC,
                                  didAdded newUser: User)
}
