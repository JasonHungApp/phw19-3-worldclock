//
//  CityViewController.swift
//  phw19-3-worldclock
//
//  Created by jasonhung on 2024/1/10.
//

import UIKit

class CityViewController: UIViewController {
    
    var city: City?

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tabbleView: UITableView!
    
    
    
    var cityDictionary = [String: [City]]()
    var citySectionTitles = [String]()
    //let knownTimeZoneIdentifiers = TimeZone.knownTimeZoneIdentifiers
         //["Africa/Abidjan", "Africa/Accra", "Africa/Addis_Ababa", ...]
    
      var cities = [City]()
    
    var isSearching = false
    var searchedCities = [City]()
         
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        
        //準備時區資料
        setCities()
  
        //首字母當成 section 的 title
        citySectionTitles = [String](cityDictionary.keys)
        citySectionTitles = citySectionTitles.sorted(by: < )
        
        //設定搜尋列
        setSearchBar()
       
    }
    
    func myPrint(count:Int, msg:Any){
        let maxCount = 5   //500
        if count < maxCount {
            print(msg)
        }
    }
    
    func setSearchBar(){
        searchBar.delegate = self
        searchBar.showsCancelButton = true
        if let cancelButton = searchBar.value(forKey: "cancelButton") as? UIButton {
            cancelButton.isEnabled = true
        }
    }
    
    func setCities(){
        // Build array of city struct   // 建立城市結構體的陣列
        //print("TimeZone.knownTimeZoneIdentifiers = ")
        //print(TimeZone.knownTimeZoneIdentifiers)
        
        for knownTimeZoneIdentifier in TimeZone.knownTimeZoneIdentifiers {
            
            //print(knownTimeZoneIdentifier)
            let city = City(knownTimeZoneIdentifier: knownTimeZoneIdentifier)
            cities.append(city)
            
           print( String(knownTimeZoneIdentifier.split(separator: "/").last!).replacingOccurrences(of: "_", with: " "))
        }
        
        // Build dictionary of timeZone city // 建立時區字典
        var printCount = 0
        //print("city.cityName = ")

        for city in cities {
            printCount += 1
            // 取得城市名稱的首字母
            let cityKey = String(city.cityName.prefix(1))
            //print("\(city.cityName)")
            myPrint(count: printCount, msg: "city.cityName = \(city.cityName)")
            myPrint(count: printCount, msg: "city.cityName_zhTW = \(city.cityNameZhTW)")
            //myPrint(count: printCount, msg: "cityKey = \(cityKey)")
            // 如果字典中已經有這個首字母對應的城市陣列，則將城市加入該陣列
            if var cityValues = cityDictionary[cityKey] {
                cityValues.append(city)
                cityDictionary[cityKey] = cityValues
                //myPrint(count: printCount, msg: "cityDictionary[cityKey]! append = ")
                //myPrint(count: printCount, msg: cityDictionary[cityKey]!)

            } else {
                // 如果字典中還沒有這個首字母，則建立一個包含該城市的陣列
                cityDictionary[cityKey] = [city]
               // myPrint(count: printCount, msg: "cityDictionary[cityKey]! = ")
               // myPrint(count: printCount, msg: cityDictionary[cityKey]!)

            }
        }
    }
    
    
    //準備返回前一個viewcontroller, 把城巿值設定好
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if isSearching {
            guard let row = tabbleView.indexPathForSelectedRow?.row else { return }
            city = searchedCities[row]
        } else {
            guard let row = tabbleView.indexPathForSelectedRow?.row else { return }
                if let section = tabbleView.indexPathForSelectedRow?.section {
                    let cityValue = citySectionTitles[section]
                    let cityKeys = cityDictionary[cityValue]
                    city = cityKeys![row]
                }
        }
    }
}

// MARK: - UITableViewDataSource
extension CityViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if isSearching {
            return 1
        } else {
            return citySectionTitles.count
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isSearching {
            return searchedCities.count
            
        } else {
            let cityKey =  citySectionTitles[section]
            if let cityValues = cityDictionary[cityKey] {
                return cityValues.count
            }
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(CityTableViewCell.self)", for: indexPath) as! CityTableViewCell
                
        var city: City?
        
        if isSearching {
            city = searchedCities[indexPath.row]
        } else {
            let cityKey = citySectionTitles[indexPath.section]
            if let cityValue = cityDictionary[cityKey] {
                city = cityValue[indexPath.row]
            }
        }
        
        cell.cityLabel.text = city?.cityName
        if let cityName = city?.cityName,
           let cityNameZhTW = city?.cityNameZhTW{
            cell.cityLabel.text = "\(cityName) (\(cityNameZhTW))"
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return isSearching ? nil : citySectionTitles[section]
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return isSearching ? nil : citySectionTitles
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK: - UISearchBarDelegate

extension CityViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        // 根據搜尋文字過濾城市
        // filter 方法是一個高階函數，接受一個閉包作為參數，這個閉包定義了過濾的條件。
        // 這個閉包中的 $0 代表 cities 數組中的每一個元素。
        // 所以，這個表達式的意思是選擇那些城市名稱（cityName）以輸入的搜尋文字（searchText）開頭的城市。
        
        searchedCities = cities.filter { $0.cityName.lowercased().prefix(searchText.count) == searchText.lowercased() }
        isSearching = true

        // 重新載入表格視圖以顯示搜尋結果
        tabbleView.reloadData()
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {

        // 取消搜尋，清空搜尋文字，並退出搜尋模式
        isSearching = false
        searchBar.searchTextField.text = ""
        self.dismiss(animated: true, completion: nil)
    }
}
