//
//  Event.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on November 1, 2018

import Foundation

public struct EventResponse : Codable {
	public let actor : EventResponseActor?
	public let createdAt : String?
	public let id : String?
	public let org : EventResponseOrg?
	public let payload : EventResponsePayload?
	public let publicField : Bool?
	public let repo : EventResponseRepo?
	public let type : String?
	
	enum CodingKeys: String, CodingKey {
		case actor = "actor"
		case createdAt = "created_at"
		case id = "id"
		case org = "org"
		case payload = "payload"
		case publicField = "public"
		case repo = "repo"
		case type = "type"
	}
	
	public init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		actor = try values.decodeIfPresent(EventResponseActor.self, forKey: .actor)
		createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
		id = try values.decodeIfPresent(String.self, forKey: .id)
		org = try values.decodeIfPresent(EventResponseOrg.self, forKey: .org)
		payload = try values.decodeIfPresent(EventResponsePayload.self, forKey: .payload)
		publicField = try values.decodeIfPresent(Bool.self, forKey: .publicField)
		repo = try values.decodeIfPresent(EventResponseRepo.self, forKey: .repo)
		type = try values.decodeIfPresent(String.self, forKey: .type)
	}
	
}
