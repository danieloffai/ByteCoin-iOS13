
import Foundation

protocol CoinManagerDelegate: AnyObject {
    func didUpdateCoin(_ coinManager: CoinManager, coin: CoinModel)
    func didFailWithError(with error: Error)
}

class CoinManager {
    weak var delegate: CoinManagerDelegate?
    let urlSession = URLSession(configuration: .default)
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "A1DBE565-544F-4B27-A30B-187B050A4C4E"
    
    let currencyArray = ["EUR","GBP","HKD","JPY","RUB","USD"]

    func getCoinPrice (for currency: String) {
        let urlString = "\(self.baseURL)/\(currency)?apikey=\(apiKey)"
        self.performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            
            let task = self.urlSession.dataTask(with: url) { data, urlResponse, error in
                if error != nil {
                    self.delegate?.didFailWithError(with: error!)
                    return
                }
                
                if let safeData = data {
                    if let coin = self.parseJSON(safeData) {
                        self.delegate?.didUpdateCoin(self, coin: coin)
                    }
                    
                }
            }
            
            task.resume()
        }
    }
    
    func parseJSON(_ coinData: Data) -> CoinModel? {
        let decoder = JSONDecoder()

        do {
            let decodedData = try decoder.decode(CoinData.self, from: coinData)
            let currencyName = decodedData.assetIdQuote
            let lastPrice = decodedData.rate
            
            let coin = CoinModel(currencyName: currencyName, lastPrice: lastPrice)
            
            return coin

        } catch {
            self.delegate?.didFailWithError(with: error)
            return nil
        }
    }
}
