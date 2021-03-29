Feature: NPQ payment calculation engine

  Scenario: Calculation of NPQ service fees
    Given the NPQ recruitment target is 1000
    And there are the following qualifications:
      | Name                                           | Price per-teacher | Minimum delivery months | Expected service fee | Expected monthly service fee |
      | NPQ Leading Teacher Development (NPQLTD)       | £902              | 19                      | £360,800.00          | £18,989.47                   |
      | NPQ for Leading Teaching (NPQLT)               | £902              | 19                      | £360,800.00          | £18,989.47                   |
      | NPQ for Leading Behaviour and Culture (NPQLBC) | £902              | 19                      | £360,800.00          | £18,989.47                   |
      | NPQ for Senior Leadership (NPQSL)              | £1149             | 25                      | £45,9600.00          | £18,384.00                   |
      | NPQ for Headship (NPQH)                        | £1985             | 31                      | £794,000.00          | £25,612.90                   |
      | NPQ for Executive Leadership (NPQEL)           | £4099             | 25                      | £1,639,600.00        | £65,584.00                   |
    When I run the NPQ calculation
    Then the correct monthly service fees are calculated
    And the payment schedule is:
      | Month | Service fee total | Comments                                               |
      | 1     | £16,6549.31       |                                                        |
      | 2     | £16,6549.31       |                                                        |
      | 3     | £16,6549.31       |                                                        |
      | 4     | £16,6549.31       |                                                        |
      | 5     | £16,6549.31       |                                                        |
      | 6     | £16,6549.31       |                                                        |
      | 7     | £16,6549.31       |                                                        |
      | 8     | £16,6549.31       |                                                        |
      | 9     | £16,6549.31       |                                                        |
      | 10    | £16,6549.31       |                                                        |
      | 11    | £16,6549.31       |                                                        |
      | 12    | £16,6549.31       |                                                        |
      | 13    | £16,6549.31       |                                                        |
      | 14    | £16,6549.31       |                                                        |
      | 15    | £16,6549.31       |                                                        |
      | 16    | £16,6549.31       |                                                        |
      | 17    | £16,6549.31       |                                                        |
      | 18    | £16,6549.31       |                                                        |
      | 19    | £16,6549.31       | Last month with all courses running                    |
      | 20    | £10,9580.90       | Lower than month 19 because some courses have finished |
      | 21    | £10,9580.90       |                                                        |
      | 22    | £10,9580.90       |                                                        |
      | 23    | £10,9580.90       |                                                        |
      | 24    | £10,9580.90       |                                                        |
      | 25    | £10,9580.90       |                                                        |
      | 26    | £25,612.90        |                                                        |
      | 27    | £25,612.90        |                                                        |
      | 28    | £25,612.90        |                                                        |
      | 29    | £25,612.90        |                                                        |
      | 30    | £25,612.90        |                                                        |
      | 31    | £25,612.90        | todo: Includes rounding?                               |
