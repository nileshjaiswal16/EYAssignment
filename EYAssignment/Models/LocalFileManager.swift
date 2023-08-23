//
//  FIleManager.swift
//  EYAssignment
//
//  Created by Nilesh Jaiswal on 22/08/23.
//

import Foundation

class LocalFileManager {
    
    static let instance = LocalFileManager()
    
    func deleteImage(toFile:String)  {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let fileURL = documentsDirectory.appendingPathComponent(toFile)
         //Checks if file exists, removes it if so.
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                try FileManager.default.removeItem(atPath: fileURL.path)
                print("Removed old image")
            } catch let removeError {
                print("couldn't remove file at path", removeError)
            }
        }
    }
    func saveData(tempURL: URL, toFile:String) {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let fileURL = documentsDirectory.appendingPathComponent(toFile)
        
        //Checks if file exists, removes it if so.
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                try FileManager.default.removeItem(atPath: fileURL.path)
                print("Removed old image")
            } catch let removeError {
                print("couldn't remove file at path", removeError)
            }
        }
        DispatchQueue.global().async {
            do {
                try FileManager.default.copyItem(
                  at: tempURL,
                  to: fileURL
            )
            } catch let error {
                print("error saving file with error", error)
            }
        }
       
    }
    func download(url: URL, toFile:String) {
        // Download the remote URL to a file
        let task = URLSession.shared.downloadTask(with: url) {
            (tempURL, response, error) in
            // Early exit on error
            guard let tempURL = tempURL else { return }
            
            self.saveData(tempURL: tempURL, toFile: toFile)
        }
        task.resume()
    }
     func getPathForImage(name:String) -> URL?{
         
         guard
             let path = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?
                 .appendingPathComponent(name) else {
             return nil
         }
         return path
     }
    func loadImage(name:String) -> Data? {
        
        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory

          let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
          let paths = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)

          if let dirPath = paths.first {
              let imageUrl = URL(fileURLWithPath: dirPath).appendingPathComponent(name)
              
              if let data = try? Data(contentsOf: URL(fileURLWithPath: imageUrl.path)) {
                  //  let image = UIImage(contentsOfFile: imageUrl.path)
                  return data
                  
              }

          }

          return Data()
    }
    
}

