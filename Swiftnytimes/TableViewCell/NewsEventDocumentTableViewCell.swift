//
//  NewsEventDocumentTableViewCell.swift
//  Swiftnytimes
//
//  Created by prabu.karuppaiah on 26/11/21.
//

import UIKit

protocol documentcustomDlegate {
    func documentplay(number:Int)
}

class NewsEventDocumentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgView: UIImageView!

      @IBOutlet weak var titleLbl : UILabel?
      @IBOutlet weak var dateLbl : UILabel?
      @IBOutlet weak var nameLbl : UILabel?

      @IBOutlet weak var borderView: UIView!

      override func awakeFromNib() {
          super.awakeFromNib()
          // Initialization code
      }
      
      var documentdelegate : documentcustomDlegate?

      override func setSelected(_ selected: Bool, animated: Bool) {
          super.setSelected(selected, animated: animated)

          // Configure the view for the selected state
      }
      

}
