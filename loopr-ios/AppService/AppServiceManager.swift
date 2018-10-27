//
//  AppServiceManager.swift
//  loopr-ios
//
//  Created by xiaoruby on 10/14/18.
//  Copyright © 2018 Loopring. All rights reserved.
//

import Foundation

class AppServiceManager {
    
    static let shared = AppServiceManager()

    var latestBuildVersion: String = "0.0.1"
    var latestBuildDescription: String?
    
    private init() {
        
    }

    // Current build version
    func getBuildVersion() -> String {
        let build = Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as! String
        return build
    }
    
    func getAppVersionAndBuildVersion() -> String {
        let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
        let build = Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as! String
        return version + " (" + build + ")"
    }

    func getLatestAppVersion(completion: @escaping (_ shouldDisplayUpdateNotification: Bool) -> Void) {
        // Seprate from Request.
        let url = URL(string: "https://www.loopring.mobi/api/v1/app_versions")
        let task = URLSession.shared.dataTask(with: url! as URL) { data, _, error in
            guard let data = data, error == nil else {
                print("error=\(String(describing: error))")
                return
            }
            let json = JSON(data)
            let appVersions = json["app_versions"]
            for subJson in appVersions.arrayValue {
                let latestBuildVersion = subJson["version"].string ?? "0.0.1"
                let currentBuildVersion = self.getBuildVersion()
                let largestSkipBuildVersion = self.getLargestSkipBuildVersion()
                if latestBuildVersion.compare(currentBuildVersion, options: .numeric) == .orderedDescending && latestBuildVersion != currentBuildVersion && latestBuildVersion.compare(largestSkipBuildVersion, options: .numeric) == .orderedDescending && latestBuildVersion != largestSkipBuildVersion {
                    print("latestBuildVersion version is newer")
                    self.latestBuildVersion = latestBuildVersion
                    self.latestBuildDescription = subJson["description"].string
                    completion(true)
                } else {
                    completion(false)
                }
                break
            }
        }
        task.resume()
    }
    
    func getLargestSkipBuildVersion() -> String {
        let defaults = UserDefaults.standard
        return defaults.string(forKey: UserDefaultsKeys.largestSkipBuildVersion.rawValue) ?? "0.0.1"
    }

    func setLargestSkipBuildVersion() {
        let defaults = UserDefaults.standard
        defaults.set(latestBuildVersion, forKey: UserDefaultsKeys.largestSkipBuildVersion.rawValue)
    }

    // Endpoint /api/v1/users
    func getUserConfig(completion: @escaping (_ shouldDisplayUpdateNotification: Bool) -> Void) {
        // Seprate from Request.
        let url = URL(string: "https://www.loopring.mobi/api/v1/users")
        let task = URLSession.shared.dataTask(with: url! as URL) { data, _, error in
            guard let data = data, error == nil else {
                print("error=\(String(describing: error))")
                return
            }
            let json = JSON(data)
            let language = json["language"].string
            let currency = json["currency"].string
            print("language: \(String(describing: language))")
            print("currency: \(String(describing: currency))")
            completion(true)
        }
        task.resume()
    }
    
    func updateUserConfig(completion: @escaping (_ shouldDisplayUpdateNotification: Bool) -> Void) {
        
        // Example to update the user config.
        var body = JSON()
        body["account_token"] = "123456"
        body["language"] = "Chinese"
        body["currency"] = "USD"
        
        var request = URLRequest(url: URL(string: "https://www.loopring.mobi/api/v1/users")!)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "PUT"
        
        do {
            try request.httpBody = body.rawData()
        } catch {
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("error=\(String(describing: error))")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
            }
            
            completion(false)
        }
        task.resume()
    }

}