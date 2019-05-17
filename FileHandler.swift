if let json = FileHandler.openFile() {
        FileHandler.codeCoverage(for: json)
      }

class FileHandler {
  static func openFile() -> [String: Any]? {
    if let fileURL = Bundle.main.url(forResource: "coverage2", withExtension: "json") {
      if let data = try? Data(contentsOf: fileURL) {
        if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] {
          return json
        }
      }
    }
    
    return nil
  }
  
  static func codeCoverage(for json: [String: Any]) {
    if let targets = json["targets"] as? [[String: Any]] {
      targets.forEach { target in
        if let targetName = target["name"] as? String {
          if targetName == "Test.app" {
            if let files = target["files"] as? [[String: Any]] {
              var liveTestCoverageFiles = [[String: Any]]()
              files.forEach { file in
                if let path = file["path"] as? String {
                  if path.contains("Telegraph Live") {
                    liveTestCoverageFiles.append(file)
                  }
                }
              }
              print("covered items \(liveTestCoverageFiles.count)")
              let liveTestCoverageScores = liveTestCoverageFiles.compactMap({ (file) -> Double? in
                if let coverageScore = file["lineCoverage"] as? Double {
                  return coverageScore != 0 ? coverageScore : nil
                }
                
                return nil
              })
              print("coverage scores \(liveTestCoverageScores.count)")
              print("average coverage score \(liveTestCoverageScores.reduce(0,+) / Double(liveTestCoverageScores.count))")
            }
          }
        }
      }
    }
  }
}