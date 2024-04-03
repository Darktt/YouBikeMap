//: [Previous](@previous)

import Foundation

typealias Processor<Action> = (Action) -> Void

typealias Middleware<State, Action> =
( Store<State, Action> ) ->
// (@escaping (Action) -> Void) ->
( @escaping Processor<Action> ) ->
// ((Action) -> Void)
( Processor<Action> )

//// 定義一個Thunk型別，它是一個接受 store 和 dispatch 的Closure，返回一個表示異步操作的Closure
typealias ActionCreator<State, Action> = (@escaping Processor<Action>, @autoclosure () -> State) -> Void

// 定義 Reducer 類型別名，用於處理狀態變化的邏輯
typealias Reducer<State, Action> = (State, Action) -> State

// 定義 Subscriber 類型別名，用於訂閱狀態變化
typealias Subscriber<State> = (State) -> Void

// 定義 Store 類，實現簡單的 Redux 風格狀態管理
class Store<State, Action>
{
    public private(set)
    var state: State
    
    private
    var reducer: Reducer<State, Action>
    
    private
    var subscribers: [Subscriber<State>] = []
    
    private
    var middlewares: [Middleware<State, Action>] = []
    
    // 初始化 Store，接受初始狀態、Reducer 和 Middleware 數組
    init(initialState: State, reducer: @escaping Reducer<State, Action>, middlewares: [Middleware<State, Action>] = [])
    {
        self.state = initialState
        self.reducer = reducer
        self.middlewares = middlewares
    }
    
    func dispatch(_ action: Action)
    {
        print("收到新動作 \(action)")
        DispatchQueue.main.async {
            
            var composedMiddleware: Processor<Action> = self.dispatchWithoutMiddleware
            
            self.middlewares.reversed().forEach {
                
                middleware in
                
                let currentMiddleware = composedMiddleware
                composedMiddleware = middleware(self)(currentMiddleware)
            }
            
            composedMiddleware(action)
            self.notifySubscribers()
        }
    }
    
    // 訂閱狀態變化
    func subscribe(_ subscriber: @escaping Subscriber<State>)
    {
        // 添加訂閱者並立即通知一次，提供當前狀態
        self.subscribers.append(subscriber)
        subscriber(self.state)
    }
}

private
extension Store
{
    func dispatchWithoutMiddleware(action: Action)
    {
        self.state = reducer(state, action)
        // 不要忘記在這裡通知訂閱者
        self.notifySubscribers()
    }
    
    // 通知所有訂閱者，狀態發生變化
    func notifySubscribers()
    {
        for subscriber in self.subscribers {
            
            subscriber(self.state)
        }
    }
}

// ----------------------------

// MARK: Example

struct AppState
{
    var count: Int = 0
    
    var text: String = ""
}

enum AppAction
{
    // sync action
    case increment
    case decrement
    
    case loadedDataFromDatabase(_ text: String)
    // sub-action
    case database(_ subAction: DatabaseAction)
}

enum DatabaseAction
{
    // async action
    case transcation(_ actionCreator: ActionCreator<AppState, AppAction>)
}

func appReducer(state: AppState, action: AppAction) -> AppState {
    
    print("進入    Reducer        : 動作：\(action) 狀態：\(state)")
    
    var newState = state
    
    switch action {
        
        case .increment:
            newState.count += 1
        
        case .decrement:
            newState.count -= 1
        
        case .loadedDataFromDatabase(let text):
            newState.text = text
        
        default:
            break
    }
    
    print("離開　　　 Reducer        : 動作：\(action), 狀態：\(newState)")
    return newState
}

let Logger: Middleware<AppState, AppAction> =
{ store in
    
    { next in
        
        { action in
            
            print("進入    Log      Middleware: 動作：\(action)")
            
            next(action)
            let newState = store.state
            
            print("離開    Log      Middleware: 動作：\(action), 狀態：\(newState)")
        }
    }
}

let DatabaseMiddleware: Middleware<AppState, AppAction> =
{ store in
    
    { next in
        
        { action in
            
            print("進入    Database Middleware: 動作：\(action)")
            
            guard  case .database(let subAction) = action else {
                
                print("進入    Next     Middleware: 動作：\(action)")
                next(action)
                return
            }
                
            if case .transcation(let actionCreator) = subAction {
                // AppAction.database(.transcation
                actionCreator(store.dispatch, store.state)
            }
            
            print("離開    Database Middleware: 動作：\(action)")
        }
    }
}

// 使用Task API進行非同步的網路請求
let fetchDataThunk = AppAction.database(.transcation {
    
    dispatch, getState in
    
    Task {
        
        print("進入    Transcation Action Creator")
        
        try! await Task.sleep(for: .seconds(5))
        // 模擬網路請求完成後，發送另一個動作
        let responseData = "Data from network"
        dispatch(.loadedDataFromDatabase(responseData))
        
        print("離開    Transcation Action Creator")
    }
})

let appStore = Store(initialState: AppState(), reducer: appReducer, middlewares: [Logger, DatabaseMiddleware])

appStore.subscribe {
    
    newState in
    
    print("接收新狀態 \(newState)\n")
}

appStore.dispatch(fetchDataThunk)
