
import Foundation
protocol MovieListDelegate:class {
    func Success(_ Response: Movie )
    func Failure(_ message:String)
}

class MovieVM:NSObject {
    weak var delegate:MovieListDelegate?
    
    func getMovies(query: String){
        
        let url = "https://api.themoviedb.org/3/search/movie?api_key=5ee467b569f1fcd89492e89e5dddad1b&query=\(query)"
        
        Service.getMovieList(requestUrl:url,completion: { (response, error) in
            if(error?.isEmpty)!{
                self.delegate?.Success(response!)
            }else{
                self.delegate?.Failure(error!)
            }
            
        })
    }
    
}