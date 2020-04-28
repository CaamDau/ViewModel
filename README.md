<p>
  <img src="https://github.com/liucaide/Images/blob/master/CaamDau/caamdau.png" align=centre />
</p>

[![CI Status](https://img.shields.io/travis/CaamDau/ViewModel.svg?style=flat)](https://travis-ci.org/CaamDau/ViewModel)
[![Version](https://img.shields.io/cocoapods/v/CaamDauViewModel.svg?style=flat)](https://cocoapods.org/pods/CaamDauViewModel)
[![License](https://img.shields.io/cocoapods/l/CaamDauViewModel.svg?style=flat)](https://cocoapods.org/pods/CaamDauViewModel)
[![Platform](https://img.shields.io/cocoapods/p/CaamDauViewModel.svg?style=flat)](https://cocoapods.org/pods/CaamDauViewModel)
[![](https://img.shields.io/badge/Swift-4.0~5.0-orange.svg?style=flat)](https://cocoapods.org/pods/CaamDauViewModel)

# ViewModel
ViewModel协议、Form 、Refresh、Net组合

```
pod 'CaamDauViewModel'

pod 'CaamDau/ViewModel'
```
```
/// Cell数据源遵循 CD_FormProtocol 协议
var vm:VM_**** = VM_****()

/// tableView Delegate DataSource 代理类
lazy var delegateData:CD_TableViewDelegateDataSource? = {
    return CD_TableViewDelegateDataSource(vm)
}()

/// 代理设置为 CD_FormTableViewDelegateDataSource
tableView.delegate = delegateData
tableView.dataSource = delegateData

// 关联默认的 reloadData
delegateData?.makeReloadData(tableView)

```
