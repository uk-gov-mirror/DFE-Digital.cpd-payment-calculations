@ecf
Feature: ECF payment calculation engine

  # These numbers are from the example "Call Off Pricing Schedule" .xlsm example files supplied to the team
  Scenario: Calculation of variable service fees
    Given the recruitment target is 2000
      And Band A per-participant price is £995
    When I run the calculation
    Then The per-participant service fee should be £398
      And The total service fee should be £796,000
      And The monthly service fee should be £27,448
      And The starting payment per-teacher variable fee is £597
      And The starting variable fee is £119.40
      And The completion payment per-teacher variable fee is £119.40
      And The retention payment schedule should be:
        | Payment Type | Retained Participants | Expected Per-Teacher Variable Fee    | Expected Variable Fee |
        | Retention 1  | 2000                  | £89.55                               | £179,100              |
        | Retention 2  | 2000                  | £89.55                               | £179,100              |
        | Retention 3  | 2000                  | £89.55                               | £179,100              |
        | Retention 4  | 2000                  | £89.55                               | £179,100              |

  Scenario: Calculation of service fees
    Given the recruitment target is 2000
      And Band A per-participant price is £1,350
    When I run the calculation
    Then The per-participant service fee should be £540
      And The total service fee should be £1,080,000
      And The monthly service fee should be £37,241
