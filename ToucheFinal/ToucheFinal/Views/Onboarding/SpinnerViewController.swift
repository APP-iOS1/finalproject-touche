//
//  SpinnerViewController.swift
//  ToucheFinal
//
//  Created by 조석진 on 2023/01/31.
//

import UIKit
import SwiftUI

class SpinnerViewController: UIViewController {
    var spinner = UIActivityIndicatorView(style: .large)
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor(white: 0.2, alpha: 0.2)
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        view.addSubview(spinner)
        
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}

struct SpinnerView: View {
    @State var isLoading: Bool = false
    var body: some View {
        ZStack {
            
            Circle()
                .trim(from: 0, to: 0.37)
                .stroke(Color.gray, lineWidth: 10)
                .rotationEffect(Angle(degrees: isLoading ? 0 : 360))
                .frame(width: 100, height: 100)
            Text("Loading..")
        }
        .onAppear(){
            withAnimation(
                Animation
                    .linear(duration: 1)
                    .repeatForever(autoreverses: false)){
                        isLoading.toggle()
                    }
        }
    }
}

struct SpinnerView_Previews: PreviewProvider {
    static var previews: some View {
        SpinnerView()
    }
}
