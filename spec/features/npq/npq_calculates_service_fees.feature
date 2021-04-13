@npq
Feature: NPQ single-qualification payment schedule calculation

  Scenario: Calculation of payment schedules with one retention point
    Given there's a qualification with a per-participant price of £555
      And there are 19 monthly service fee payments
      And the recruitment target is 1000
      And there are the following retention points:
        | Payment Type | Retained Participants | Expected Per-Participant Variable Payment | Expected Variable Payment Subtotal |
        | Commencement | 1000                  | £111                                      | £111,000.00                    |
        | Retention 1  | 700                   | £111                                      | £77,700.00                     |
        | Completion   | 300                   | £111                                      | £33,300.00                     |
    Then expected variable payments should be as above
      And the service fee payment schedule should be:
        | Month | Service Fee |
        | 1     | £11,684.21  |
        | 2     | £11,684.21  |
        | 3     | £11,684.21  |
        | 4     | £11,684.21  |
        | 5     | £11,684.21  |
        | 6     | £11,684.21  |
        | 7     | £11,684.21  |
        | 8     | £11,684.21  |
        | 9     | £11,684.21  |
        | 10    | £11,684.21  |
        | 11    | £11,684.21  |
        | 12    | £11,684.21  |
        | 13    | £11,684.21  |
        | 14    | £11,684.21  |
        | 15    | £11,684.21  |
        | 16    | £11,684.21  |
        | 17    | £11,684.21  |
        | 18    | £11,684.21  |
        | 19    | £11,684.21  |
      And the service fee total should be £221,999.99

  Scenario: Calculation of payment schedules with two retention points
    Given there's a qualification with a per-participant price of £823
      And there are 19 monthly service fee payments
      And the recruitment target is 1000
      And there are the following retention points:
        | Payment Type | Retained Participants | Expected Per-Participant Variable Payment | Expected Variable Payment Subtotal |
        | Commencement | 900                   | £123.45                                   | £111,105.00                    |
        | Retention 1  | 700                   | £123.45                                   | £86,415.00                     |
        | Retention 2  | 650                   | £123.45                                   | £80,242.50                     |
        | Completion   | 432                   | £123.45                                   | £53,330.40                     |
    Then expected variable payments should be as above
      And the service fee payment schedule should be:
        | Month | Service Fee |
        | 1     | £17,326.32  |
        | 2     | £17,326.32  |
        | 3     | £17,326.32  |
        | 4     | £17,326.32  |
        | 5     | £17,326.32  |
        | 6     | £17,326.32  |
        | 7     | £17,326.32  |
        | 8     | £17,326.32  |
        | 9     | £17,326.32  |
        | 10    | £17,326.32  |
        | 11    | £17,326.32  |
        | 12    | £17,326.32  |
        | 13    | £17,326.32  |
        | 14    | £17,326.32  |
        | 15    | £17,326.32  |
        | 16    | £17,326.32  |
        | 17    | £17,326.32  |
        | 18    | £17,326.32  |
        | 19    | £17,326.32  |
      And the service fee total should be £329,200.08
