Description
===========
[![Cookbook Version](https://img.shields.io/cookbook/v/swap_tuning.svg?style=flat)](https://supermarket.getchef.com/cookbooks/swap_tuning)
[![Dependency Status](http://img.shields.io/gemnasium/onddo/swap_tuning-cookbook.svg?style=flat)](https://gemnasium.com/onddo/swap_tuning-cookbook)
[![Code Climate](http://img.shields.io/codeclimate/github/onddo/swap_tuning-cookbook.svg?style=flat)](https://codeclimate.com/github/onddo/swap_tuning-cookbook)
[![Build Status](http://img.shields.io/travis/onddo/swap_tuning-cookbook/0.1.2.svg?style=flat)](https://travis-ci.org/onddo/swap_tuning-cookbook)

Chef cookbook to create a swap file of the recommended size considering the system memory.

This can be considered a general purpose cookbook but certainly not recommended for all cases.

Swap size is chosen based on the following documentation:

* [RedHat 7 Recommended Partitioning Scheme](https://access.redhat.com/site/documentation/en-US/Red_Hat_Enterprise_Linux/7/html/Installation_Guide/sect-disk-partitioning-setup-x86.html#sect-recommended-partitioning-scheme-x86)

| RAM Size     | Recommended Swap     |
|--------------|----------------------|
| &le; 2 GB    | 2 &times; RAM        |
| 2 GB - 8 GB  | = RAM                |
| 8 GB - 64 GB | &frac12; &times; RAM |
| &gt; 64 GB   | workload dependent   |

* [Ubuntu SwapFaq - How much swap do I need?](https://help.ubuntu.com/community/SwapFaq#How_much_swap_do_I_need.3F)

In case you already have swap in the system, creates another swap file with the difference if necessary.

Requirements
============

## Supported Platforms

This cookbook has been tested on the following platforms:

* Amazon
* Arch Linux
* CentOS
* Debian
* Fedora
* RedHat
* Ubuntu

Please, [let us know](https://github.com/onddo/swap_tuning-cookbook/issues/new?title=I%20have%20used%20it%20successfully%20on%20...) if you use it successfully on any other platform.

## Required Cookbooks

* [swap](https://supermarket.getchef.com/cookbooks/swap)

## Required Applications

* Ruby `1.9.3` or higher.

Attributes
==========

| Attribute                             | Default       | Description              |
|---------------------------------------|:-------------:|--------------------------|
| `node['swap_tuning']['size']`         | *calculated*  | Total swap size in MB.   |
| `node['swap_tuning']['minimum_size']` | `nil`         | Swap minimum size in MB. |
| `node['swap_tuning']['file_prefix']`  | `'/swapfile'` | Swap file name prefix.   |
| `node['swap_tuning']['persist']`      | `true`        | Swap file persist.       |

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
include_recipe 'swap_tuning::default'
```

Don't forget to include the `swap_tuning` cookbook as a dependency in the metadata:

```ruby
# metadata.rb
depends 'swap_tuning'
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

See [TESTING.md](https://github.com/onddo/swap_tuning-cookbook/blob/master/TESTING.md).

Contributing
============

Please do not hesitate to [open an issue](https://github.com/onddo/swap_tuning-cookbook/issues/new) with any questions or problems.

See [CONTRIBUTING.md](https://github.com/onddo/swap_tuning-cookbook/blob/master/CONTRIBUTING.md).

TODO
====

See [TODO.md](https://github.com/onddo/swap_tuning-cookbook/blob/master/TODO.md).

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
