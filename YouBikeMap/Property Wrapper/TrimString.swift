//
//  TrimString.swift
//
//  Created by Eden on 23/7/20.
//  Copyright © 2023 Darktt. All rights reserved.
//

import UIKit

@frozen @propertyWrapper
public
struct TrimString
{
    // MARK: - Properties -
    
    public
    var wrappedValue: String {
        
        get {
            
            self.value
        }
        
        set {
            
            if case let .prefix(prefix) = self.setting, newValue.hasPrefix(prefix) {
                
                self.value = String(newValue.dropFirst(prefix.count))
            }
            
            if case let .suffix(suffix) = self.setting, newValue.hasSuffix(suffix) {
                
                self.value = String(newValue.dropLast(suffix.count))
            }
            
            if case let .replace(original, replacement) = self.setting {
                
                self.value = newValue.replacingOccurrences(of: original, with: replacement)
            }
        }
    }
    
    private
    var setting: Setting
    
    private
    var value: String = ""
    
    // MARK: - Methods -
    // MARK: Initial Method
    
    public
    init(trimSetting setting: Setting)
    {
        self.setting = setting
    }
}

public
extension TrimString
{
    enum Setting
    {
        case prefix(String)
        
        case suffix(String)
        
        case replace(String, String)
    }
}
