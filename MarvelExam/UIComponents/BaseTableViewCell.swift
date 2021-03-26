//
//  BaseTableViewCell.swift
//  MarvelExam
//
//  Created by Luis Genaro Arvizu Vega on 26/03/21.
//

import UIKit

class BaseTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    private func setup() {
        textLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        textLabel?.minimumScaleFactor = 0.5
        textLabel?.adjustsFontSizeToFitWidth = true
        textLabel?.textColor = UIColor.darkClouds        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)
        
        // Configure the view for the selected state
    }

}
