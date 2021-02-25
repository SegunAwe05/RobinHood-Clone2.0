//
//  stockData.swift
//  StockProject
//
//  Created by Segun Awe on 2/13/21.
//

import Foundation
import CoreData


// Api Data
struct stockSymbol: Codable,Hashable {
    var symbol: String?
    var name: String?
    var price: Double?
}

class FetchData:  ObservableObject {
    //list for home screen, Also publish to find other stocks through API
    @Published var hubData: [stockSymbol] = []

    // get data from API
    func getData(name: String) {
      guard let url = URL(string: "https://fmpcloud.io/api/v3/quote/\(name)?apikey=f669fc79bd6c3f0982dfbda659b56548") else {return}
         
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            DispatchQueue.main.sync {
                do {
                    let info = try JSONDecoder().decode([stockSymbol].self, from: data!)
                    print(info)
                    self.hubData = info
                } catch {
                    print(error.localizedDescription)
                }
            }
        }.resume()
    }
}

struct historicalData: Codable {
    var open: Double
}
// fetching api data for stock graph
class HistoryClass: ObservableObject {
    @Published var histData: [historicalData] = []
    
    // save core data
    func saveData(context: NSManagedObjectContext) {
        histData.forEach {  (data) in
            let entity = StockData(context: context)
            entity.open = data.open
        }
        
        do {
            try context.save()
            print("success")
        } catch {
            print(error.localizedDescription)
        }
    }

    func getHistData(name: String, context:NSManagedObjectContext) {
        guard let url = URL(string: "https://fmpcloud.io/api/v3/technical_indicator/5min/\(name)?period=10&type=ema&apikey=f669fc79bd6c3f0982dfbda659b56548") else {return}

        URLSession.shared.dataTask(with: url) { (data, _, error) in
            DispatchQueue.main.sync {
                do {
                    let info = try JSONDecoder().decode([historicalData].self, from: data!)
                    self.histData = info
                    self.saveData(context: context)
                    print(info)
                } catch {
                    print("error")
                }
                    
            }
        }.resume()
    }
}



// api struct
struct LongHist: Codable{
    var historical: [result]

}

struct result: Codable {
    var open: Double
    
}



// fetching data
class LongHistory: ObservableObject {
    @Published var longData = LongHist(historical: [result(open: 20.0)])

    func getHistData(name: String, date: String) {
        guard let url = URL(string: "https://fmpcloud.io/api/v3/historical-price-full/\(name)?timeseries=\(date)&apikey=f669fc79bd6c3f0982dfbda659b56548") else {return}

        URLSession.shared.dataTask(with: url) { (data, _, error) in
            DispatchQueue.main.sync {
                do {
                    let info = try JSONDecoder().decode(LongHist.self, from: data!)
                    self.longData = info
                    print(info)
                } catch {
                    print(error.localizedDescription)
                }
                   
            }
        }.resume()
    }
}
