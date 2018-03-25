//
//  AssetTableViewCell.swift
//  loopr-ios
//
//  Created by Xiao Dou Dou on 2/1/18.
//  Copyright © 2018 Loopring. All rights reserved.
//

import UIKit

class AssetTableViewCell: UITableViewCell {

    var asset: Asset?
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var iconView: IconView!
    
    @IBOutlet weak var symbolLabel: UILabel!
    
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!

    // @IBOutlet weak var forwardImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        theme_backgroundColor = ["#fff", "#000"]
        symbolLabel.theme_textColor = ["#000", "#fff"]
        balanceLabel.theme_textColor = ["#000", "#fff"]
        amountLabel.theme_textColor = ["#000", "#fff"]
        // forwardImageView.theme_image = ["Forward", "Forward-white"]
        
        symbolLabel.font = UIFont(name: FontConfigManager.shared.getRegular(), size: 17)
        balanceLabel.font = UIFont(name: FontConfigManager.shared.getLight(), size: 17)
        amountLabel.font = UIFont(name: FontConfigManager.shared.getLight(), size: 14)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func update() {
        if let asset = asset {
            if asset.icon != nil {
                iconImageView.image = asset.icon
                iconImageView.isHidden = false
                iconView.isHidden = true
            } else {
                iconView.isHidden = false
                iconView.symbol = asset.symbol
                iconView.symbolLabel.text = asset.symbol
                iconImageView.isHidden = true
            }

            symbolLabel.text = asset.symbol
            // TODO: price unit get from setting
            balanceLabel.text = "$\(asset.display)"
            amountLabel.text = "\(asset.balance) \(asset.symbol)"
        }
    }
    
    class func getCellIdentifier() -> String {
        return "AssetTableViewCell"
    }
    
    class func getHeight() -> CGFloat {
        return 84
    }
}
