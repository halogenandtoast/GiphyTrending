import UIKit
import Alamofire
import SwiftyJSON

class GiphyApi: NSObject {
    func getTrending(_ completion: @escaping ([URL]) -> Void) {
        Alamofire.request("https://api.giphy.com/v1/gifs/trending?api_key=dc6zaTOxFJmzC").responseJSON { response in
            if let data = response.result.value {
                let json = JSON(data)
                let urls: [URL] = json["data"].arrayValue.flatMap { datum in
                    guard let string = datum["images"]["downsized"]["url"].string else { return .none }
                    return URL(string: string)
                }
                completion(urls)
            }
        }
    }
}
