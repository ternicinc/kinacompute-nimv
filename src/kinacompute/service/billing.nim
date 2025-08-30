type
    Billing* = object

      billingType*: string
      billingTypePAYG*: bool

      # If Pay-As-You-Go.
      billingPAYGLimit*: int
      billingPAYGOverLimit*: bool
      billingPAYGExtendedLimit*: bool

      # Applicable for both PAYG and Pre-Paid.
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
