//
//  ViewController.swift
//  ScrollModule
//
//  Created by Mini on 3/13/17.
//  Copyright © 2017 Mini. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIScrollViewDelegate {
    
    var scrollView: UIScrollView?
    var ArrayColor = [UIColor.red,
                      UIColor.blue,
                      UIColor.white,
                      UIColor.brown,
                      UIColor.gray,
                      UIColor.green,
                      UIColor.orange]
    var ArrayView = [UIView]()
    var lastOffset: CGPoint = CGPoint(x: 0, y: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        self.scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        self.scrollView?.backgroundColor = UIColor.black
        self.scrollView?.contentSize = CGSize(width: self.view.frame.size.width * CGFloat(self.ArrayColor.count), height: self.view.frame.size.height)
        self.scrollView?.delegate = self
        self.scrollView?.isPagingEnabled = true
        self.view.addSubview(self.scrollView!)
        
        for i in 0..<ArrayColor.count{
            let view = UIView(frame: CGRect(x: self.view.frame.size.width * CGFloat(i), y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
            view.backgroundColor = self.ArrayColor[i]
            ArrayView.append(view)
            self.scrollView?.addSubview(view)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        var displayIndex = [Int]()
        var displayString = ""
        for i in 0..<ArrayView.count{
            if scrollView.contentOffset.x + self.view.frame.size.width > self.ArrayView[i].frame.origin.x && (self.ArrayView[i].frame.origin.x + self.ArrayView[i].frame.size.width) > scrollView.contentOffset.x{
                displayIndex.append(i)
                displayString += "Index === \(i),"
            }
        }
        
        var isNext = false
        if scrollView.contentOffset.x > self.lastOffset.x{
            displayString += "Next"
            isNext = true
        }else {
            displayString += "Previous"
        }
        
        if scrollView.contentOffset.x > 0 {
            if isNext{
                if displayIndex.count != 0 {
                    let currentIndex = displayIndex.count > 1 ? displayIndex.count - 2:0
                    let nextIndex = displayIndex.count > 1 ? displayIndex.count - 1:0
                    
                    let resultFrame = self.ArrayView[displayIndex[nextIndex]].frame.origin.x - scrollView.contentOffset.x
                    let percentView = getPercenOfValue(value: resultFrame, size: self.view.frame.size.width) > 0 ? getPercenOfValue(value: resultFrame, size: self.view.frame.size.width):100
                    let resultSumX   = ((100 - percentView) * 0.3) * 1
                    let resultSumY   = ((100 - percentView) * 0.3) * 1
                    
                    let resultFinalSumX = (self.view.frame.size.width - resultFrame) + resultSumX
                    self.ArrayView[displayIndex[currentIndex]].transform = CGAffineTransform(translationX: 0, y: resultSumY)
                    self.ArrayView[displayIndex[currentIndex]].frame.origin.x = self.view.frame.size.width * CGFloat(displayIndex[currentIndex]) + resultFinalSumX

                    if displayIndex.count == 3{
                        self.ArrayView[displayIndex[0]].alpha = 0
                        self.ArrayView[displayIndex[1]].alpha = 1
                        self.ArrayView[displayIndex[2]].alpha = 1
                    }
                }
            }else{
                if displayIndex.count != 0 {
                    let currentIndex = displayIndex.count > 1 ? displayIndex.count - 2:0
                    let nextIndex = displayIndex.count > 1 ? displayIndex.count - 1:0
                    
                    let resultFrame = self.ArrayView[displayIndex[nextIndex]].frame.origin.x - scrollView.contentOffset.x
                    let percentView = getPercenOfValue(value: resultFrame, size: self.view.frame.size.width) > 0 ? getPercenOfValue(value: resultFrame, size: self.view.frame.size.width):100
                    let resultSumX   = ((100 - percentView) * 0.3) * 1
                    let resultSumY   = ((100 - percentView) * 0.3) * 1

                    let resultFinalSumX = (self.view.frame.size.width - resultFrame) + resultSumX
                    self.ArrayView[displayIndex[currentIndex]].transform = CGAffineTransform(translationX: 0, y: resultSumY)
                    self.ArrayView[displayIndex[currentIndex]].frame.origin.x = self.view.frame.size.width * CGFloat(displayIndex[currentIndex]) + resultFinalSumX

                    if displayIndex.count == 3{
                        self.ArrayView[displayIndex[0]].alpha = 0
                        self.ArrayView[displayIndex[1]].alpha = 1
                        self.ArrayView[displayIndex[2]].alpha = 1
                    }else{
                        self.ArrayView[0].alpha = 1
                    }
                    
                }
            }
        }else{
            self.ArrayView[0].transform = CGAffineTransform(translationX: 0, y: 0)
            self.ArrayView[0].frame.origin.x = 0
        }
        

        
        
        self.lastOffset = scrollView.contentOffset
        print(displayString)
    }
    
    func getPercenOfValue(value: CGFloat , size: CGFloat) -> CGFloat{
        let p = (value / size ) * 100
        return p
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

