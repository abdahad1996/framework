//
//  Api.swift
//  MYFRAMEWORK
//
//  Created by Digital Dividend on 12/11/20.
//

import Foundation

public protocol request{
    func load() -> String
   
}
public class Api: request {
    public func load() -> String {
        return "request loaded "
    }
}
