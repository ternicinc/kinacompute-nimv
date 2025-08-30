import options

type
    Billing* = object
      billingType*: string
      billingAmount*: int # Maybe a string ?
      billingNumber*: int
      issuerName*: string

      recipientName*: string
      recipientID*: int
      recipientPlan*: string

      
      issuerID*: int
      issuerOfficial*: bool # If it's a seller or the company itself.
      issuerVerified*: bool

      platformID*: int
      platformLocation*: string
