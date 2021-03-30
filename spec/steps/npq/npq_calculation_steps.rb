# frozen_string_literal: true

module NpqCalculationSteps
  step "the NPQ recruitment target is :decimal_placeholder" do |value|
    @recruitment_target = value.to_i
  end

  step "there are the following qualifications:" do |table|
    @qualifications = {}
    table.hashes.each do |row|
      @qualifications[row["Name"]] = {
        price_per_teacher: CurrencyParser.currency_to_big_decimal(row["Price per-teacher"]),
        minimum_delivery_months: row["Minimum delivery months"].to_i,
        expected_service_fee: CurrencyParser.currency_to_big_decimal(row["Expected service fee"]),
        expected_monthly_service_fee: CurrencyParser.currency_to_big_decimal(row["Expected monthly service fee"]),
      }
    end
  end

  step "I run the NPQ calculation" do
    config = {
      recruitment_target: @recruitment_target,
      qualifications: @qualifications.transform_values do |values|
        {
          minimum_delivery_months: values[:minimum_delivery_months],
          price_per_teacher: values[:price_per_teacher],
        }
      end,
    }
    calculator = NpqPaymentCalculationService.new(config)
    @result = calculator.calculate
  end

  step "the ouput should have the above service fees" do
    aggregate_failures "service fees" do
      @qualifications.each do |name, values|
        # Output keyed on name because we don't currently have a database storage of qualifications to give us anything else to key on.
        expect_with_context(@result.dig(:output, :qualifications, name, :service_fee), values[:expected_service_fee], "Service fee for '#{name}'")
        expect_with_context(@result.dig(:output, :qualifications, name, :monthly_service_fee), values[:expected_monthly_service_fee], "Monthly service fee for '#{name}'")
      end
    end
  end

  step "the output should include the following payment schedule:" do |table|
    @expected_payment_schedule = {}
    table.hashes.each do |row|
      @expected_payment_schedule[row["Month"].to_i] = CurrencyParser.currency_to_big_decimal(row["Service fee total"])
    end
    @expected_payment_schedule.each do |month, expected_amount|
      expect_with_context(@result.dig(:output, :payment_schedule, month), expected_amount, "Payment for month '#{month}'")
    end
  end

  step "the total payable amount in all outputs should be £:decimal_placeholder" do |expected_value|
    expect(@result[:output][:qualifications].values.map { |q| q[:service_fee] }.sum).to eq(expected_value)
    expect(@result[:output][:payment_schedule].values.sum).to eq(expected_value)
  end
end

RSpec.configure do |config|
  config.include NpqCalculationSteps
end
