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
    And The variable payment per-teacher is £597
      And The retention payment schedule should be:
        | Payment Type | Retained Participants | Expected Per-Teacher Variable Fee    | Expected Variable Fee |
        | Start        | 1900                  | £119.40                              | £238,800              |
        | Retention 1  | 1700                  | £89.55                               | £179,100              |
        | Retention 2  | 1500                  | £89.55                               | £179,100              |
        | Retention 3  | 1000                  | £89.55                               | £179,100              |
        | Retention 4  | 800                   | £89.55                               | £179,100              |
        | Completion   | 500                   | £119.40                              | £238,800              |

  Scenario: Calculation of service fees
    Given the recruitment target is 2000
      And Band A per-participant price is £1,350
    When I run the calculation
    Then The per-participant service fee should be £540
      And The total service fee should be £1,080,000
      And The monthly service fee should be £37,241
