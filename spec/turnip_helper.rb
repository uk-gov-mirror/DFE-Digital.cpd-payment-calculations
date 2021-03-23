# This file is automatically loaded by the BDD gem turnip https://github.com/jnicklas/turnip#where-to-place-steps

Dir.glob("spec/steps/**/*steps.rb") { |f| load f, true }
Dir.glob("spec/placeholders/**/*placeholder.rb") { |f| load f, true }

