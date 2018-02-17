//
//  WalletNavigationViewController.swift
//  loopr-ios
//
//  Created by Xiao Dou Dou on 2/1/18.
//  Copyright © 2018 Loopring. All rights reserved.
//

import UIKit

class WalletNavigationViewController: UINavigationController {

    // TODO: set walletExists to false when the generate wallet feature is completed.
    var walletExists = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationBar.shadowImage = UIImage()
        showWallet()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //Present Wallet UI if wallet is present
    func showWallet(){
        if (walletExists) {
            let viewController = WalletViewController(nibName: nil, bundle: nil)
            self.setViewControllers([viewController], animated: false)
        } else {
            let viewController = WalletViewController(nibName: nil, bundle: nil)
            let setupViewController = SetupViewController(nibName: nil, bundle: nil)
            self.setViewControllers([viewController,setupViewController], animated: false)
        }
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
