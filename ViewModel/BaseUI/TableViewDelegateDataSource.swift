//Created  on 2019/7/12 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import Foundation
import UIKit
import SnapKit
import CaamDauForm
import CaamDauTopBar
import CaamDauPopGesture
//MARK:--- 针对新的表单协议 CellProtocol ----------
open class TableViewDelegateDataSource: FormTableViewDelegateDataSource {
    public var vm:ViewModelTableViewProtocol?
    public init(_ vm:ViewModelTableViewProtocol?) {
        super.init(vm)
        self.vm = vm
    }
    
    open override func makeReloadData(_ tableView:UITableView) {
        vm?._reloadData = {[weak self, weak tableView] in
            tableView?.reloadData()
            tableView?.cd.mjRefreshTypes(self?.vm?._mjRefreshType ?? [.tEnd])
            tableView?.backgroundView = self?.vm?._emptyView?(tableView) ?? nil
        }
        
        vm?._reloadRows = { [weak self, weak tableView] (indexPath, animation) in
            tableView?.reloadRows(at: indexPath, with: animation)
            tableView?.cd.mjRefreshTypes(self?.vm?._mjRefreshType ?? [.tEnd])
            tableView?.backgroundView = self?.vm?._emptyView?(tableView) ?? nil
        }
        
        vm?._reloadSections = { [weak self, weak tableView] (sections, animation) in
            tableView?.reloadSections(sections, with: animation)
            tableView?.cd.mjRefreshTypes(self?.vm?._mjRefreshType ?? [.tEnd])
            tableView?.backgroundView = self?.vm?._emptyView?(tableView) ?? nil
        }
        tableView.backgroundView = self.vm?._emptyView?(tableView) ?? nil
        guard let refresh = vm?._mjRefresh else {
            return
        }
        
        if refresh.header {
            if refresh.headerGif {
                tableView.cd.headerMJGifWithModel({[weak self] in
                    self?.vm?.requestData(true)
                    }, model: vm!._mjRefreshModel)
            }else{
                tableView.cd.headerMJWithModel({[weak self] in
                    self?.vm?.requestData(true)
                    }, model: vm!._mjRefreshModel)
            }
        }
        if refresh.footer {
            if refresh.footerGif {
                tableView.cd.footerMJGifAutoWithModel({[weak self] in
                    self?.vm?.requestData(false)
                    }, model: vm!._mjRefreshModel)
            }else{
                tableView.cd.footerMJAutoWithModel({[weak self] in
                    self?.vm?.requestData(false)
                    }, model: vm!._mjRefreshModel)
            }
        }
        
        tableView.cd.mjRefreshTypes(vm!._mjRefreshType)
    }
}



//MARK:--- 提供一个基础的 TableViewController 简单的页面不需要编写 ViewController----------
public struct R_CDTableViewController {
    public static func push(_ vm:ViewModelTableViewProtocol) {
        let vc = TableViewController()
        vc.vm = vm
        vc.safeAreaTop = false
        vc.safeAreaBottom = true
        CD.push(vc)
    }
}

open class TableViewController: FormTableViewController {
    open var vm:ViewModelTableViewProtocol?
    open var delegateData:TableViewDelegateDataSource?
    open lazy var topBar: TopBar = {
        return TopBar()
    }()
    open lazy var bottomBar: UIView = {
        let v = UIView()
        v.clipsToBounds = true
        return v
    }()
    
    
    open override var _form: FormProtocol? {
        set{
            
        }
        get{
            return vm
        }
    }
    
    open override var _delegateData: FormTableViewDelegateDataSource? {
        set{}
        get{
            return delegateData
        }
    }
    override open func viewDidLoad() {
        super.viewDidLoad()
        makeLayout()
        topBar.delegate = self
        vm?._tableViewCustom?(tableView)
        vm?._bottomBarCustom?(bottomBar)
    }
    override open func makeTableView() {
        delegateData = TableViewDelegateDataSource(vm)
        super.makeTableView()
        self.cd.navigationBar(hidden: true)
        self.stackView.insertArrangedSubview(topBar, at: 0)
        self.stackView.addArrangedSubview(bottomBar)
        
    }
    open func makeLayout(){
        bottomBar.snp.makeConstraints {
            $0.height.equalTo(vm?._bottomBarHeignt ?? 0)
        }
    }
}

extension TableViewController: TopBarProtocol {
    open func topBar(custom topBar: TopBar) {
        vm?._topBarCustom?(topBar)
    }
    open func topBar(_ topBar: TopBar, didSelectAt item: TopNavigationBar.Item) {
        vm?._topBarDidSelect?(topBar, item)
    }
    open func topBar(_ topBar: TopBar, updateItemStyleForItem item: TopNavigationBar.Item) -> [TopNavigationBarItem.Item.Style]? {
        return vm?._topBarUpdate?(topBar, item)
    }
}


