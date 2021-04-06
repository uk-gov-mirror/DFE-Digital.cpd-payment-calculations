Feature: NPQ single-qualification payment schedule calculation

  @npq
  Scenario: Calculation of service fee payment schedule
    Given there's an qualification with a price-per-participant of £555
      And there are 19 monthly service fee payments
      And the recruitment target is 1000
    When I run the calculation
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
