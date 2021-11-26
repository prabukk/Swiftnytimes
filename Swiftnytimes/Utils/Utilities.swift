//
//  Utilities.swift
//  Swiftnytimes
//
//  Created by prabu.karuppaiah on 26/11/21.
//

import Foundation
import UIKit
import AVKit
//import AVFoundation
import NVActivityIndicatorView


let activityIndicatorType = NVActivityIndicatorType.ballBeat
let indicatorView = NVActivityIndicatorView.init(frame: CGRect(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2-30, width: 60, height: 60), type: activityIndicatorType, color: colors.main, padding: 55)


extension UIViewController{
    
    func createLoader(){
        DispatchQueue.main.async {
             indicatorView.isHidden = false
                   indicatorView.center = self.view.center
                   self.view.addSubview(indicatorView)
        }
       
    }
    
    func startAnimation() {
        DispatchQueue.main.async {
        indicatorView.backgroundColor = UIColor.clear
//       indicatorView.layer.cornerRadius = 2.0
        indicatorView.startAnimating()
        UIApplication.shared.keyWindow?.rootViewController?.view.isUserInteractionEnabled = false
        self.view.isUserInteractionEnabled = false
        }
    }
    func stopAnimation() {
        DispatchQueue.main.async {
            indicatorView.stopAnimating()
            UIApplication.shared.keyWindow?.rootViewController?.view.isUserInteractionEnabled = true
            self.view.isUserInteractionEnabled = true
          
        }
    }

    
}


struct colors{
    
    static let main = UIColor(red: 16.0/255.0, green: 31.0/255.0, blue: 98.0/255.0, alpha: 1.0)
   
}

extension String {
    func toImage() -> UIImage? {
        if let data = Data(base64Encoded: self, options: .ignoreUnknownCharacters){
            return UIImage(data: data)
        }
        return nil
    }
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

extension UIImageView {
  public func maskCircle() {
    self.contentMode = UIView.ContentMode.scaleAspectFill
    self.layer.cornerRadius = self.frame.height / 2
    self.layer.masksToBounds = false
    self.clipsToBounds = true

   // make square(* must to make circle),
   // resize(reduce the kilobyte) and
   // fix rotation.
   //self.image = anyImage
  }
}
