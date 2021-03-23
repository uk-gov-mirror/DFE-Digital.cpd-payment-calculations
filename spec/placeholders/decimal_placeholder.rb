# Convert decimal strings to decimal values. Ref: https://github.com/jnicklas/turnip#custom-step-placeholders
placeholder :decimal_placeholder do
  match(/\d+\.?\d+/, &:to_d)
end
