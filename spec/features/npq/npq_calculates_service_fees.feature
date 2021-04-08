@npq
Feature: NPQ single-qualification payment schedule calculation

  Scenario: Calculation of service fee payment schedule
  Course NPQLTD
    Given there's an qualification with a price-per-participant of £902
      And there are 19 monthly service fee payments
      And the recruitment target is 1000
    Then the service fee payment schedule should be:
        | Month | Service fee total |
        | 1     | £18,989.47        |
        | 2     | £18,989.47        |
        | 3     | £18,989.47        |
        | 4     | £18,989.47        |
        | 5     | £18,989.47        |
        | 6     | £18,989.47        |
        | 7     | £18,989.47        |
        | 8     | £18,989.47        |
        | 9     | £18,989.47        |
        | 10    | £18,989.47        |
        | 11    | £18,989.47        |
        | 12    | £18,989.47        |
        | 13    | £18,989.47        |
        | 14    | £18,989.47        |
        | 15    | £18,989.47        |
        | 16    | £18,989.47        |
        | 17    | £18,989.47        |
        | 18    | £18,989.47        |
        | 19    | £18,989.47        |
      And the service fee total should be £360,800.00
      
      Scenario: Calculation of service fee payment schedule
  Course NPQSL
    Given there's an qualification with a price-per-participant of £1149
      And there are 25 monthly service fee payments
      And the recruitment target is 1000
    Then the service fee payment schedule should be:
        | Month | Service fee total |
        | 1     | £18,384.00        |
        | 2     | £18,384.00        |
        | 3     | £18,384.00        |
        | 4     | £18,384.00        |
        | 5     | £18,384.00        |
        | 6     | £18,384.00        |
        | 7     | £18,384.00        |
        | 8     | £18,384.00        |
        | 9     | £18,384.00        |
        | 10    | £18,384.00        |
        | 11    | £18,384.00        |
        | 12    | £18,384.00        |
        | 13    | £18,384.00        |
        | 14    | £18,384.00        |
        | 15    | £18,384.00        |
        | 16    | £18,384.00        |
        | 17    | £18,384.00        |
        | 18    | £18,384.00        |
        | 19    | £18,384.00        |
        | 20    | £18,384.00        |
        | 21    | £18,384.00        |
        | 22    | £18,384.00        |
        | 23    | £18,384.00        |
        | 24    | £18,384.00        |
        | 25    | £18,384.00        |
      And the service fee total should be £459,600.00
      
      Scenario: Calculation of service fee payment schedule
      Course NPQLH
    Given there's an qualification with a price-per-participant of £1985
      And there are 31 monthly service fee payments
      And the recruitment target is 1000
    Then the service fee payment schedule should be:
        | Month | Service fee total |
        | 1     | £25,612.90        |
        | 2     | £25,612.90        |
        | 3     | £25,612.90        |
        | 4     | £25,612.90        |
        | 5     | £25,612.90        |
        | 6     | £25,612.90        |
        | 7     | £25,612.90        |
        | 8     | £25,612.90        |
        | 9     | £25,612.90        |
        | 10    | £25,612.90        |
        | 11    | £25,612.90        |
        | 12    | £25,612.90        |
        | 13    | £25,612.90        |
        | 14    | £25,612.90        |
        | 15    | £25,612.90        |
        | 16    | £25,612.90        |
        | 17    | £25,612.90        |
        | 18    | £25,612.90        |
        | 19    | £25,612.90        |
        | 20    | £25,612.90        |
        | 21    | £25,612.90        |
        | 22    | £25,612.90        |
        | 23    | £25,612.90        |
        | 24    | £25,612.90        |
        | 25    | £25,612.90        |
        | 26    | £25,612.90        |
        | 27    | £25,612.90        |
        | 28    | £25,612.90        |
        | 29    | £25,612.90        |
        | 30    | £25,612.90        |
        | 31    | £25,612.90        |
    And the service fee total should be £794,000.00

  Scenario: Calculation of variable fee payment schedule with one retention point
    Given there's an qualification with a price-per-participant of £555
      And there are the following retention points:
        | Payment Type | Retained Participants | Expected Per-Teacher Variable Fee | Expected Variable Fee |
        | Commencement | 1000                  | £111                              | £111,000.00           |
        | Retention 1  | 700                   | £111                              | £77,700.00            |
        | Completion   | 300                   | £111                              | £33,300.00            |
    Then expected variable fees should be as above

  Scenario: Calculation of variable fee payment schedule with two retention points
    Given there's an qualification with a price-per-participant of £823
      And there are the following retention points:
        | Payment Type | Retained Participants | Expected Per-Teacher Variable Fee | Expected Variable Fee |
        | Commencement | 900                   | £123.45                           | £111,105.00           |
        | Retention 1  | 700                   | £123.45                           | £86,415.00            |
        | Retention 2  | 650                   | £123.45                           | £80,242.50            |
        | Completion   | 432                   | £123.45                           | £53,330.40            |
    Then expected variable fees should be as above
