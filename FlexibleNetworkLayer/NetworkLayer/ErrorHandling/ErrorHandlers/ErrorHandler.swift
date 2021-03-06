//
//  ErrorHandler.swift
//  FlexibleNetworkLayer
//
//  Created by Isa Aliev on 19.02.18.
//  Copyright © 2018 IA. All rights reserved.
//

import Foundation

protocol ErrorHandler {
    var errorTypeHandler: ErrorTypeHandler { get set }
    
    func handleError(_ error: ErrorRepresentable)
}
