//
//  City.swift
//  phw19-3-worldclock
//
//  Created by jasonhung on 2024/1/10.
//

import Foundation

struct City: Codable {
    var knownTimeZoneIdentifier: String
    init(knownTimeZoneIdentifier: String) {
        self.knownTimeZoneIdentifier = knownTimeZoneIdentifier   // "Africa/Accra"
        //print("struct City - init - self.knownTimeZoneIdentifier = \(self.knownTimeZoneIdentifier)")
    }
    
    var cityName: String {
        // 透過分割識別碼取得城市名稱，例如 "Africa/Addis_Ababa" split後取 "Addis_Ababa 再把_去除"
        // Africa/Addis_Ababa"  => Addis Ababa   // 阿迪斯阿貝巴是東部非洲國家衣索比亞的首都和最大城市
        
        return String(knownTimeZoneIdentifier.split(separator: "/").last!).replacingOccurrences(of: "_", with: " ")
    }
    var cityNameZhTW: String {
        if let cityNametw = cityMapping[cityName] {
            return cityNametw
        }
        // 如果找不到對應的中文名稱，返回原始的英文城市名稱
        return cityName
    }

    var relativeHours: String {
        // 計算相對於當前時區的時間差
        let timeInterval = TimeZone(identifier: knownTimeZoneIdentifier)!.secondsFromGMT() - TimeZone.current.secondsFromGMT()
        let hours = timeInterval / 3600
        return "\(hours.signum() == 1 ? "+" : "")\(String(format: "%.1d", hours))\(abs(hours) == 1 ? "HR" : "HRS")"
    }

    var relativeDate: String {
        // 格式化相對日期
//                let dateFormater = DateFormatter()
//                dateFormater.timeStyle = .none
//                dateFormater.dateStyle = .medium
//                dateFormater.timeZone = TimeZone(identifier: knownTimeZoneIdentifier)
//                dateFormater.doesRelativeDateFormatting = true
//        
//                return dateFormater.string(from: .now)
        
        
        
        return relativeDateDescription(knownTimeZoneIdentifier: knownTimeZoneIdentifier)
        
        
    }
    
    
    
    func relativeDateDescription(knownTimeZoneIdentifier: String) -> String {
        // 創建一個 DateFormatter 用於格式化日期
        let dateFormatter = DateFormatter()
        // 設定日期格式
        dateFormatter.dateFormat = "yyyy-MM-dd"

        // 設定 dateFormatter 的時區為當前時區，並獲取當前日期的字符串表示
        dateFormatter.timeZone = .current
        let yourTimeZone = dateFormatter.string(from: Date())
        

        // 將 dateFormatter 的時區更改為函數參數指定的城市時區
        dateFormatter.timeZone = TimeZone(identifier: knownTimeZoneIdentifier)
        // 然後獲取該時區的當前日期的字符串表示
        let cityTimeZone = dateFormatter.string(from: Date())

        // 使用 Calendar 來處理日期
        let calendar = Calendar.current

        // 將日期字符串轉換回日期對象，這裡需要確保字符串的格式與 dateFormatter 設定的格式匹配
        guard let yourZoneDate = dateFormatter.date(from: yourTimeZone),
              let cityZoneDate = dateFormatter.date(from: cityTimeZone) else {
            // 如果無法進行轉換，返回錯誤信息
            return "Error in date conversion"
        }
        //print("yourZoneDate = \(yourZoneDate)")   //yourZoneDate = 2024-01-17 04:00:00 +0000
        //print("cityZoneDate = \(cityZoneDate)")   //cityZoneDate = 2024-01-16 04:00:00 +0000

        // 計算兩個日期之間的天數差異
        let daysDiff = calendar.dateComponents([.day], from: yourZoneDate, to: cityZoneDate).day!

        // 根據天數差異決定返回的字符串
        switch daysDiff {
        case 0:
            return "Today" // 如果沒有差異，表示為「今天」
        case 1:
            return "Tomorrow" // 如果差異為一天，表示為「明天」
        case -1:
            return "Yesterday" // 如果差異為負一天，表示為「昨天」
        default:
            // 根據天數差異返回相對日期描述
            if daysDiff > 0 {
                return "In \(daysDiff) days"
            } else {
                return "\(abs(daysDiff)) days ago"
            }
        }
    }
    

    var localTime: String {
        // 格式化本地時間
        let dateFormater = DateFormatter()
        dateFormater.timeStyle = .short
        dateFormater.timeZone = TimeZone(identifier: knownTimeZoneIdentifier)
        dateFormater.dateFormat = "HH:mm"
        return dateFormater.string(from: .now)
    }
    
    static func loadCities() -> [City]? {
        // 從 UserDefaults 中載入城市資料
        let userDefault = UserDefaults.standard
        guard let data = userDefault.data(forKey: "cities") else { return nil }
        let decoder = JSONDecoder()
        return try? decoder.decode([City].self, from: data)
    }
    
    static func saveCities(_ cities: [City]) {
        // 將城市資料存入 UserDefaults
        let encoder = JSONEncoder()
        guard let data = try? encoder.encode(cities) else { return }
        UserDefaults.standard.set(data, forKey: "cities")
    }    
}


