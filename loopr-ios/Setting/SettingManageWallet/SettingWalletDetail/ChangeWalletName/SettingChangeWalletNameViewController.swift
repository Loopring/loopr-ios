//
//  SettingChangeWalletNameViewController.swift
//  loopr-ios
//
//  Created by xiaoruby on 4/10/18.
//  Copyright © 2018 Loopring. All rights reserved.
//

import UIKit

class SettingChangeWalletNameViewController: UIViewController, UITextFieldDelegate {
    
    var appWallet: AppWallet!
    var nameTextField: UITextField = UITextField()
    var nameFieldBox: UIView = UIView()
    //var saveButtoon: UIButton = UIButton()
    var backgroundView: UIView = UIView()
    var saveButton = UIBarButtonItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.theme_backgroundColor = GlobalPicker.backgroundColor
        
        // Setup UI in the scroll view
        let screensize: CGRect = UIScreen.main.bounds
        let screenWidth = screensize.width
        // let screenHeight = screensize.height
        
        let originY: CGFloat = 30
        let padding: CGFloat = 15
        
        // Do any additional setup after loading the view.
        self.navigationItem.title = LocalizedString("Wallet Name", comment: "")
        setBackButton()
        
        nameTextField.delegate = self
        nameTextField.tag = 0
        nameTextField.theme_textColor = GlobalPicker.textColor
        nameTextField.font = FontConfigManager.shared.getDigitalFont()
        nameTextField.backgroundColor = UIColor.dark2
        nameTextField.placeholder = "Enter your wallet name"
        nameTextField.contentMode = UIViewContentMode.bottom
        nameTextField.placeHolderColor = UIColor.dark4
        nameTextField.borderColor = UIColor.dark3
        nameTextField.borderWidth = 1
        nameTextField.setLeftPaddingPoints(padding)
        nameTextField.frame = CGRect(x: 0 - nameTextField.borderWidth, y: originY, width: screenWidth + nameTextField.borderWidth * 2, height: 51)
        
        self.view.addSubview(nameTextField)
        
        saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(pressedSaveButton))
        saveButton.title = LocalizedString("Save", comment: "")
        
        self.navigationItem.setRightBarButton(saveButton, animated: true)
        
        nameTextField.text = appWallet.name
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func pressedSaveButton(_ sender: Any) {
        print("pressedSwitchTokenBButton: \(appWallet)")
        print("wallet Name is: \(appWallet.name)")
        
        if nameTextField.text?.count != 0 {
            appWallet.name = nameTextField.text!
            let dataManager = AppWalletDataManager.shared
            dataManager.updateAppWalletsInLocalStorage(newAppWallet: appWallet)
            for controller in self.navigationController!.viewControllers as Array {
                if controller.isKind(of: SettingViewController.self) {
                    self.navigationController!.popToViewController(controller, animated: true)
                    break
                }
            }
            //            self.navigationController?.popToViewController(, animated: true)
            //            self.navigationController?.popViewController(animated: true)
        } else {
            
            let alertController = UIAlertController(title: "New wallet name can't be empty", message: nil, preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
                
            })
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
        
    }
}
