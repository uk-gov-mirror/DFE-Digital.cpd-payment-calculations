@npq
Feature: NPQ single-qualification payment schedule calculation

  Scenario: Calculation of service fee payment schedule
    Given there's an qualification with a price-per-participant of £902
      And there are 19 monthly service fee payments
      And the recruitment target is 1000
    Then the service fee payment schedule should be:
        | Month | Service fee total |
        | 1     | £11,684.21        |
        | 2     | £11,684.21        |
        | 3     | £11,684.21        |
        | 4     | £11,684.21        |
        | 5     | £11,684.21        |
        | 6     | £11,684.21        |
        | 7     | £11,684.21        |
        | 8     | £11,684.21        |
        | 9     | £11,684.21        |
        | 10    | £11,684.21        |
        | 11    | £11,684.21        |
        | 12    | £11,684.21        |
        | 13    | £11,684.21        |
        | 14    | £11,684.21        |
        | 15    | £11,684.21        |
        | 16    | £11,684.21        |
        | 17    | £11,684.21        |
        | 18    | £11,684.21        |
        | 19    | £11,684.21        |
      And the service fee total should be £221,999.99

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
