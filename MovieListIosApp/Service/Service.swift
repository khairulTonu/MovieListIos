
import Foundation
class Service {
    
    public static func getMovieList(requestUrl:String,completion:@escaping(_ response:Movie?,_ message:String?)->Void) {
        let session = URLSession.shared
        let url = URL(string: requestUrl)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
            if error != nil {
                print(error!)
                return
            }
            
            // Serialize the data into an object
            do {
                let json = try JSONDecoder().decode(Movie.self, from: data! )
                completion(json, "")
            } catch {
                print("Error during JSON serialization: \(error.localizedDescription)")
                completion(nil, "Something went wrong!")
            }
            
        })
        task.resume()

    }
    
}
