CHANGELOG for swap_tuning
=========================
This file is used to list changes made in each version of the `swap_tuning` cookbook.

## v0.1.3 (2014-10-20)

* Support for `/[0-9]+KBI/` memory format, fixes some Ubuntu `14.04` installations (fixes [issue #1](https://github.com/onddo/swap_tuning-cookbook/issues/1), thanks [@amirarabi](https://github.com/amirarabi) for the help).
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
