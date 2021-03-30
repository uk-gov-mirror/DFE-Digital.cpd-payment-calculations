Feature: ECF payment calculation engine

  Scenario Outline: Calculation of ECF service fees
    Given the ECF recruitment target is <recruitment_target>
      # Band A cost from cell F20:
      And Band A per-participant price is <band_a>
      # Band B cost from cell F21:
      And Band B per-participant price is <band_b>
      # Band C cost from cell F21:
      And Band C per-participant price is <band_c>
      # Setup cost from cell Y20:
      And The set-up cost is <setup_cost>
    When I run the ECF calculation
    # per-participant service fee from cell E60
    Then The per-participant service fee is <output_per_participant_fee>
      # total service fee from cell D60
      And The total service fee is <output_total_fee>
      # monthly service fee from cell F60
      And The monthly service fee is <output_monthly_fee>
    Examples:
      # These numbers are from the example "Call Off Pricing Schedule" .xlsm example files supplied to the team
      | recruitment_target | band_a | band_b | band_c | setup_cost | output_per_participant_fee | output_total_fee | output_monthly_fee |
      | 2000               | £995   | £979   | £966   | £0.00      | £398                       | £796,000         | £27,448            |
      | 2000               | £1,350 | £1,250 | £1,150 | £0.00      | £540                       | £1,080,000       | £37,241            |
