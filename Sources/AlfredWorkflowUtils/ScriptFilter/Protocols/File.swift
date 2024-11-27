//
//  File.swift
//  
//
//  Created by Hanley Lee on 2024/11/27.
//

//import Foundation
//
//private var subtitleKey: UInt8 = 0
//@propertyWrapper
//public struct UserDefaultStorager<T> {
//    /// key
//    private let keyName: String
//
//    /// 初始化
//    public init(_ keyName: String) {
//        self.keyName = keyName
//    }
//
//    /// 值
//    public var wrappedValue: T? {
//        get {
//            return objc_getAssociatedObject(self, &subtitleKey) as? T
//        }
//        set {
//            objc_setAssociatedObject(self, &subtitleKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//        }
//    }
//}
//protocol HasSubtitle1: AnyObject {
//    var subtitle: String { get set }
//}
//
//extension HasSubtitle1 {
//    @UserDefaultStorager("h")
//    var subtitle: String
//}
//
//class ExampleClass: HasSubtitle1 {}
//
////let example = ExampleClass()
////example.subtitle = "Hello, World!"
////print(example.subtitle) // 输出: Hello, World!
