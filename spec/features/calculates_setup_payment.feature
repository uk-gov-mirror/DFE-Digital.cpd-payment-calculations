Feature: Calculate payments
  Scenario: Calculation of service fees
    # These numbers are from the example "Call Off Pricing Schedule" .xlsm example files supplied to the team
    Given the recruitment target is 2000
      # Band A cost from cell F20:
      And Band A per-participant price is £995
      # Band B cost from cell F21:
      And Band B per-participant price is £979
      # Band C cost from cell F21:
      And Band C per-participant price is £966
      # Setup cost from cell Y20:
      And The set-up cost is £0.00
    When I run the calculation
    # per-participant service fee from cell E60
    Then The per-participant service fee is £398
      # total service fee from cell D60
      And The total service fee is £796,000
      # monthly service fee from cell F60
      And The monthly service fee is £27,448
