@ecf
Feature: ECF payment calculation engine

  # These numbers are from the example "Call Off Pricing Schedule" .xlsm example files supplied to the team
  Scenario: Calculation of service fees
    Given the recruitment target is 2000
      And Band A per-participant price is £995
    When I run the calculation
    Then The per-participant service fee should be £398
      And The total service fee should be £796,000
      And The monthly service fee should be £27,448

  Scenario: Calculation of service fees
    Given the recruitment target is 2000
      And Band A per-participant price is £1,350
    When I run the calculation
    Then The per-participant service fee should be £540
      And The total service fee should be £1,080,000
      And The monthly service fee should be £37,241
