//
//  FileUpload.swift
//
//  Created by Adil Umer on 8.09.2020.
//  Copyright © 2020. All rights reserved.
//

import Foundation
import CoreServices

public enum fileTypes: String{
    
    case cover = "3"
    case media = "2"
    case cv = "1"
    case profilePic = "0"
    
}

class FileUpload: NSObject{
    
    static let pdfFileType = kUTTypePDF as String
    static let jpgFileType = kUTTypeJPEG as String
    static let pngFileType = kUTTypePNG as String
    static let mpFileType = kUTTypeMPEG4 as String
    static let allowedMimes:[fileTypes:[String]] = [
        .cover:[jpgFileType, pngFileType, "image/jpeg", "image/png"],
        .cv:[pdfFileType, "application/pdf"],
        .profilePic:[jpgFileType, pngFileType, "image/jpeg", "image/png"],
        .media:[jpgFileType, pngFileType, mpFileType, "image/jpeg", "image/png", "video/mp4"]
    ]
   
    class func request(type: fileTypes, name: String, file: Data, mime: String,_ callback: @escaping completionBool) {
        //print(mime, name)

        let stringUrl = apiUrl + ApiServices.saveAsset.rawValue
        guard let url = URL(string: stringUrl) else { return }
        
        let boundary = UUID().uuidString
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        var data = Data()
        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        data.append("Content-Disposition: form-data; name=\"doc\"; filename=\"\(name)\"\r\n".data(using: .utf8)!)
        data.append("Content-Type: \(mime)\r\n\r\n".data(using: .utf8)!)
        data.append(file)
        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        data.append("Content-Disposition: form-data; name=\"type\"\r\n\r\n".data(using: .utf8)!)
        data.append("\(type.rawValue)".data(using: .utf8)!)
        data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        //print(String(data: data, encoding: .utf8) ?? "DATA NOT CONVERTIBLE TO STRING")
        session.uploadTask(with: request, from: data, completionHandler: { rData, response, error in
            guard let rData = rData, error == nil else {
                print(error?.localizedDescription ?? "No data", response ?? "")
                callback(false)
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: rData, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                let responseData = responseJSON["data"] as? [String: Any] ?? [:]
                let fileUrl = responseData["url"] as? String ?? ""
                if type == .profilePic{
                    userPhoto = fileUrl
                    activeUser?.photoURL = fileUrl
                }else if type == .cover{
                    activeUser?.coverURL = fileUrl
                }
                callback(true)
            }else{
                callback(false)
            }

        }).resume()

    }
}
