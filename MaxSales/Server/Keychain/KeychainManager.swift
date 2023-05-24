//
//  KeychainManager.swift
//  MaxSales
//
//  Created by Fabio Miciano on 14/02/23.
//

import Foundation
import Security

final class KeychainManager {
    func saveAutoLogin(cpf: String, password: String) {
        let value = "\(cpf)|\(password)"
        set(key: "autologin", value: value)
    }
    
    func getAutoLogin() -> [String]? {
        guard let autologin = get(key: "autologin") else { return nil }
        let splited = autologin.split(separator: "|")
        let loginValue = splited.compactMap {
            return "\($0)"
        }
        
        return loginValue
    }
    
    func removeAutoLogin() {
        delete(key: "autologin")
    }
    
    func set(key: String, value: String) {
        guard let dataValue = value.data(using: .utf8) else { return }
        let attributes: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecValueData as String: dataValue
        ]
        
        SecItemAdd(attributes as CFDictionary, nil)
    }
    
    func get(key: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnAttributes as String: true,
            kSecReturnData as String: true,
        ]
        
        var item: CFTypeRef?
        
        if SecItemCopyMatching(query as CFDictionary, &item) == noErr {
            if let existingItem = item as? [String: Any],
               let valueData = existingItem[kSecValueData as String] as? Data,
               let value = String(data: valueData, encoding: .utf8) {
                return value
            } else {
                return nil
            }
        }
        
        return nil
    }
    
    func delete(key: String) {
        let attributes: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key
        ]
        
        SecItemDelete(attributes as CFDictionary)
    }
}
