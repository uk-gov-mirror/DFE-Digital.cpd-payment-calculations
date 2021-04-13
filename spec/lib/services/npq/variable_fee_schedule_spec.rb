# frozen_string_literal: true

describe Services::Npq::VariableFeeSchedule do
  let(:config) do
    {
      recruitment_target: 2000,
      price_per_participant: BigDecimal(456.78, 10),
      number_of_monthly_payments: 19,
      retention_points: {
        "Commencement": {
          retained_participants: 100,
        },
        "Retention 1": {
          retained_participants: 72,
        },
        "Retention 2": {
          retained_participants: 51,
        },
        "Completion": {
          retained_participants: 38,
        },
      },
    }
  end

  describe "#variable_fee_schedule" do
    let(:result) { Services::Npq::VariableFeeSchedule.call(config) }

    it "includes config in the output" do
      expect(result[:input]).to eq(config)
    end

    it "returns BigDecimal for all money outputs" do
      result.dig(:output, :variable_fee_schedule).each do |_key, value|
        expect(value[:per_teacher_variable_fee]).to be_a(BigDecimal)
        expect(value[:total_variable_fee]).to be_a(BigDecimal)
      end
    end
  end
end
