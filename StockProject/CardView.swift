//
//  CardView.swift
//  StockProject
//
//  Created by Segun Awe on 2/13/21.
//

import SwiftUI
import SwiftUICharts
struct CardView: View {
    var data: stockSymbol

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5){
                Text(data.symbol ?? "NA")
                    .padding(2)
                    .foregroundColor(.black)
                Text(data.name ?? "NA")
                    .foregroundColor(.gray)
                    .font(.caption)
            }
            Spacer()
            Text("$\(data.price ?? 20.0)")
                .frame(width: 115, height: 50)
                .foregroundColor(.white)
                .background(Color.green)
                .cornerRadius(15)
            Spacer().frame(width: 20)
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(data: stockSymbol())
    }
}
