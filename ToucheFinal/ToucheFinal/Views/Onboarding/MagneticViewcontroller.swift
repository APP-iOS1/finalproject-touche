//
//  MagneticViewcontroller.swift
//  ToucheFinal
//
//  Created by 조석진 on 2023/01/31.
//

import SpriteKit
import Magnetic
import SwiftUI

class MagneticViewcontroller: UIViewController {
    @IBOutlet weak var SkipBtn: UIButton!
    @IBOutlet weak var FinishBtn: UIButton!
    @IBOutlet weak var magneticView: MagneticView! {
        didSet {
            magnetic.magneticDelegate = self
        }
    }
    
    var selectedScentTypes: [String : Bool] = [:]
    var tabBtn: (() -> Void)?
    
    var magnetic: Magnetic {
        return magneticView.magnetic
    }
    
    let spinner = SpinnerViewController()

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        for perfumeColor in PerfumeColor.types {
            let node = Node(text: perfumeColor.name, color: UIColor(perfumeColor.color), radius: 40, marginScale: CGFloat(1.0))
            setNode(node: node)
        }
        
        setBtnStyle()
    }
    
    func setNode(node: Node) {
        let node = node
        node.name = node.text
        node.fontSize = CGFloat(10)
        node.padding = CGFloat(10)
        node.scaleToFitContent = true
        node.selectedColor = node.color
        node.color = .lightGray
        magnetic.addChild(node)
    }
    
    func setBtnStyle() {
        SkipBtn.layer.cornerRadius = 25
        FinishBtn.layer.cornerRadius = 25
        FinishBtn.isEnabled = false
    }
    
    func startLoading(isSkip: Bool) {
//        let child = SpinnerViewController()
        let child = UIHostingController(rootView: SpinnerView())
        child.view.backgroundColor = UIColor(.gray.opacity(0.1))

        if isSkip {
            magneticView.magnetic.skip()
        } else {
            magneticView.magnetic.reset()
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            self.addChild(child)
            child.view.frame = self.view.frame
            self.view.addSubview(child.view)
            child.didMove(toParent: self)

            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                // then remove the spinner view controller
                child.willMove(toParent: nil)
                child.view.removeFromSuperview()
                child.removeFromParent()

                self.tabBtn?()
            }
        }
    }
    
    @IBAction func finish(_ sender: UIControl?) {
        var FragranceTypes: [String] = []
        
        selectedScentTypes.forEach { key, value in
            if value {
                FragranceTypes.append(key)
            }
        }
        
        UserDefaults.standard.set(FragranceTypes, forKey: "selectedScentTypes")
        UserDefaults.standard.set(false, forKey: "isShowingOnboardingView")
        
        startLoading(isSkip: false)
    }
    
    // TODO: skip클릭시 모든 FragranceType 저장 필요(현재는 더미데이터 사용)
    @IBAction func skip(_ sender: UIControl?) {
        UserDefaults.standard.set(PerfumeColor.types.map{$0.name}, forKey: "selectedScentTypes")
        UserDefaults.standard.set(false, forKey: "isShowingOnboardingView")
                
        startLoading(isSkip: true)
    }
}

    // MARK: - MagneticDelegate
extension MagneticViewcontroller: MagneticDelegate {
    
    func magnetic(_ magnetic: Magnetic, didSelect node: Node) {
        guard let name = node.name else {return}
        selectedScentTypes[name] = true
        FinishBtn.isEnabled = true
    }
    
    func magnetic(_ magnetic: Magnetic, didDeselect node: Node) {
        let tempSelectedColor = node.selectedColor
        node.selectedColor = .lightGray
        node.deselectedAnimation()
        node.selectedColor = tempSelectedColor
        guard let name = node.name else {return}
        selectedScentTypes[name] = false
        FinishBtn.isEnabled = !selectedScentTypes.filter{$0.value == true}.isEmpty
    }
    
    func magnetic(_ magnetic: Magnetic, didRemove node: Node) {}
}
