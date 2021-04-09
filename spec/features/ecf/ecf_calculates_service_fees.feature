@ecf
Feature: ECF payment calculation engine

  Scenario: Calculation of variable fees for a single product
    Given the recruitment target is 2000
      And Band A per-participant price is £995
      And there are the following retention numbers:
        | Payment Type | Month    |Retained Participants  | Expected Per-Participant Variable Fee    | Expected Variable Fee Subtotal |
        | Start        | Jan 2021 | 1900                  | £119.40                                  | £226,860                       |
        | Retention 1  | Jun 2021 | 1700                  | £89.55                                   | £152,235                       |
        | Retention 2  | Feb 2022 | 1500                  | £89.55                                   | £134,325                       |
        | Retention 3  | Jul 2022 | 1000                  | £89.55                                   | £89,550                        |
        | Retention 4  | Mar 2023 | 800                   | £89.55                                   | £71,640                        |
        | Completion   | Aug 2023 | 500                   | £119.40                                  | £59,700                        |
    When I run the calculation
    Then the per-participant service fee should be £398
      And the total service fee should be £796,000
      And the monthly service fee should be £27,448
      And the variable payment per-participant should be £597
      And the variable payment schedule should be as above
