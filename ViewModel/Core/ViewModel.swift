//Created  on 2018/12/11  by LCD :https://github.com/liucaide .

import Foundation
import UIKit
import CaamDauForm

public protocol ViewModelProtocol {
    associatedtype Input
    associatedtype Output
    func input(_ input:Input)
    var output:((Output)->Void)? { set get }
}




public protocol ViewModelDataSource: FormProtocol {
    /// 空数据视图
    var _emptyView:((Any?) -> UIView?)? { get }
    
    func requestData(_ refresh:Bool)
}


extension ViewModelDataSource {
    
    public var _emptyView:((Any?) -> UIView?)? { get { nil } }
    
    public func requestData(_ refresh:Bool) {}
}

