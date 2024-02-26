Title: MVVVR 架構  
Category: [Personal][L1]  

## 前言
iOS 開發架構繁多, 從 MVC, MVVM, Rx, 到 Clean Swift...等,  
最後還是實作了一個最適合自己的架構, MVVVR.

## 說明
開發 iOS 時, 基本上都是 by UIViewController, 一個 MVVVR 模組代表一個 UIViewController 的 Life Cycle,  
包含基本五個模組:

- Models  
這個 ViewController 要執行的 Action / 要 Binding 的 State / 要呈現的 Model / 基礎 Raw Data.

- ViewOutlet  
這個 ViewController 要呈現的 UI.

- ViewController  
UIViewController 主體.

- ViewModel  
這個 ViewController 的商業邏輯, 例如 call api.

- Router  
這個 ViewController 的跳轉邏輯.

ViewController 持有 ViewOutlet.  
ViewController 持有 ViewModel.  
ViewController 持有 Router.  
Router 持有(Weak) ViewController.  
ViewModel 持有 Models.  

## 關係圖
ViewController Binding ViewModel 的 State, 然後由 ViewController 發起 Action,  
ViewController 再依照 ViewModel State 更新 UI.

```mermaid
sequenceDiagram
    participant ViewOutlet
    participant ViewController
    participant ViewModel
    ViewModel-->>ViewController: Binding State
    ViewController->>ViewModel: Do Action
    ViewModel->>ViewModel: Call API or Update Models
    ViewModel-->>ViewController: State Changed
    ViewController-->>ViewOutlet: Reload UI or Router to...
```

[L1]: https://github.com/shinrenpan/Note/discussions/categories/personal