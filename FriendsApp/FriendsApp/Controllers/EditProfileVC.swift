//
//  EidtProfileVC.swift
//  FriendsApp
//
//  Created by Denis Nefedov on 09.11.2019.
//  Copyright © 2019 X. All rights reserved.
//

import UIKit

public class EditProfileVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // MARK: - Outlets
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var photoButton: UIButton!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!

    @IBOutlet var saveButton: UIButton!

    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var descriptionTextField: UITextField!
    
    // MARK: - Delegate
    public weak var delegate: EditProfileVCDelegate?
    
    // MARK: - Properites
    var pickerCtrl: UIImagePickerController? = UIImagePickerController()
    
    // MARK: - Models
     var profile: User!
    
    override public func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        prepareViews()
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        pickerCtrl?.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardNotification(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(gesture:)))
        view.addGestureRecognizer(tapGesture)

        //loadProfileSettings()
    }
    
    @IBAction func saveEditedProfile(_ sender: UIButton) {
        delegate?.editProfileVCDelegate(self, didEdited: User(id: 1, firstName: "a", lastName: "a", email: "a", imageUrl: "a", dateCreated: Date()))
    }
    
   // MARK: - UI settings
   /**
    Метод подготовки вьюх кнопок и изображения пользователя
    */
   func prepareViews() {
       let widthPhotoBtn = photoButton.frame.size.width
       let rect = CGRect(x: widthPhotoBtn / 4,
                         y: widthPhotoBtn / 4,
                         width: widthPhotoBtn / 2,
                         height: widthPhotoBtn / 2)

       let imageView = UIImageView(frame: rect)
       imageView.image = UIImage(named: "slr-camera-2-xxl")

       photoButton.addSubview(imageView)

       photoButton.layer.cornerRadius = widthPhotoBtn / 2
       photoButton.clipsToBounds = true

       profileImage.layer.cornerRadius = widthPhotoBtn / 2
       profileImage.clipsToBounds = true

       editButton.clipsToBounds = true

       styleProfileButton(editButton, with: UIColor.black.cgColor, cornerRaius: 10)
       styleProfileButton(saveButton, with: UIColor.black.cgColor, cornerRaius: 10)
       }
    
    private func styleProfileButton(_ button: UIButton, with borderColor: CGColor, cornerRaius: CGFloat) {
        button.layer.borderColor = borderColor
        button.layer.cornerRadius = cornerRaius
        button.layer.borderWidth = 2.0
    }
    
    // MARK: - keyboard Routine
    @objc func dismissKeyboard(gesture: UITapGestureRecognizer) {
        view.endEditing(true)
    }

    @objc func keyboardNotification(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let endFrameY = endFrame?.origin.y ?? 0
            let duration: TimeInterval = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIView.AnimationOptions.curveEaseInOut.rawValue
            let animationCurve: UIView.AnimationOptions = UIView.AnimationOptions(rawValue: animationCurveRaw)
            if endFrameY >= UIScreen.main.bounds.size.height {

                self.view.frame.origin.y = 0

            } else {
                self.view.frame.origin.y = -(endFrame?.size.height ?? 0)
            }
            UIView.animate(withDuration: duration,
                           delay: TimeInterval(0),
                           options: animationCurve,
                           animations: { self.view.layoutIfNeeded() },
                           completion: nil)
        }
    }
    
    // MARK: - save buttons enable/disable

    @IBAction func nameHasChanged(_ sender: UITextField) {
        prepareSaveButtons()
    }

    @IBAction func descriptionHasChanged(_ sender: UITextField) {
        prepareSaveButtons()
    }

    private func prepareSaveButtons() {
//        saveButton.isEnabled = checkSaveButton()
//        operationButton.isEnabled = checkOperationButton()
    }
    
   
}
