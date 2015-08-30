CHANGELOG for swap_tuning
=========================
This file is used to list changes made in each version of the `swap_tuning` cookbook.

## v0.2.0 (2015-08-30)

* Fix new RuboCop offense: `SwapTuning#memory2bytes` refactorized.
* Update chef links to use *chef.io* domain.
* Update contact information and links after migration.
* metadata: Add `source_url` and `issues_url`.
* Add SUSE support.

* Documentation:
 * README:
  * Improve title.
  * Improve JSON examples.

* Testing:
 * Travis CI: Add Ruby `2.2`.
 * Test coverage to 100%.
 * Configure test coverage and *coveralls.io*.
 * Add ChefSpec tests for *swapfiles0-9* files creation.
 * Move ChefSpec tests to *test/unit*.
 * Update .kitchen.yml file.
 * Rakefile: Add clean task.
 * Gemfile updates:
  * Remove `gnuplot` dependency.
  * Update RuboCop to `0.33.0`.
  * Disable guard-kitchen.
  * Use fixed versions for some gems.
  * Build against Chef `11` & `12`.

## v0.1.4 (2014-10-26)

* Fix Chef `< 11.12` support (fixes [issue #1](https://github.com/zuazo/swap_tuning-cookbook/issues/1), thanks [@amirarabi](https://github.com/amirarabi) for the help).
* Fix *"cloning resource attributes from prior resource"* warning.
* Add more integrations tests and a `swap_tuning_test` cookbook.
* Revert `/[0-9]+KBI/` memory format support, bad fix (partial revert of [b55c9ab](https://github.com/zuazo/swap_tuning-cookbook/commit/b55c9ab11f0a11edfeece602ff5e71d99b2e9264) in [2e198af](https://github.com/zuazo/swap_tuning-cookbook/commit/2e198af7bc2724fbe907c6602d6d8028a5ca2366)).
* Integrate tests with `should_not` gem.
* *spec/recipes/default_spec.rb* `chef_run` code simplified.
* Add complete unit tests for `SwapTuning::RecipeHelpers` library.

## v0.1.3 (2014-10-20)

* Support for `/[0-9]+KBI/` memory format, fixes some Ubuntu `14.04` installations (fixes [issue #1](https://github.com/zuazo/swap_tuning-cookbook/issues/1), thanks [@amirarabi](https://github.com/amirarabi) for the help).
* kitchen.cloud.yml updated.
* README: `include_recipe` example without recipe name.

## v0.1.2 (2014-10-17)

* `Chef::SwapTuning`: add a missing space.
* metadata: depends swap with pessimistic operator.
* ChefSpec: use `SoloRunner` instead of `Runner`.
* Fix RuboCop offense.
* Add Serverspec tests.
 * Add Gemfile to Serverspec tests.
* Use swap cookbook `0.3.8` ChefSpec matchers.
* kitchen.yml: include more platform versions.
* travis.yml: exclude some groups from bundle.
* Add rubocop.yml with AllCops:Include.
* Berkfile: use a generic Berksfile template.
* Gemfile:
 * Update versions.
  * Berkshelf update to `3.1`.
 * Refactor to use style, unit and integration groups.
 * Replace vagrant gem by vagrant-wrapper.
* Rakefile: Add docu link and include kitchen only when needed.
* Add Guardfile.
* Add license header file to all ruby files.
* README:
 * Use markdown tables.
 * Use single quotes in examples.
* TODO: use checkboxes.
* Some small documentation improvements.

## v0.1.1 (2014-07-26)

* README.
 * added an empty line above a table tag.
 * created CONTRIBUTING, TESTING and TODO files.
 * error fix: *#<Encoding::InvalidByteSequenceError: "\xE2" on US-ASCII*.
* TODO: added some tasks.
* Remove old comment from spec/spec_helper.rb.
* Added RedHat as supported.

## v0.1.0 (2014-07-14)

* Initial release of `swap_tuning`.
