//
//  CustomTableViewCell.swift
//  mini_project_1
//
//  Created by FDC-KYLE-NC-WEB on 7/30/24.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var forKids: UILabel!
    @IBOutlet weak var teacherName: UILabel!
    
    override func awakeFromNib() {
          super.awakeFromNib()
        
          setupImageView()
      }

      override func layoutSubviews() {
          super.layoutSubviews()
          setupImageView()
      }
      
      private func setupImageView() {
          let cornerRadius = iconImageView.frame.size.width / 8
          iconImageView.layer.cornerRadius = cornerRadius
          iconImageView.clipsToBounds = true
          
      }
}
