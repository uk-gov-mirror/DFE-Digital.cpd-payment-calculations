@ecf
Feature: ECF payment calculation engine

  Scenario: Calculation of variable fees
    Given the recruitment target is 2000
      And Band A per-participant price is £995
      And there are the following retention numbers:
        | Payment Type | Retained Participants | Expected Per-Participant Variable Fee    | Expected Variable Fee |
        | Start        | 1900                  | £119.40                                  | £226,860              |
        | Retention 1  | 1700                  | £89.55                                   | £152,235              |
        | Retention 2  | 1500                  | £89.55                                   | £134,325              |
        | Retention 3  | 1000                  | £89.55                                   | £89,550               |
        | Retention 4  | 800                   | £89.55                                   | £71,640               |
        | Completion   | 500                   | £119.40                                  | £59,700               |
    When I run the calculation
    Then the per-participant service fee should be £398
      And the total service fee should be £796,000
      And the monthly service fee should be £27,448
      And the variable payment per-participant should be £597
      And the variable payment schedule should be as above

#  Scenario: Calculation of service fees
#    Given the recruitment target is 2000
#      And Band A per-participant price is £1,350
#    When I run the calculation
#    Then The per-participant service fee should be £540
#      And The total service fee should be £1,080,000
#      And The monthly service fee should be £37,241
