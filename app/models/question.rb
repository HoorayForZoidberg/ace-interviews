class Question < ApplicationRecord
  has_many :meetings

  INDUSTRIES = ["Consumer Goods", "Airlines", "Energy (Oil & Gas / Mining)", "Financial Services (Insurance)", "Manufacturing", "Media", "Pharmaceuticals", "Private Equity", "Technology", "Telecom / Mobile", "Sports", "Other"]
  TYPES = ["Market Entry", "M&A", "New Product Development", "Pricing", "New Business", "Competitive response",	"Increase Sales", "Reduce Cost", "Increase Profit",	"Turn-around"]
									
  validates :industry, inclusion: { in: INDUSTRIES }
  validates :type, inclusion: { in: TYPES }
end
