type
    Sellers* = object

        sellerID*: int
        sellerName*: string
        
        sellerLimit*: int
        sellerLimitExpanded*: bool
        sellerLimitIfExpanded*: int

        sellerTrustScore*: float
        sellerMarkedScammer*: bool
        sellerLevel*: int
        sellerDiscount*: int

        sellerMarkedPromoted*: bool