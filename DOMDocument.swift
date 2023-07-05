//
//  DOMDocumentHostObject.swift
//  DOMModule
//
//  Created by Nishan Bende on 11/06/23.
//

import Foundation
import UIKit

@objcMembers
public class DOMDocument: NSObject {
  var rootController: UIViewController?;
  
  public init(rootController: UIViewController?) {
      self.rootController = rootController
  }
  
  public func appendChild(child: DOMElement) {
    rootController?.view.addSubview(child.view);
  }
  
  public func setBackgroundColor(color: String) {
      
      rootController?.view.backgroundColor =  rgbaStringToUIColor(rgba: color);
   
  }
}

func rgbaStringToUIColor(rgba: String) -> UIColor? {
    let components = rgba.replacingOccurrences(of: "rgba(", with: "")
        .replacingOccurrences(of: ")", with: "")
        .components(separatedBy: ",")
    guard components.count == 4,
          let r = Float(components[0].trimmingCharacters(in: .whitespaces)),
          let g = Float(components[1].trimmingCharacters(in: .whitespaces)),
          let b = Float(components[2].trimmingCharacters(in: .whitespaces)),
          let a = Float(components[3].trimmingCharacters(in: .whitespaces)) else {
      print("invlaid color");
      return nil;
    }
    return UIColor(red: CGFloat(r/255.0), green: CGFloat(g/255.0), blue: CGFloat(b/255.0), alpha: CGFloat(a))
}

