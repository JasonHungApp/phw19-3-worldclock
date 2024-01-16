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
        let dateFormater = DateFormatter()
        dateFormater.timeStyle = .none
        dateFormater.dateStyle = .medium
        dateFormater.timeZone = TimeZone(identifier: knownTimeZoneIdentifier)
        dateFormater.doesRelativeDateFormatting = true
        return dateFormater.string(from: .now)
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


