//
//  NewsDetailViewController.swift
//  Swiftnytimes
//
//  Created by prabu.karuppaiah on 27/11/21.
//

import UIKit

class NewsDetailViewController: UIViewController {
    @IBOutlet weak var detailLbl: UILabel!
    @IBOutlet weak var newDetailTextview: UITextView!
    var newsDataDetail = NewsDetail()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        detailLbl?.text = newsDataDetail.title
        newDetailTextview.text = newsDataDetail.abstract
    }
    

    @IBAction func backBtn(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
