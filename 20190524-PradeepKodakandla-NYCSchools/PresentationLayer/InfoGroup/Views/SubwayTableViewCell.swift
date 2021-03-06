//
//  SubwayTableViewCell.swift
//  20190524-PradeepKodakandla-NYCSchools
//
//  Created by Pradeep Kodakandla on 5/27/19.
//  Copyright © 2019 Pradeep Kodakandla. All rights reserved.
//

import UIKit

class SubwayTableViewCell: UITableViewCell {

    @IBOutlet weak var subwayView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBOutlet weak var heightConst: NSLayoutConstraint!
    
    override func prepareForReuse() {
        for view in self.subwayView.subviews {
            view.removeFromSuperview()
        }
    }

    // creating labels to add Subway routes as a tags and show them in busses section in SchoolDetails screen.
    func subway(with tags:[String]) {
        var x_axis: CGFloat = 0.0
        var y_axis: CGFloat = 2
        let height: CGFloat = 20
        for tag in tags {
            let lbl = UILabel(frame: CGRect(x: x_axis,
                                            y: y_axis,
                                            width: 50,
                                            height: height))
            lbl.backgroundColor = .darkGray
            lbl.font = UIFont.boldSystemFont(ofSize: 12)
            lbl.textAlignment = .center
            lbl.textColor = .white
            lbl.text = tag
            let size = CGSize(width: lbl.intrinsicContentSize.width + 10, height: 20)
            lbl.frame.size = size
            x_axis = x_axis + lbl.frame.size.width + 5
            if x_axis < self.frame.size.width {
                self.subwayView.addSubview(lbl)
                heightConst.constant = y_axis + 20
            } else {
                x_axis = 0
                y_axis = y_axis + height + 5
                lbl.frame.origin.x = x_axis
                lbl.frame.origin.y = y_axis
                subwayView.addSubview(lbl)
                heightConst.constant = y_axis + 10
            }
        }
    }
    
}
