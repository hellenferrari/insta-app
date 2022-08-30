//
// Copyright © Hellen Ferrari. All rights reserved.
//

import XCTest
@testable import EssentialFeed

class RemoteFeedLoader {
    
    let client: HTTPClient
    
    public init(client: HTTPClient) {
        self.client = client
    }
    
    func load() {
        client.get(from: URL(string: "https://a-url.com")!)
    }
}

protocol HTTPClient {
    func get(from url: URL)
    
}

class HTTPClientSpy: HTTPClient {
    func get(from url: URL) {
        requestedURL = url
    }
    
    var requestedURL: URL?
}




class RemoteFeedLoaderTests: XCTestCase {

    func test_init_doesNotRequestDataFromURL() {
        let client = HTTPClientSpy()
        
        let _ = RemoteFeedLoader(client: client)
        
        XCTAssertNil(client.requestedURL)
    }

    func test_load_requestDataFromURL() {
        let client = HTTPClientSpy()
        
        let sut = RemoteFeedLoader(client: client)
        
        sut.load()
        
        XCTAssertNotNil(client.requestedURL)
    }
}
