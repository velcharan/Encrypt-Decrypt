//
//  ViewController.swift
//  EncryptDecryptData
//
//  Created by Mohammed Azeem Azeez on 03/08/2019.
//  Copyright © 2019 J'Overt Matics. All rights reserved.
//

import UIKit
import UIKit
@_exported import RNCryptor

let encryptionKEY = "123456"
let loginUsername = "velcharan"
let loginPassword = "password"
class ViewController: UIViewController {
    
    @IBOutlet var emailText: UITextField!
    @IBOutlet var passwordText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    // Encrypt function
    func encrypt(plainText : String, password: String) -> String {
        
        let data: Data = plainText.data(using: .utf8)!
        let encryptedData = RNCryptor.encrypt(data: data, withPassword: encryptionKEY)
        let encryptedString : String = encryptedData.base64EncodedString() // getting base64encoded string of encrypted data.
        return encryptedString
    }
    // Decrypt Function
    func decrypt(encryptedText : String, password: String) -> String {
        do  {
            let data: Data = Data(base64Encoded: encryptedText)! // Just get data from encrypted base64Encoded string.
            let decryptedData = try RNCryptor.decrypt(data: data, withPassword: password)
            let decryptedString = String(data: decryptedData, encoding: .utf8) // Getting original string, using same .utf8 encoding option,which we used for encryption.
            return decryptedString ?? ""
        }
        catch {
            return "FAILED"
        }
    }
    
    @IBAction func openPage(_ sender: Any) {
        let encryptedUsernameText =  self.encrypt(plainText: loginUsername, password: encryptionKEY)
        let encryptedPasswordText =  self.encrypt(plainText: loginPassword, password: encryptionKEY)
        let decryptedText1 = self.decrypt(encryptedText: encryptedUsernameText, password: encryptionKEY)
        let decryptedText2 = self.decrypt(encryptedText: encryptedPasswordText, password: encryptionKEY)
        print(encryptedUsernameText)
        print(encryptedPasswordText)
        print(decryptedText1)
        print(decryptedText2)
    }
    
}

public enum MyError: Error {
    case customError
}

extension MyError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .customError:
            return NSLocalizedString("Something went wrong, please try again later.", comment: "")
        }
    }
    public var recoverySuggestion: String? {
        switch self {
        case .customError:
            return NSLocalizedString("Please enter valid details.", comment: "")
        }
    }
}
extension UIViewController {
    func showAlert(message: String, title: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
