import XCTest
@testable import siren_package

func parseJsonString(jsonStr: String) -> [String: Any]? {
    let data = Data(jsonStr.utf8)
    do {
        guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
            return nil
        }
        return json
    }
    catch _ as NSError {
        return nil
    }
}

final class siren_packageTests: XCTestCase {
    func testProcessTrack() throws {
        let thisFile = URL(fileURLWithPath: #file)
        let projectRoot = thisFile
            .deletingLastPathComponent()
            .deletingLastPathComponent()
            .deletingLastPathComponent()
            .path
        
        let audioPath = "\(projectRoot)/Resources/Audio/jazzfrom5to7.wav"
        
        let sirenWrapper = SirenWrapper()
        let t1 = DispatchTime.now().uptimeNanoseconds
        
        if let json = sirenWrapper.processTrack(audioPath) {
            let parsedJson = parseJsonString(jsonStr: json)
            
            let t2 = DispatchTime.now().uptimeNanoseconds
            print("Time taken: ", (t2-t1)/UInt64(1e6), "ms")
            
            let code = parsedJson?["core_code"] as? Int
            XCTAssert(code == 0)
            return
        }
        XCTAssert(false)
    }
}
