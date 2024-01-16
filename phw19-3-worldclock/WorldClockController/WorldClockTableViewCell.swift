//
//  WorldClockTableViewCell.swift
//  phw19-3-worldclock
//
//  Created by jasonhung on 2024/1/10.
//

import UIKit




class WorldClockTableViewCell: UITableViewCell {
    @IBOutlet weak var relativeDateLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var relativeHoursLabel: UILabel!    
    @IBOutlet weak var timeLabel: UILabel!
    
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
