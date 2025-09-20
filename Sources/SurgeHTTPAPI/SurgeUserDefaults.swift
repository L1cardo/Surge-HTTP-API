@preconcurrency import Defaults

/// Surge UserDefaults 配置管理
extension Defaults.Keys {
    /// Surge HTTP API 的基础 URL
    static let baseURL = Key<String>("SurgeBaseURL", default: "http://127.0.0.1:6171")

    /// Surge HTTP API 的密钥
    static let apiKey = Key<String>("SurgeAPIKey", default: "your-api-key")
}
