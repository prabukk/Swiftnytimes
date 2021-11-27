//
//  ViewController.swift
//  Swiftnytimes
//
//  Created by prabu.karuppaiah on 26/11/21.
//

import UIKit
import Toast

class ViewController: UIViewController {
    
    let SEARCH_CHAR_SET_En = Constants.kSEARCH_CHAR_SET_En

    
    @IBOutlet fileprivate weak var documentTableView: UITableView!
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var filterBtnOut: UIButton!
    var urlString = String()
    
    @IBOutlet weak var topSearchView: UIView!
    @IBOutlet weak var topSearchBar: UISearchBar!
    @IBOutlet weak var searchViewCancelBtnOut: UIButton!
    @IBOutlet var searchBtnOut: UIButton!

    var newsData = NewsResponse()
    var mediaData = [MediaDetail]()
    var mediaMetaData = [MediaDataDetail]()
    var newsDataArray = [NewsDetail]()



    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.documentTableView.register(UINib(nibName: Constants.kNewsEventDocumentTableViewCell, bundle: nil), forCellReuseIdentifier: Constants.kNewsEventDocumentTableViewCell)
        
        self.filterView.layer.borderWidth = 1
        self.filterView.layer.borderColor = UIColor(red:222/255, green:225/255, blue:227/255, alpha: 1).cgColor
        filterBtnOut.isSelected = true
        
        if ReachabilityTest.isConnectedToNetwork()
        {
            urlString = Constants.baseurl + Constants.oneday
           self.getNYTimesdata()
            
        } else {
            self.view.makeToast(Constants.kNetwork)
        }
        
    }
    
    
    //MARK: FILTER

    @IBAction func filterbtnAction(_ sender: Any) {
        
        if filterBtnOut.isSelected == true {
            
            self.filterView.isHidden = false
            filterBtnOut.isSelected = false

        } else {
            self.filterView.isHidden = true
            filterBtnOut.isSelected = true

        }
        
    }
    
    @IBAction func filterOptionAction(_ sender: Any) {
        
        if (sender as AnyObject).tag == 0 {
            
            urlString = Constants.baseurl + Constants.oneday

        }else if (sender as AnyObject).tag == 1 {
            
            urlString = Constants.baseurl + Constants.sevenday
            
        }else if (sender as AnyObject).tag == 2 {
            
            urlString = Constants.baseurl + Constants.thirtyday

        }
        
        filterBtnOut.isSelected = true
        self.filterView.isHidden = true
        self.getNYTimesdata()

    }
    
    //MARK: SEARCH
    @IBAction func searchBtn(_ sender: Any) {
        
        if self.topSearchView.isHidden == false
        {
            self.topSearchView.isHidden = true
            searchBtnOut.isHidden = false
            self.view.endEditing(true)
        }else{
            self.topSearchView.isHidden = false
            searchBtnOut.isHidden = true

        }
    }
    
    @IBAction func searchViewCancelBtn(_ sender: Any) {
        
        topSearchBar.resignFirstResponder()
        searchBtnOut.isHidden = false
        
        self.topSearchView.isHidden = true
        self.topSearchBar.text = ""
        
        newsDataArray.removeAll()
        newsDataArray = self.newsData.results!
        self.documentTableView.reloadData()

    }

   
    //MARK: LOADER

    func callLoader()
    {
       self.createLoader()
       self.startAnimation()
   }

    //MARK: API CALL

    func getNYTimesdata() {
        
        self.callLoader()
        
         APIClient().request(method: HTTPMethod.get.rawValue, path: urlString) { (_, data, _) in
            
            if let data = data,data.count > 0, let result = String(data: data, encoding: .utf8) {
               
                let decoder = JSONDecoder()
                let newsDataLocal = try! decoder.decode(NewsResponse.self, from: data)
                
                if newsDataLocal != nil
                {
                    
                    self.newsDataArray.removeAll()
                    self.newsData = newsDataLocal
                    self.newsDataArray = self.newsData.results!
                    
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
    
       return newsDataArray.count
     
   }

   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.kNewsEventDocumentTableViewCell, for: indexPath) as? NewsEventDocumentTableViewCell else {
           preconditionFailure("Unregistered table view cell")
       }
        
       cell.titleLbl?.text = newsDataArray[indexPath.row].title
       cell.nameLbl?.text = newsDataArray[indexPath.row].byline
       cell.dateLbl?.text = newsDataArray[indexPath.row].published_date
       
       self.mediaData.removeAll()
       
       self.mediaData = newsDataArray[indexPath.row].media ?? []
       
      // print("media=====\(newsData.results![indexPath.row].medianew)")
       
       if newsDataArray[indexPath.row].media?.count != 0 {

           if newsDataArray[indexPath.row].media![0].mediametadata?[0].url != nil {
               cell.imgView.isHidden = false
               cell.imgView.downloaded(from: (newsDataArray[indexPath.row].media![0].mediametadata![0].url)!, contentMode: .scaleAspectFit)
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
       
       
       let storyBord = UIStoryboard(name: "Main", bundle: nil)
       let vc = storyBord.instantiateViewController(withIdentifier: "NewsDetailViewController")as! NewsDetailViewController
       vc.newsDataDetail = newsDataArray[indexPath.row]
       self.navigationController?.pushViewController(vc, animated: true)
   
    }
       
   }


extension ViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        didSelectSearchWithKey(key: searchBar.text!)
        searchBar.resignFirstResponder()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        didSelectSearchWithKey(key: searchBar.text!)
    }
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        
        if let searchText = searchBar.text, let textRange = Range(range, in: searchText) {
            if (text.contains("\n")){
                searchBar.resignFirstResponder()
                           return false
                       }
            let updatedText = searchText.replacingCharacters(in: textRange, with: text)
            
           
        if !(updatedText == updatedText.components(separatedBy: NSCharacterSet(charactersIn: SEARCH_CHAR_SET_En).inverted).joined(separator: "")) { return false }
            
            if updatedText.count > 25 {
                return false
            }
            if updatedText == " " || updatedText == "  "{
                return false
            }
            if (updatedText.contains("  ")){
                return false
            }
            
            if updatedText != "" && text != "\n" {
                didSelectSearchWithKey(key: updatedText)
            }
        }
        return true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
                searchBar.resignFirstResponder()
    }
    
    
    func didSelectSearchWithKey(key: String) {
        
        
        if key.count > 0 {
            
            var detailArray = [NewsDetail] ()

             detailArray = newsData.results!.filter {
                let string = $0.title as! String
                        return string.hasPrefix(key) }
            
            print("Array----\(detailArray)")
                
        //    filteredArray = filteredCountryArray(countryArray: videoArray, searchString: key)
                
            if((detailArray.count) > 0)
            {
                reloadTableData(arrayList: detailArray)
            }
            else
            {
                newsDataArray.removeAll()
                newsDataArray = self.newsData.results!
                reloadTableData(arrayList: newsDataArray)
            }
            
        } else {
          //  println_debug("Text field is cleared")
            reloadListViewAfterSwitch()
        }
    }
    
    // make it a function that takes everything it needs and returns a result array
       func filteredCountryArray(countryArray: [[String:String]], searchString: String) -> [[String:String]] {
              guard !searchString.isEmpty else {
                  // search string is blank so return entire array...
                  return countryArray
              }

              // Filter the data array and get only those countries that match the search text.
              return countryArray.filter { match in
                  // check array is long enough to get [1] out of it
                  guard match.count >= 2 else {
                      return false
                  }

              // let string = $0["Description"] as! String

                  let matchText = match["Description"]
                return matchText!.range(of: searchString, options: .caseInsensitive) != nil
              }
          }
    
    func reloadTableData(arrayList : [NewsDetail])
    {
        newsDataArray.removeAll()
        newsDataArray = arrayList
        documentTableView.reloadData()
    }
    
    func reloadListViewAfterSwitch()
    {
        
        newsDataArray.removeAll()
        newsDataArray = self.newsData.results!
        documentTableView.reloadData()

    }
    

}
