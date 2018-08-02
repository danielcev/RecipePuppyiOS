//
//  Results.swift
//
//  Created by Daniel Plata on 2/8/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class Results: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let ingredients = "ingredients"
    static let title = "title"
    static let href = "href"
    static let thumbnail = "thumbnail"
  }

  // MARK: Properties
  public var ingredients: String?
  public var title: String?
  public var href: String?
  public var thumbnail: String?

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
    ingredients = json[SerializationKeys.ingredients].string
    title = json[SerializationKeys.title].string
    href = json[SerializationKeys.href].string
    thumbnail = json[SerializationKeys.thumbnail].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = ingredients { dictionary[SerializationKeys.ingredients] = value }
    if let value = title { dictionary[SerializationKeys.title] = value }
    if let value = href { dictionary[SerializationKeys.href] = value }
    if let value = thumbnail { dictionary[SerializationKeys.thumbnail] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.ingredients = aDecoder.decodeObject(forKey: SerializationKeys.ingredients) as? String
    self.title = aDecoder.decodeObject(forKey: SerializationKeys.title) as? String
    self.href = aDecoder.decodeObject(forKey: SerializationKeys.href) as? String
    self.thumbnail = aDecoder.decodeObject(forKey: SerializationKeys.thumbnail) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(ingredients, forKey: SerializationKeys.ingredients)
    aCoder.encode(title, forKey: SerializationKeys.title)
    aCoder.encode(href, forKey: SerializationKeys.href)
    aCoder.encode(thumbnail, forKey: SerializationKeys.thumbnail)
  }

}
