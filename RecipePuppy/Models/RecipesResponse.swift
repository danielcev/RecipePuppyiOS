//
//  RecipesResponse.swift
//
//  Created by Daniel Plata on 2/8/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class RecipesResponse: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let version = "version"
    static let title = "title"
    static let href = "href"
    static let results = "results"
  }

  // MARK: Properties
  public var version: Float?
  public var title: String?
  public var href: String?
  public var results: [Results]?

  // MARK: SwiftyJSON Initializers
  /// Initiates the instance based on the object.
  ///
  /// - parameter object: The object of either Dictionary or Array kind that was passed.
  /// - returns: An initialized instance of the class.
  public convenience init(object: Any) {
    self.init(json: JSON(object))
  }

  /// Initiates the instance based on the JSON that was passed.
  ///
  /// - parameter json: JSON object from SwiftyJSON.
  public required init(json: JSON) {
    version = json[SerializationKeys.version].float
    title = json[SerializationKeys.title].string
    href = json[SerializationKeys.href].string
    if let items = json[SerializationKeys.results].array { results = items.map { Results(json: $0) } }
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = version { dictionary[SerializationKeys.version] = value }
    if let value = title { dictionary[SerializationKeys.title] = value }
    if let value = href { dictionary[SerializationKeys.href] = value }
    if let value = results { dictionary[SerializationKeys.results] = value.map { $0.dictionaryRepresentation() } }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.version = aDecoder.decodeObject(forKey: SerializationKeys.version) as? Float
    self.title = aDecoder.decodeObject(forKey: SerializationKeys.title) as? String
    self.href = aDecoder.decodeObject(forKey: SerializationKeys.href) as? String
    self.results = aDecoder.decodeObject(forKey: SerializationKeys.results) as? [Results]
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(version, forKey: SerializationKeys.version)
    aCoder.encode(title, forKey: SerializationKeys.title)
    aCoder.encode(href, forKey: SerializationKeys.href)
    aCoder.encode(results, forKey: SerializationKeys.results)
  }

}
