//
//  DOMElementHostObject.swift
//  DOMModule
//
//  Created by Nishan Bende on 11/06/23.
//

import Foundation
import UIKit

@objcMembers
public class DOMElement: NSObject {
  var view = UIView()
  var type = "div"
  var onClickAction: (() -> Void)?
  var label: UILabel?

  public func appendChild(element: DOMElement) {
    view.addSubview(element.view);
  }

  public func remove() {
    view.removeFromSuperview();
  }
  
  public func setTextContent(textContent: String) {
    self.label = UILabel()
    self.label?.text = textContent
    self.label?.sizeToFit()

    guard let label = self.label else {
      return
    }
    
    view.addSubview(label)
    
  }

  public init(type: String) {
    self.type = type;
  }
  
  public func onClick(action: @escaping () -> Void) {
    self.onClickAction = action;
    let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
    view.addGestureRecognizer(tap)
    view.isUserInteractionEnabled = true
  }
  
  public func setColor(color: String) {
    label?.textColor = rgbaStringToUIColor(rgba: color)
  }
  
  public func setFontSize(fontSize: Float) {
    label?.font = label?.font.withSize(CGFloat(fontSize))
  }
  
  public func setBackgroundColor(color: String) {
    view.backgroundColor = rgbaStringToUIColor(rgba: color);
  }

  public func setHeight(height: Double) {
    var frame = view.frame
    frame.size.height = CGFloat(height)
    view.frame = frame
  }
  
  public func setTop(top: Double) {
    var frame = view.frame
    frame.origin.y = CGFloat(top)
    view.frame = frame
  }
  
  public func setLeft(left: Double) {
    var frame = view.frame
    frame.origin.x = CGFloat(left)
    view.frame = frame
  }
  
  public func setWidth(width: Double) {
    var frame = view.frame
    frame.size.width = CGFloat(width)
    view.frame = frame
  }

  public func handleTap(_ gestureRecognizer: UITapGestureRecognizer) {
    print("View was tapped!")
    self.onClickAction?()
  }
}
