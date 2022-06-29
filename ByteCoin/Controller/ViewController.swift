

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var currencyPicker: UIPickerView!
    @IBOutlet weak var bitcoinPrice: UILabel!
    @IBOutlet weak var currencyAbrev: UILabel!
    
    var coinManager = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.coinManager.delegate = self
        self.currencyPicker.dataSource = self
        self.currencyPicker.delegate = self
        
        let currencySelected = self.coinManager.currencyArray[0]
        self.coinManager.getCoinPrice(for: currencySelected)
    }
    
}

// MARK: - UIPickerViewDataSource, UIPickerViewDelegate

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.coinManager.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let currencySelected = self.coinManager.currencyArray[row]
        self.coinManager.getCoinPrice(for: currencySelected)
    }
}

// MARK: - CoinManagerDelegate

extension ViewController: CoinManagerDelegate {
    
    func didUpdateCoin(_ coinManager: CoinManager, coin: CoinModel) {
        DispatchQueue.main.async {
            self.bitcoinPrice.text = coin.rateAsString
            self.currencyAbrev.text = coin.currencyName
        }
    }
    
    func didFailWithError(with error: Error) {
        print(error)
    }
}

