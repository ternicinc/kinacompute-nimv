type
    Clients* = object

        clientID*: int
        clientName*: string

        clientLimit*: int
        clientLimitExpanded*: bool
        clientLimitIfExpanded*: int

        clientBillingType*: string
        clientBillingOwed*: int # Maybe a string ?
        clientBillingBehind*: bool
        clientBillingBehindAmount*: int # Maybe a string as well ?

        clientIsPromoter*: bool
        
        clientVeteran*: bool
        clientLevel*: int

        clientAccessMarketplace*: bool
