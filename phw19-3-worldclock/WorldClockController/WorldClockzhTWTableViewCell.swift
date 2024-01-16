//
//  CityZhTWTableViewCell.swift
//  phw19-3-worldclock
//
//  Created by jasonhung on 2024/1/16.
//

import UIKit




class WorldClockzhTWTableViewCell: UITableViewCell {
    @IBOutlet weak var relativeDateLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var relativeHoursLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var cityZhTWLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
