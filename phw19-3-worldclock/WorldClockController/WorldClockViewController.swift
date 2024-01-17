//
//  WorldClockViewController.swift
//  phw19-3-worldclock
//
//  Created by jasonhung on 2024/1/10.
//

import UIKit
import SafariServices

class WorldClockViewController: UIViewController {
    var cities = [City]() {
        didSet {
            AppDelegate.editButtonSetting(cities, editButton)
            City.saveCities(cities)
        }
    }

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var editButton: UIBarButtonItem!    
        
    override func viewDidLoad() {
        super.viewDidLoad()

        overrideUserInterfaceStyle = .dark
        
        if let cities = City.loadCities() {
            self.cities = cities
        }
               
        navigationItem.hidesBackButton = true
        navigationController?.navigationBar.prefersLargeTitles = true
        // 修改 Navigation Bar 背景色
        navigationController?.navigationBar.barTintColor = UIColor.darkGray.withAlphaComponent(0.8)  // 使用您想要的顏色
        navigationController?.navigationBar.tintColor = UIColor.orange  // 設定返回按鈕和其他元素的顏色
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]  // 設定標題的顏色
        
        
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .gray
        AppDelegate.editButtonSetting(cities, editButton)
        
        let timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.tableView.isEditing ? nil : self.tableView.reloadData()
        }
        timer.fire()
        
    }
    
    @IBAction func editList(_ sender: UIBarButtonItem) {
        tableView.setEditing(!tableView.isEditing, animated: true)
        sender.title = tableView.isEditing ? "Done" : "Edit"
        tableView.reloadData()
    
    }
        
     @IBAction func unwindToWorldView(_ unwindSegue: UIStoryboardSegue) {
         if let sourceViewController = unwindSegue.source as? CityViewController,
            let city = sourceViewController.city {
             
             cities.insert(city, at: cities.count)
             let indexPath = IndexPath(row: cities.count-1, section: 0)
             tableView.insertRows(at: [indexPath], with: .automatic)
         }
    }
    
    @IBAction func cityWiki(_ sender: UIButton) {
       
        if let url = URL(string: "https://zh.wikipedia.org/zh-tw/\(sender.titleLabel?.text ?? "")") {
            let safariViewController = SFSafariViewController(url: url)
            
            // 設定瀏覽器視圖的樣式
            safariViewController.preferredControlTintColor = UIColor.white
            safariViewController.preferredBarTintColor = UIColor.black  // 這是設定瀏覽器的背景色
            
            // 以 modal 形式呈現
            safariViewController.modalPresentationStyle = .pageSheet  // 使用 .fullScreen 可以覆蓋整個螢幕，而 .overFullScreen 可以保留底層視圖
            
            safariViewController.delegate = self
            present(safariViewController, animated: true, completion: nil)
        }
    }
    
    
}



extension WorldClockViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "\(WorldClockTableViewCell.self)", for: indexPath) as! WorldClockTableViewCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(WorldClockzhTWTableViewCell.self)", for: indexPath) as! WorldClockzhTWTableViewCell
        
        let city = cities[indexPath.row]
        cell.cityLabel.text = city.cityName
        cell.cityZhTWLabel.text = city.cityNameZhTW
        cell.cityZhTWButton.titleLabel?.text = city.cityNameZhTW

        cell.relativeDateLabel.text = city.relativeDate
        if city.relativeDate == "Today" {
            cell.relativeDateLabel.backgroundColor = UIColor.clear

        }else{
            cell.relativeDateLabel.backgroundColor = UIColor.gray.withAlphaComponent(0.6)
            cell.relativeDateLabel.layer.cornerRadius = 10
            cell.relativeDateLabel.clipsToBounds = true
            cell.relativeDateLabel.layer.masksToBounds = true
        }
        
        cell.relativeHoursLabel.text = city.relativeHours
        if tableView.isEditing {
            cell.timeLabel.isHidden = true
        } else {
            cell.timeLabel.text = city.localTime
            cell.timeLabel.isHidden = false
        }
        
       // cell.backgroundColor = UIColor.blue
        
        return cell
    }
    
    //Editable
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        
        switch editingStyle {
        case .delete:
            cities.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        case .insert: return
        case .none:
            tableView.allowsSelectionDuringEditing = true
        default: return
        }
   
        
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        
        UITableViewCell.EditingStyle.delete
    }
    

    //Movable
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let city = cities[sourceIndexPath.row]
        cities.remove(at: sourceIndexPath.row)
        cities.insert(city, at: destinationIndexPath.row)
    }
    
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}


extension WorldClockViewController: SFSafariViewControllerDelegate{
    
}

