//
//  Persistence.swift
//
//  Created by Adil Umer on 8.09.2020.
//  Copyright © 2020. All rights reserved.
//

import Foundation

class UserRepo{
    
    class func saveData(_ userData: [String: Any]){
        for (key, data) in userData{
            let defaultsKey = "User"+key
            UserDefaults.standard.set(data, forKey: defaultsKey)
        }
        UserDefaults.standard.synchronize()
    }
    
    class func readStr(_ key: String)->String{
        return UserDefaults.standard.string(forKey: "User"+key) ?? ""
    }
    
    class func readObj(_ key: String)->Any{
        return UserDefaults.standard.object(forKey: "User"+key) ?? NSObject()
    }
    
    class func readArray(_ key: String)->[Any]{
        return UserDefaults.standard.array(forKey: "User"+key) ?? []
    }
    
    class func readDict(_ key: String)->[String:Any]{
        return UserDefaults.standard.dictionary(forKey: "User"+key) ?? [String:Any]()
    }
    
    class func readBool(_ key: String)->Bool{
        return UserDefaults.standard.bool(forKey: "User"+key)
    }
    
    
    class func delete(_ keys: [String]){
        for key in keys{
            UserDefaults.standard.removeObject(forKey: "User"+key)
        }
        UserDefaults.standard.synchronize()
    }
    
}
