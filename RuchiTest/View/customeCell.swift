//
//  customeCell.swift
//  RuchiTest
//
//  Created by iMac on 22/06/21.
//

import Foundation
import UIKit
import Kingfisher

class CustomTableViewCell: UITableViewCell {

    let img = UIImageView()
    let lbltitle = UILabel()
    let lbldesc = UILabel()


    override func layoutSubviews() {

        img.translatesAutoresizingMaskIntoConstraints = false
        lbltitle.translatesAutoresizingMaskIntoConstraints = false
        lbldesc.translatesAutoresizingMaskIntoConstraints = false
     
        lbldesc.numberOfLines = 0
        
        contentView.addSubview(img)
        contentView.addSubview(lbltitle)
        contentView.addSubview(lbldesc)
        
        setupLayoutConstraints()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }
    
    //setup constraints for sub items of cell
    func setupLayoutConstraints()
    {
      
        img.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        img.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        img.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        NSLayoutConstraint.init(item: lbltitle, attribute: .left, relatedBy: .equal, toItem: contentView, attribute: .left, multiplier: 1, constant: 5).isActive = true
        NSLayoutConstraint.init(item: lbltitle, attribute: .right, relatedBy: .equal, toItem: contentView, attribute: .right, multiplier: 1, constant: 5).isActive = true
        NSLayoutConstraint.init(item: lbldesc, attribute: .left, relatedBy: .equal, toItem: contentView, attribute: .left, multiplier: 1, constant: 5).isActive = true
        NSLayoutConstraint.init(item: lbldesc, attribute: .right, relatedBy: .equal, toItem: contentView, attribute: .right, multiplier: 1, constant: 5).isActive = true
        NSLayoutConstraint.init(item: img, attribute: .height, relatedBy: .equal, toItem: lbltitle, attribute: .height, multiplier: 1, constant: 120).isActive = true
        NSLayoutConstraint.init(item: img, attribute: .bottom, relatedBy: .equal, toItem: lbltitle, attribute: .top, multiplier: 1, constant: -10).isActive = true
        NSLayoutConstraint.init(item: lbltitle, attribute: .bottom, relatedBy: .equal, toItem: lbldesc, attribute: .top, multiplier: 1, constant: -10).isActive = true
        NSLayoutConstraint.init(item: lbldesc, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: -10).isActive = true
  
    }
    
    //set cell data
    func setData(data: ListData)
    {
        lbltitle.text = data.title
        lbldesc.text = data.description
        
        //load image
        let url = URL(string: data.imageHref ?? "")
        let processor = DownsamplingImageProcessor(size: img.bounds.size)
                     |> RoundCornerImageProcessor(cornerRadius: 2)
        img.kf.indicatorType = .activity
        img.kf.setImage(
            with: url,
            placeholder: UIImage(named: ""),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        
    }
}
