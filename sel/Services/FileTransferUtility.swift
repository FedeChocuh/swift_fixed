//
//  FileTransferUtility.swift
//  sel
//
//  Created by Federico Zenteno on 11/10/23.
//

import Foundation
import MobileCoreServices

class FileTransferUtility {
    
    static let shared = FileTransferUtility()
    
    private init() {}
    
    func checkFileExists(userId: String, activityId: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        guard let checkURL = URL(string: "https://sel4c-e2-server-49c8146f2364.herokuapp.com/activities/download\(userId)/\(activityId)") else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid check URL"])))
            return
        }
        
        let task = URLSession.shared.dataTask(with: checkURL) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid response"])))
                return
            }
            
            switch httpResponse.statusCode {
            case 200:
                // The file exists
                completion(.success(true))
            case 404:
                // The file does not exist
                completion(.success(false))
            default:
                // Some other status code was returned
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Unexpected status code: \(httpResponse.statusCode)"])))
            }
        }
        task.resume()
    }


    
    func uploadFile(userId: String, activityId: String, fileURL: URL, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let uploadURL = URL(string: "https://sel4c-e2-server-49c8146f2364.herokuapp.com/activities/upload/\(userId)/\(activityId)") else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid upload URL"])))
            return
        }
        
        var request = URLRequest(url: uploadURL)
        request.httpMethod = "POST"
        
        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        var body = Data()
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"file\"; filename=\"\(fileURL.lastPathComponent)\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: \(fileURL.mimeType())\r\n\r\n".data(using: .utf8)!)
        body.append(try! Data(contentsOf: fileURL))
        body.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        
        request.httpBody = body
        
        let uploadTask = URLSession.shared.uploadTask(with: request, from: body) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Unexpected response from server"])))
                return
            }
            completion(.success(()))
        }
        uploadTask.resume()
    }
    
    func downloadFile(userId: String, activityId: String, completion: @escaping (Result<URL, Error>) -> Void) {
        guard let downloadURL = URL(string: "https://sel4c-e2-server-49c8146f2364.herokuapp.com/activities/download/\(userId)/\(activityId)") else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid download URL"])))
            return
        }
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let downloadTask = session.downloadTask(with: downloadURL) { url, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let url = url else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to obtain file URL"])))
                return
            }
            completion(.success(url))
        }
        downloadTask.resume()
    }
}

extension URL {
    func mimeType() -> String {
        let pathExtension = self.pathExtension
        if let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, pathExtension as CFString, nil)?.takeRetainedValue() {
            if let mimetype = UTTypeCopyPreferredTagWithClass(uti, kUTTagClassMIMEType)?.takeRetainedValue() {
                return mimetype as String
            }
        }
        return "application/octet-stream"
    }
}
