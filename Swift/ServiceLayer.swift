//
//  ServiceLayer.swift
//
//  Created by Adil Umer on 30.10.2020.
//

import Foundation

typealias completion = (_ err: Any?, _ resp: Any?, _ data: Any?) -> Void
typealias completionData = (_ data: [String:Any]?) -> Void
typealias completionBool = (_ success: Bool) -> Void
typealias completionVoid = () -> Void

class ServiceLayer: NSCoder{
    static let formatter = DateFormatter()
    //static var task: URLSessionTask?
    
    class func post(urlStr: String, postData: [String: Any], _ callback: @escaping completion){
        let jsonData = try? JSONSerialization.data(withJSONObject: postData)
        let url = URL(string: urlStr)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            let cookieName = ""
            if let cookie = HTTPCookieStorage.shared.cookies?.first(where: { $0.name == cookieName }) {
                formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                let aMonthFromNow = Calendar.current.date(byAdding: .day, value: 30, to: Date())!
                let expiryDate = cookie.expiresDate ?? aMonthFromNow
                apiSidExpiry = formatter.string(from: expiryDate)
                apiSid = cookie.value
                //debugPrint("\(cookieName): \(cookie.value)")
            }
            
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data", response ?? "")
                callback(error, response, nil)
                return
            }
            
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                callback(error, response, responseJSON)
                //print(responseJSON)
            }
            
            if !urlStr.contains("login") && !urlStr.contains("logout"){
                return
            }
            
            /*
            guard let cookieUrl = response?.url,
                  let httpResponse = response as? HTTPURLResponse,
                  let fields = httpResponse.allHeaderFields as? [String: String]
            else { return }
            let cookies = HTTPCookie.cookies(withResponseHeaderFields: fields, for: cookieUrl)
                HTTPCookieStorage.shared.setCookies(cookies, for: url, mainDocumentURL: nil)
                for cookie in cookies {
                    var cookieProperties = [HTTPCookiePropertyKey: Any]()
                    cookieProperties[.name] = cookie.name
                    cookieProperties[.value] = cookie.value
                    cookieProperties[.domain] = cookie.domain
                    cookieProperties[.path] = cookie.path
                    cookieProperties[.version] = cookie.version
                    cookieProperties[.expires] = Date().addingTimeInterval(31536000)

                    let newCookie = HTTPCookie(properties: cookieProperties)
                    HTTPCookieStorage.shared.setCookie(newCookie!)

                    print("name: \(cookie.name) value: \(cookie.value)")
                }*/
            
        }
        task.resume()
    }
    
    class func get(urlStr: String, query: [String: String], _ callback: @escaping completion){
        var components = URLComponents(string: urlStr)!
        components.queryItems = query.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,
                  let resp = response as? HTTPURLResponse,
                  (200..< 400) ~= resp.statusCode,
                  error == nil else {
                
                //print(error, response)
                callback(error, response, nil)
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                callback(error, response, responseJSON)
                //print(responseJSON)
            }
        }
        task.resume()
        
    }
    
    
    
    
}
