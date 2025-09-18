import Foundation
import SurgeHTTPAPI

/// 请求处理示例
///
/// 此示例演示了如何使用 SurgeHTTPAPI 获取和处理请求数据
class RequestExample {
    
    /// 获取并处理最近的请求
    ///
    /// - Returns: 格式化的请求信息字符串
    func getFormattedRecentRequests() async throws -> String {
        do {
            // 获取最近的请求
            let requests = try await SurgeHTTPAPI.shared.getRecentRequests()
            
            // 格式化请求信息
            var result = "最近的请求:\n"
            result += "========================\n"
            
            for request in requests {
                result += formatRequest(request)
                result += "\n------------------------\n"
            }
            
            return result
        } catch {
            throw error
        }
    }
    
    /// 格式化单个请求信息
    ///
    /// - Parameter request: 要格式化的请求对象
    /// - Returns: 格式化的请求信息字符串
    private func formatRequest(_ request: Request) -> String {
        var result = ""
        
        result += "ID: \(request.id)\n"
        result += "方法: \(request.method)\n"
        result += "URL: \(request.url)\n"
        result += "状态: \(request.status)\n"
        result += "设备: \(request.deviceName)\n"
        result += "策略: \(request.policyName)\n"
        result += "入站字节: \(request.inBytes)\n"
        result += "出站字节: \(request.outBytes)\n"
        
        if request.failed {
            result += "失败: 是\n"
        } else {
            result += "失败: 否\n"
        }
        
        if let remark = request.remark {
            result += "备注: \(remark)\n"
        }
        
        // 添加计时信息
        if !request.timingRecords.isEmpty {
            result += "计时记录:\n"
            for timing in request.timingRecords {
                result += "  \(timing.name): \(timing.durationInMillisecond)ms\n"
            }
        }
        
        // 添加部分注释（最多显示5条）
        if !request.notes.isEmpty {
            result += "注释 (前5条):\n"
            let displayNotes = request.notes.prefix(5)
            for note in displayNotes {
                result += "  \(note)\n"
            }
            
            if request.notes.count > 5 {
                result += "  ... 还有 \(request.notes.count - 5) 条注释\n"
            }
        }
        
        return result
    }
    
    /// 分析请求数据
    ///
    /// - Parameter requests: 要分析的请求对象数组
    /// - Returns: 分析结果
    func analyzeRequests(_ requests: [Request]) -> String {
        var result = "请求分析:\n"
        result += "========================\n"
        
        // 统计信息
        let totalRequests = requests.count
        let failedRequests = requests.filter { $0.failed }.count
        let completedRequests = requests.filter { $0.completed }.count
        let localRequests = requests.filter { $0.local }.count
        
        result += "总请求数: \(totalRequests)\n"
        result += "失败请求数: \(failedRequests)\n"
        result += "完成请求数: \(completedRequests)\n"
        result += "本地请求数: \(localRequests)\n"
        
        // 方法统计
        let methodCounts = Dictionary(grouping: requests, by: { $0.method })
            .mapValues { $0.count }
            .sorted { $0.value > $1.value }
        
        result += "\n请求方法统计:\n"
        for (method, count) in methodCounts {
            result += "  \(method): \(count)\n"
        }
        
        // 设备统计
        let deviceCounts = Dictionary(grouping: requests, by: { $0.deviceName })
            .mapValues { $0.count }
            .sorted { $0.value > $1.value }
        
        result += "\n设备统计:\n"
        for (device, count) in deviceCounts {
            result += "  \(device): \(count)\n"
        }
        
        return result
    }
}

// MARK: - 使用示例
/*
// 在实际使用中，您可以这样调用：
let example = RequestExample()

Task {
    do {
        // 获取格式化的请求信息
        let formattedRequests = try await example.getFormattedRecentRequests()
        print(formattedRequests)
        
        // 获取原始请求数据并进行分析
        let requests = try await SurgeHTTPAPI.shared.getRecentRequests()
        let analysis = example.analyzeRequests(requests)
        print(analysis)
    } catch {
        print("获取请求数据失败: \(error)")
    }
}
*/
