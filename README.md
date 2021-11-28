# Swiftnytimes
NYTimesAPIcall

#Introduction
-------------

* Newyork Times API page login , the enable NY Times most populor API and generate the apI key in this site.
* NY Times most popular API , media-metadata this key not able to codable , so we can not able to display the image. 

* Main page default i call the API with oneday data , it will listed in tableview with custom cell  display details like title , by , date.
* Filter option have in the navigation bar , it display drop down pop to select the one day , weekly , monthly option based on user choose i will call the API and list the data in tableview.
* Search option if user select means search bar will display we able filter the list based on title.
* News detail page will diplay the title and abstraction.

#Installation
-------------

* Pod file we have to added this porject.
* Package Dependencies also added.

#Framework 
----------

* Alamofire and SwiftyJSON framework used for the API call.
* NVActivityIndicatorView framework used the loader activity.
* Toast framework used for show the alert message.

#Test Case
----------

* XCTest i have checked after the API call the array is nil or not.
* XCUITest i have the flow of the filter and Newsdetail page.
