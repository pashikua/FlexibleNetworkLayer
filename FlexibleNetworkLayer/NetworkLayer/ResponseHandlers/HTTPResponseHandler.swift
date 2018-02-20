//
//  HTTPResponseHandler.swift
//  FlexibleNetworkLayer
//
//  Created by Isa Aliev on 19.02.18.
//  Copyright © 2018 IA. All rights reserved.
//

import Foundation

class HTTPResponseHandler: ResponseHandler {
    var jsonSerializer = JSONSerializer()
    var stringSerializer = StringSerializer()
    var errorHandler: ErrorHandler = BaseErrorHandler()
    var successResponseChecker: SuccessResponseChecker = BaseSuccessResponseChecker()
    
    func handleResponse(_ response: ResponseRepresentable, completion: (Result) -> ()) {
        if successResponseChecker.isSuccessResponse(response) {
            processSuccessResponse(response, completion: completion)
        } else {
            processFailureResponse(response, completion: completion)
        }
    }
    
    private func processSuccessResponse(_ response: ResponseRepresentable, completion: (Result) -> ()) {
        guard let data = response.data else {
            return
        }
        
//        let users = try? CodableModelDecodingProcessor<UsersList>().decodeFrom(data)
//        print(users)
//        
        
        let serializedJSON = try? jsonSerializer.serialize(data)
        
        if let json = serializedJSON {
            completion(.JSONValue(json))
            
            return
        }
        
        let serializedString = try? stringSerializer.serialize(data)

        guard let string = serializedString else {
            completion(.None)
            
            return
        }
        
        completion(.StringValue(string))
    }
    
    private func processFailureResponse(_ response: ResponseRepresentable, completion: (Result) -> ()) {
        errorHandler.handleErrorResponse(response) { (error) in
            completion(.Error(error))
        }
    }
}

