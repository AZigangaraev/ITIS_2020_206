//
//  PhoneNumberController.swift
//  Twitter
//
//  Created by Teacher on 16.02.2021.
//

import UIKit

class PhoneNumberController: UIViewController {
    var onFinish: ((_ phoneNumber: String) -> Void)?

    @IBOutlet var phoneTextField: UITextField!
    @IBAction func enterPhoneNumberTap() {
        onFinish?(phoneTextField.text ?? "")
    }
}
