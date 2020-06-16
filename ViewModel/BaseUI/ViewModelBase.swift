//Created  on 2018/12/11  by LCD :https://github.com/liucaide .

import Foundation
import UIKit
import CaamDauRefresh
import CaamDauTopBar

public typealias ViewModelTableViewProtocol = (ViewModelDataSource & ViewModelRefreshDelegater & ViewModelTopBarDelegater & ViewModelTableViewDelegater)
public typealias ViewModelCollectionViewProtocol = (ViewModelDataSource & ViewModelRefreshDelegater & ViewModelTopBarDelegater & ViewModelCollectionViewDelegater)


public protocol ViewModelRefreshDelegater {
    var _mjRefresh:(header:Bool, footer:Bool, headerGif:Bool, footerGif:Bool) { get }
    var _mjRefreshModel:RefreshModel { get }
    var _mjRefreshType:[RefreshModel.RefreshType] { get }
}
extension ViewModelRefreshDelegater {
    public var _mjRefresh: (header: Bool, footer: Bool, headerGif: Bool, footerGif: Bool) {
        return (header: true, footer: true, headerGif: false, footerGif: false)
    }
    public var _mjRefreshModel: RefreshModel {
        return Refresh.shared.model
    }
    public var _mjRefreshType:[RefreshModel.RefreshType] {
        return []
    }
}


public protocol ViewModelViewDelegater {
    //var _safeAreaLayout:(top:Bool, bottom:Bool) { get }
    var _bottomBarHeignt:CGFloat { get }
    var _bottomBarCustom:((UIView)->Void)? { get }
}

extension ViewModelViewDelegater {
//    public var _safeAreaLayout:(top:Bool, bottom:Bool) {
//        get{
//            return (true, true)
//        }
//    }
    public var _bottomBarCustom:((UIView)->Void)? {
        return { _ in
        }
    }
    public var _bottomBarHeignt:CGFloat {
        get{
            return 0
        }
    }
}

public protocol ViewModelTableViewDelegater: ViewModelViewDelegater {
    var _tableViewCustom:((UITableView)->Void)? { get }
}
public extension ViewModelTableViewDelegater {
    var _tableViewCustom:((UITableView)->Void)? {
        return { _ in
        }
    }
}


public protocol ViewModelCollectionViewDelegater: ViewModelViewDelegater {
    var _collectionRegisters:[CaamDau<UICollectionView>.View] { get }
    var _collectionViewCustom:((UICollectionView)->Void)? { get }
}
extension ViewModelCollectionViewDelegater {
    public var _collectionRegisters:[CaamDau<UICollectionView>.View] {
        return []
    }
    public var _collectionViewCustom:((UICollectionView)->Void)? {
        return { _ in
        }
    }
}


public protocol ViewModelTopBarDelegater {
    var _topBarCustom:((TopBar)->Void)? { get }
    var _topBarDidSelect:((TopBar,TopNavigationBar.Item)->Void)? { get }
    var _topBarUpdate:((TopBar,TopNavigationBar.Item)->[TopNavigationBarItem.Item.Style]?)? { get }
}
extension ViewModelTopBarDelegater {
    public var _topBarCustom:((TopBar)->Void)? {
        return { _ in
        }
    }
    
    public var _topBarDidSelect: ((TopBar, TopNavigationBar.Item) -> Void)? {
        return { (top, item) in
            top.topBarItemClick(item)
        }
    }
    
    public var _topBarUpdate:((TopBar,TopNavigationBar.Item)->[TopNavigationBarItem.Item.Style]?)? {
        return nil
    }
}

