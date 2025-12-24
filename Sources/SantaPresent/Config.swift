import Foundation

/// アプリケーションの設定
/// ⚠️ このファイルは .gitignore に含めてください
struct Config {
    /// バックエンドAPIのベースURL
    static let apiBaseURL = "https://santa-present-f395b2e91f52.herokuapp.com"

    /// ギフト作成エンドポイント
    static let giftsEndpoint = "\(apiBaseURL)/gifts"
}
