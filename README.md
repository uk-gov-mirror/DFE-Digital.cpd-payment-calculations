# cpd-payment-calculations
Draft payment calculations engine

## About

This engine performs all payment calculations for both [ECFs (Early Career Framework)](https://www.early-career-framework.education.gov.uk/) and [the reformed NPQs (National Professional Qualification)](https://www.gov.uk/government/publications/national-professional-qualifications-frameworks-from-september-2021) so that training providers can be paid the correct amount.

It [will be] publicly accessible code so the providers will be able to satisfy themselves that the numbers they receive match the rules defined herein.

The calculations are defined first in BDD feature files that can be validated by interested parties, then these in turn validate that the calculation engine is producing the expected numbers.

The output of the engine includes the result of each intermediary step in the calculation so that any questions over how the final totals were reached can be answered by interested parties.

## Calculation definitions

The definitions of the calculations and the example calculations being tested can be found in [spec/features](spec/features). These are intended to be readable and editable by non-developers.

## Development

Support for Gherkin syntax rspec tests is provided [turnip](https://github.com/jnicklas/turnip). 
