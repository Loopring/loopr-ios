//
//  GenerateWalletViewController.swift
//  loopr-ios
//
//  Created by Matthew Cox on 2/4/18.
//  Copyright © 2018 Loopring. All rights reserved.
//

import UIKit

class GenerateWalletViewController: UIViewController {

    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var passwordStrengthIndicator: UIProgressView!
    @IBOutlet weak var viewPasswordButton: UIButton!
    @IBOutlet weak var generateNowButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func generateWalletButtonPressed(_ sender: Any) {
        let viewController = GenerateMnemonicViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func checkPasswordStrength() {
        
    }
    
    @IBAction func viewPasswordPressed(_ sender: Any) {
        passwordTextfield.isSecureTextEntry = !passwordTextfield.isSecureTextEntry
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
