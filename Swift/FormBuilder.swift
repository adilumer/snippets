//
//  FormBuilder.swift
//
//  Created by Adil Umer on 8.09.2020.
//  Copyright © 2020. All rights reserved.
//

import Foundation

class FormBuilder: NSObject{
    
    static func buildFormJS(postUrl: String, params: [String: String]) -> String{
        var data = ""
        let encoder = JSONEncoder()
        if let jsonData = try? encoder.encode(params) {
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                data = jsonString
            }
        }
        
        let jsStr = """
    function postForm(params, url){
      
      document.cookie = "api.sid='\(apiSid!)'; expires='\(apiSidExpiry!)';path='/'";
      var form = document.createElement("form");
      form.setAttribute("method", "POST");
      form.setAttribute("action", url);

      for (const key in params){
        const hiddenField = document.createElement('input')
        hiddenField.type = 'hidden'
        hiddenField.name = key
        hiddenField.value = params[key]
        form.appendChild(hiddenField)
      }
      document.body.appendChild(form)

      form.submit()
    }
    
    postForm(\(data),"\(postUrl)")
    """
        
        return jsStr
        
    }
    
    
}

class tawkWrapper:NSObject{
    
    static var jsStr =
"""
"""
    
}
