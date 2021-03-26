Feature: Calculate payments
  Scenario: Calculation of service fees
    Given the recruitment target is 2000
      And Band A per-participant price is £995
      And Band B per-participant price is £979
      And Band C per-participant price is £966
      And The set-up cost is £0.00
    When I run the calculation
    Then The per-participant service fee is £398
      And The total service fee is £796,000
      And The monthly service fee is £27,448
