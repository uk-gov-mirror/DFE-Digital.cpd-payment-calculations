# This file is automatically loaded by the BDD gem turnip https://github.com/jnicklas/turnip#where-to-place-steps

Dir.glob("spec/steps/**/*steps.rb") { |f| load f, true }

# Convert decimal strings to decimal values. Ref: https://github.com/jnicklas/turnip#custom-step-placeholders
placeholder :decimal_placeholder do
  match(/\d+\.?\d+/, &:to_d)
end
