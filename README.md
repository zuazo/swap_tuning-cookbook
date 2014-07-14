Description
===========
[![Cookbook Version](https://img.shields.io/cookbook/v/swap_tuning.svg?style=flat)](https://supermarket.getchef.com/cookbooks/swap_tuning)
[![Dependency Status](http://img.shields.io/gemnasium/onddo/swap_tuning-cookbook.svg?style=flat)](https://gemnasium.com/onddo/swap_tuning-cookbook)
[![Code Climate](http://img.shields.io/codeclimate/github/onddo/swap_tuning-cookbook.svg?style=flat)](https://codeclimate.com/github/onddo/swap_tuning-cookbook)
[![Build Status](http://img.shields.io/travis/onddo/swap_tuning-cookbook.svg?style=flat)](https://travis-ci.org/onddo/swap_tuning-cookbook)

Chef cookbook to create a swap file of the recommended size considering the system memory.

This can be considered a general purpose cookbook but certainly not recommended for all cases.

Swap size is chosen based on the following documentation:

* [RedHat 7 Recommended Partitioning Scheme](https://access.redhat.com/site/documentation/en-US/Red_Hat_Enterprise_Linux/7/html/Installation_Guide/sect-disk-partitioning-setup-x86.html#sect-recommended-partitioning-scheme-x86)
<table>
  <tr>
    <th>RAM Size</th>
    <th>Recommended Swap</th>
  </tr>
  <tr>
    <td>&le; 2 GB</td>
    <td>2 &times; RAM</td>
  </tr>
  <tr>
    <td>2 GB – 8 GB</td>
    <td>= RAM</td>
  </tr>
  <tr>
    <td>8 GB – 64 GB</td>
    <td>&frac12; &times; RAM</td>
  </tr>
  <tr>
    <td>&gt; 64 GB</td>
    <td>workload dependent</td>
  </tr>
</table>

* [Ubuntu SwapFaq - How much swap do I need?](https://help.ubuntu.com/community/SwapFaq#How_much_swap_do_I_need.3F)

In case you already have swap in the system, creates another swap file with the difference if necessary.

Requirements
============

## Platform:

This cookbook has been tested on the following platforms:

* Arch Linux
* CentOS
* Debian
* Fedora
* Ubuntu
* Amazon

Let us know if you use it successfully on any other platform.

## Cookbooks:

* [swap](https://supermarket.getchef.com/cookbooks/swap)

## Applications:

* Ruby 1.9.3 or higher.

Attributes
==========

<table>
  <tr>
    <td>Attribute</td>
    <td>Description</td>
    <td>Default</td>
  </tr>
  <tr>
    <td><code>node['swap_tuning']['size']</code></td>
    <td>Total swap size in MB.</td>
    <td><em>calculated</em></td>
  </tr>
  <tr>
    <td><code>node['swap_tuning']['minimum_size']</code></td>
    <td>Swap minimum size in MB.</td>
    <td><code>nil</code></td>
  </tr>
  <tr>
    <td><code>node['swap_tuning']['file_prefix']</code></td>
    <td>Swap file name prefix.</td>
    <td><code>"/swapfile"</code></td>
  </tr>
  <tr>
    <td><code>node['swap_tuning']['persist']</code></td>
    <td>Swap file persist.</td>
    <td><code>true</code></td>
  </tr>
</table>

Recipes
=======

## swap_tuning::default

Creates the swap file.

Usage
=====

## Including in a Cookbook Recipe

You can simply include it in a recipe:

```ruby
# in your recipe
include_recipe "swap_tuning::default"
```

Don't forget to include the `swap_tuning` cookbook as a dependency in the metadata:

```ruby
# metadata.rb
depends "swap_tuning"
```

## Including in the Run List

Another alternative is to include it in your Run List:

```json
{
  "name": "app001.onddo.com",
  [...]
  "run_list": [
    [...]
    "recipe[swap_tuning]"
  ]
}
```

Testing
=======

## Requirements

* `vagrant`
* `foodcritic`
* `rubocop`
* `berkshelf`
* `chefspec`
* `test-kitchen`
* `kitchen-vagrant`

You must have [VirtualBox](https://www.virtualbox.org/) and [Vagrant](http://www.vagrantup.com/) installed.

You can install gem dependencies with bundler:

    $ gem install bundler
    $ bundle install

## Running the Syntax Style Tests

    $ bundle exec rake style

## Running the Unit Tests

    $ bundle exec rake unit

## Running the Integration Tests

    $ bundle exec rake integration

Or:

    $ bundle exec kitchen list
    $ bundle exec kitchen test
    [...]

### Running Integration Tests in the Cloud

#### Requirements:

* `kitchen-vagrant`
* `kitchen-digitalocean`
* `kitchen-ec2`

You can run the tests in the cloud instead of using vagrant. First, you must set the following environment variables:

* `AWS_ACCESS_KEY_ID`
* `AWS_SECRET_ACCESS_KEY`
* `AWS_KEYPAIR_NAME`: EC2 SSH public key name. This is the name used in Amazon EC2 Console's Key Pars section.
* `EC2_SSH_KEY_PATH`: EC2 SSH private key local full path. Only when you are not using an SSH Agent.
* `DIGITALOCEAN_CLIENT_ID`
* `DIGITALOCEAN_API_KEY`
* `DIGITALOCEAN_SSH_KEY_IDS`: DigitalOcean SSH numeric key IDs.
* `DIGITALOCEAN_SSH_KEY_PATH`: DigitalOcean SSH private key local full path. Only when you are not using an SSH Agent.

Then, you must configure test-kitchen to use `.kitchen.cloud.yml` configuration file:

    $ export KITCHEN_LOCAL_YAML=".kitchen.cloud.yml"
    $ bundle exec kitchen list
    [...]

Contributing
============

1. [Fork the repository on Github](https://help.github.com/articles/fork-a-repo).
2. Create a named feature branch (`$ git checkout -b my-new-feature`).
3. Write your change.
4. Write tests for your change (if applicable).
5. Run the tests, ensuring they all pass (`$ bundle exec rake`).
6. Commit your change (`$ git commit -am 'Add some feature'`).
7. Push to the branch (`$ git push origin my-new-feature`).
8. [Submit a Pull Request using Github](https://help.github.com/articles/creating-a-pull-request).

TODO
====

* Consider the available disk space.

License and Author
==================

|                      |                                          |
|:---------------------|:-----------------------------------------|
| **Author:**          | [Xabier de Zuazo](https://github.com/zuazo) (<xabier@onddo.com>)
| **Copyright:**       | Copyright (c) 2014, Onddo Labs, SL. (www.onddo.com)
| **License:**         | Apache License, Version 2.0

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at
    
        http://www.apache.org/licenses/LICENSE-2.0
    
    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
