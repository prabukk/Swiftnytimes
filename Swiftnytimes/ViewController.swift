//
//  ViewController.swift
//  Swiftnytimes
//
//  Created by prabu.karuppaiah on 26/11/21.
//

import UIKit
import Toast

class ViewController: UIViewController {
    
    @IBOutlet fileprivate weak var documentTableView: UITableView!
    var newsData = NewsResponse()
    var mediaData = [MediaDetail]()
    var mediaMetaData = [MediaDataDetail]()


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.documentTableView.register(UINib(nibName: Constants.kNewsEventDocumentTableViewCell, bundle: nil), forCellReuseIdentifier: Constants.kNewsEventDocumentTableViewCell)
        
        if ReachabilityTest.isConnectedToNetwork()
        {
           self.getNYTimesdata()
        } else {
            self.view.makeToast(Constants.kNetwork)
        }
        
    }
    
    func callLoader()
    {
       self.createLoader()
       self.startAnimation()
   }

    func getNYTimesdata() {
        
        self.callLoader()
        var urlString = String()
        urlString = Constants.baseurl + Constants.sevenday
         //print("urlstring------\(urlString)")
        
         APIClient().request(method: HTTPMethod.get.rawValue, path: urlString) { (_, data, _) in
            
            if let data = data,data.count > 0, let result = String(data: data, encoding: .utf8) {
                //print("All Result-----\(result)")
               
                let decoder = JSONDecoder()
                let newsDataLocal = try! decoder.decode(NewsResponse.self, from: data)
                
                if newsDataLocal != nil
                {
                    //print("newsData===\(newsDataLocal)")
                    
                    self.newsData = newsDataLocal
                    
                    DispatchQueue.main.async {
                        self.documentTableView.dataSource = self
                        self.documentTableView.delegate = self
                        self.documentTableView.reloadData()
                    }
                    
                }
                else{
                    self.view.makeToast(Constants.kNoData)
                }
               
                self.stopAnimation()
            }
        }
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {

   func numberOfSections(in tableView: UITableView) -> Int {
       return 1
   }

   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
       return newsData.results!.count
     
   }

   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.kNewsEventDocumentTableViewCell, for: indexPath) as? NewsEventDocumentTableViewCell else {
           preconditionFailure("Unregistered table view cell")
       }
        
       cell.titleLbl?.text = newsData.results![indexPath.row].title
       cell.nameLbl?.text = newsData.results![indexPath.row].byline
       cell.dateLbl?.text = newsData.results![indexPath.row].published_date
       
       self.mediaData.removeAll()
       
       self.mediaData = newsData.results![indexPath.row].media ?? []
       
      // print("media=====\(newsData.results![indexPath.row].medianew)")
       
       if newsData.results![indexPath.row].media?.count != 0 {

           if newsData.results![indexPath.row].media![0].mediametadata?[0].url != nil {
               cell.imgView.isHidden = false
               cell.imgView.downloaded(from: (newsData.results![indexPath.row].media![0].mediametadata![0].url)!, contentMode: .scaleAspectFit)
           } else {
               
               cell.imgView.image = nil
               cell.imgView.maskCircle()
               cell.imgView.backgroundColor = UIColor.gray
           }

       } else {
           
           cell.imgView.image = nil
           cell.imgView.maskCircle()
           cell.imgView.backgroundColor = UIColor.gray
       }
       

      return cell
    
   }
    
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    print("Didselectrow=======")
   
    }
       
   }
