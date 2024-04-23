//
//  Communicator.swift
//  LetsKGB
//
//  Created by Chun on 2023/9/25.
//

import Alamofire
import Foundation

typealias DoneHandler = (_ result: ResponseData?, _ error: Error?) -> Void

class Communicator {
  static let baseURL = "https://www.houhouhan.store/letscatchball/"

  let checkAccoutURL = baseURL + "check-account"
  let SignInURL = baseURL + "auth/login"
  let createUserURL = baseURL + "users/create-user"
  
  var getUserURL = ""
  
  var deleteUserURL = ""
  
  let getActivityURL = baseURL + "activities/get-all-activity"
  
  let createActivityURL = baseURL + "activities/create-activity"

  static let shared = Communicator()
  private init() {}
  
  // MARK: - Check Account Method
  
  // 提供確認帳號函式
  func checkAccount(email: String, completion: @escaping DoneHandler) {
    // 參考 API request 格式提供參數
    let paramerers: [String: Any] = ["account": email]
    
    // 使用自訂 POST 函數 ( 用第三方 SDK Alamifire 寫的 )
    doPost(checkAccoutURL, parameters: paramerers, completion: completion)
  }
  
  // MARK: - Sign Up Account Method
  
  // 提供註冊帳號函式
  func signUp(email: String, password: String, completion: @escaping DoneHandler) {
    // 參考 API request 格式提供參數
    let parameters: [String: Any] = ["account": email,
                                     "password": password]
    // 使用自訂 POST 函數 ( 用第三方 SDK Alamofire 寫的 )
    doPost(createUserURL, parameters: parameters, completion: completion)
  }
  
  // MARK: - Sign In Account Method
  
  // 提供登入帳號函式
  func signIn(email: String, password: String, completion: @escaping DoneHandler) {
    // 參考 API request 格式提供參數
    let parameters: [String: Any] = ["account": email,
                                     "password": password]
    // 使用自訂 POST 函數 ( 用第三方 SDK Alamofire 寫的 )
    doPost(SignInURL, parameters: parameters, completion: completion)
  }
  
  // MARK: - Get User Method
  
  // 提供讀取個人帳號函式
  func getUser(completion: @escaping DoneHandler) {
    // 確認 User ID
    checkUserID()
    // 使用自訂 GET 函數 ( 用第三方 SDK Alamofire 寫的 )
    doGet(getUserURL, completion: completion)
  }
  
  // MARK: - Delete User Method
  
  // 提供刪除個人帳號函式
  func deleteUser(completion: @escaping DoneHandler) {
    // 確認 User ID
    checkUserID()
    // 使用自訂 DELETE 函數 ( 用第三方 SDK Alamofire 寫的)
    doDelete(deleteUserURL, completion: completion)
  }
  
  // MARK: - Get Activity Method
  
  // 提供讀取活動函式
  func getActivity(completion: @escaping DoneHandler) {
    // 使用自訂 GET 函數 ( 用第三方 SDK Alamofire 寫的 )
    doGet(getActivityURL, completion: completion)
  }
  
  // MARK: - Create Activity Method
  
  // 提供創建活動函式
  func createActivity(title: String, time: String, location: String, latitude: Double, longitude:Double, spend: String, information: String, completion: @escaping DoneHandler) {
    // 參考 API request 格式提供參數
    let parameter: [String: Any] = ["title": title,
                                    "time": time,
                                    "location": location,
                                    "latitude": latitude,
                                    "longitude": longitude,
                                    "spend": spend,
                                    "information": information]
    // 使用自訂 POST 函數 ( 用第三方 SDK Alamofire 寫的)
    doPost(createActivityURL, parameters: parameter, completion: completion)
  }
  
  // MARK: - RESTful Method - GET
  
  // GET 從伺服器獲取資料，不產生任何副作用
  // 用於處理 GET，傳入 API 網址與請求參數 ( 字典 )，Header 驗證，使用自訂 closure 傳回資料給調用此方法的 VC ( 錯誤處理也透過 closure 交給 VC )
  private func doGet(_ urlString: String, completion: DoneHandler?) {
    // 定義 Header
//    var headers: HTTPHeaders = [
//      //      "Content-Type": "application/json", // 告訴 Server 這邊發送的是 JSON
//      //      "Accept": "application/json" // 告訴 Server 這邊只接受 JSON
//    ]
//    if let token = token {
//      headers.add(name: "Authorization", value: "Bearer \(token)")
//    }
    // 執行請求 ( 用第三方 SDK Alamofire 寫的 )
    AF.request(urlString,
               method: .get,
               encoding: JSONEncoding.default)
//               headers: headers)
      .responseDecodable {
        // response 資料設定為自訂結構 ResponseData
        (response: DataResponse<ResponseData, AFError>) in
        // 使用自訂方法處理 response 結果
        self.handleResponse(response: response, completion: completion)
      }
  }
  
  // MARK: - RESTful Method - POST

  // POST 創建新資源，或者觸發不會改變資源狀態的操作
  // 用於處理 POST，傳入 API 網址與請求參數 ( 字典 )，Header 驗證，使用自訂 closure 傳回資料給調用此方法的 VC ( 錯誤處理也透過 closure 交給 VC )
  
  private func doPost(_ urlString: String, parameters: [String: Any], completion: DoneHandler?) {
    // 定義 Header
//    var headers: HTTPHeaders = [
//      "Content-Type": "application/json",
//      "Accept": "application/json"
//    ]
    // 執行請求 ( 用第三方 SDK Alamofire 寫的 )
    AF.request(urlString,
               method: .post,
               parameters: parameters,
               encoding: JSONEncoding.default)
//               headers: headers)
      .responseDecodable {
        // response 資料設定為自訂結構 ResponseData
        (response: DataResponse<ResponseData, AFError>) in
        // 使用自訂方法處理 response 結果
        self.handleResponse(response: response, completion: completion)
      }
//      .responseString { response in
//        switch response.result {
//          case .success(let string):
//            print("成功獲得字串: \(string)")
//          case .failure(let error):
//            print("失敗: \(error)")
//        }
//      }
  }
  
  // MARK: - RESTful Method - DELETE
  
  // DELETE 請求從伺服器上刪除指定的資源，不包含 body，所有必要資訊應該包含在 URL 和 Header 中
    // 用於處理 DELETE，傳入 API 網址與請求參數 ( 字典 )，Header 驗證，使用自訂 closure 傳回資料給調用此方法的 VC ( 錯誤處理也透過 closure 交給 VC )
    private func doDelete(_ urlString: String, completion: DoneHandler?) {
      // 定義 Header
//      let headers: HTTPHeaders = [
//        "Content-Type": "application/json",
//        "Accept": "application/json",
//        "Authorization": "Bearer \(token)",
//      ]
      // 執行請求 ( 用第三方 SDK Alamofire 寫的 )
      AF.request(urlString,
                 method: .delete,
                 encoding: JSONEncoding.default)
//                 headers: headers)
      .responseDecodable {
        // response 資料設定為自訂結構 ResponseData
        (response: DataResponse<ResponseData, AFError>) in
        // 使用自訂方法處理 response 結果
        self.handleResponse(response: response, completion: completion)
      }
    }

  // 定義處理 response 方法，參數 1，接收符合 Decodable 協定的泛型，參數 2，讓呼叫的物件可以直接透過此 closure 取得 response
  private func handleResponse(response: DataResponse<ResponseData, AFError>, completion: DoneHandler?) {
    switch response.result {
      case .success(let result):
//        // 嘗試取得 Server 返回的 JWT ( 如果有的話 )
//        let receivedJWT = response.response?.allHeaderFields["Authorization"] as? String
        // 把相關 response 資料返回到調用的 View
        completion?(result, nil)
      case .failure(let error):
        // 把相關 error 返回到調用的 View
        completion?(nil, error)
    }
  }
    
  private func checkUserID() {
    guard let user = UserDefaults.standard.string(forKey: "User") else {
      assertionFailure("Get UserID To Fail.")
      return
    }
    getUserURL = Communicator.baseURL + "users/\(user)/get-user"
    deleteUserURL = Communicator.baseURL + "users/\(user)/delete-user"
  }
}

struct ResponseData: Decodable {
  var status: String
  var code: String
  var message: String?
  var userID: String?
  var activityID: String?
  var data: [DataDetail]?
}

struct DataDetail: Decodable {
  var id: String?
  var account: String?
  var password: String?
  var name: String?
  var playtime: String?
  var handedness: String?
  var title: String?
  var time: String?
  var location: String?
  var latitude: Double?
  var longitude: Double?
  var spend: String?
  var information: String?
  var createAt: String?
  var updateAt: String?
  var deleteAt: String?
}
