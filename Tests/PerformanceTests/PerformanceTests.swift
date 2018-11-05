import Foundation
import PathKit
import ProjectSpec
import XcodeGenKit
import xcodeproj
import XCTest

class GeneratedPerformanceTests: XCTestCase {

    let basePath = Path.temporary + "XcodeGenPeformanceTests"

    func testGeneration() throws {
        let project = try Project.testProject(basePath: basePath)
        measure {
            let generator = ProjectGenerator(project: project)
            _ = try! generator.generateXcodeProject()
        }
    }

    func testWriting() throws {
        let project = try Project.testProject(basePath: basePath)
        let generator = ProjectGenerator(project: project)
        let xcodeProject = try generator.generateXcodeProject()
        measure {
            xcodeProject.pbxproj.invalidateUUIDs()
            try! xcodeProject.write(path: project.defaultProjectPath)
        }
    }
}

let fixturePath = Path(#file).parent().parent() + "Fixtures"

class FixturePerformanceTests: XCTestCase {

    let specPath = fixturePath + "TestProject/project.yml"

    func testFixtureDecoding() throws {
        measure {
            _ = try! Project(path: specPath)
        }
    }

    func testFixtureGeneration() throws {
        let project = try Project(path: specPath)
        measure {
            let generator = ProjectGenerator(project: project)
            _ = try! generator.generateXcodeProject()
        }
    }

    func testFixtureWriting() throws {
        let project = try Project(path: specPath)
        let generator = ProjectGenerator(project: project)
        let xcodeProject = try generator.generateXcodeProject()
        measure {
            xcodeProject.pbxproj.invalidateUUIDs()
            try! xcodeProject.write(path: project.defaultProjectPath)
        }
    }
}
