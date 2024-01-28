import Foundation

struct UserModel: Codable {
    let userId: String
    let email: String?
    let name: String?
    let hasMarketProduct: Bool?
    let dataCreated: Date?
    
    init(auth: AuthDataResultModel) {
        self.userId = auth.uid
        self.email = auth.email
        self.name = auth.name
        self.hasMarketProduct = false
        self.dataCreated = Date()
    }
    
    init(
    userId: String,
    email: String? = nil,
    name: String? = nil,
    hasMarketProduct: Bool? = nil,
    dataCreated: Date? = nil
    ) {
        self.userId = userId
        self.email = email
        self.name = name
        self.hasMarketProduct = hasMarketProduct
        self.dataCreated = dataCreated
    }
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case email = "email"
        case name = "name"
        case hasMarketProduct = "has_market_product"
        case dataCreated = "data_created"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userId = try container.decode(String.self, forKey: .userId)
        self.email = try container.decodeIfPresent(String.self, forKey: .email)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.hasMarketProduct = try container.decodeIfPresent(Bool.self, forKey: .hasMarketProduct)
        self.dataCreated = try container.decodeIfPresent(Date.self, forKey: .dataCreated)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.userId, forKey: .userId)
        try container.encodeIfPresent(self.email, forKey: .email)
        try container.encodeIfPresent(self.name, forKey: .name)
        try container.encodeIfPresent(self.hasMarketProduct, forKey: .hasMarketProduct)
        try container.encodeIfPresent(self.dataCreated, forKey: .dataCreated)
    }
}
