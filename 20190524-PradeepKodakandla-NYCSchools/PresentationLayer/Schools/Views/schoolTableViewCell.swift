//
//  schoolTableViewCell.swift
//  20190524-PradeepKodakandla-NYCSchools
//
//  Created by Pradeep Kodakandla on 5/27/19.
//  Copyright © 2019 Pradeep Kodakandla. All rights reserved.
//

import UIKit

class schoolTableViewCell: UITableViewCell {
    @IBOutlet weak var schoolNameLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var gradesLbl: UILabel!
    @IBOutlet weak var totalStudentsLbl: UILabel!
    @IBOutlet weak var satScoreButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
