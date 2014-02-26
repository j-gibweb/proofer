# Celluloid::Pmap

[![Build Status](https://travis-ci.org/jwo/celluloid-pmap.png?branch=master)](https://travis-ci.org/jwo/celluloid-pmap) [![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/jwo/celluloid-pmap)

Parallel Mapping using Celluloid

Celluloid Futures are wicked sweet, and when combined with a `pmap`
implementation AND a supervisor to keep the max threads down, you can be wicked
sweet too!

### How does this happen?
![celluloid](https://f.cloud.github.com/assets/123075/109654/7584c1fa-6a8c-11e2-9ad6-114818b7fbe4.png)

We use Celluloid Futures and Celluloid pool to execute blocks in parallel. 

The pmap will return an array of values when all of the Futures have completed and return values (or return nil).

The pool can help to make sure you don't exceed your connection resources. A common use case for this is in Rails, you can easily exceed the default ActiveRecord connection size.

### Inspiration for this code

Tony Arcieri created [celluloid](http://celluloid.io/), and the [simple_pmap example](https://github.com/celluloid/celluloid/blob/master/examples/simple_pmap.rb) from which this codebase started

### Is this production ready?

I've used this implementation in several production systems over the last year. All complexity is with Celluloid (not 1.0 yet, but in my experience has been highly stable.)

### Why is this a gem?

Because I've been implementing the same initializer code in every project I've worked on for the last 6 months. It was time to take a stand, man.

### What rubies will this run on?

* 1.9.3
* ruby-head (2.0)
* jruby-19mode
* jruby-head
* rbx-19mode


## Installation

Add this line to your application's Gemfile:

    gem 'celluloid-pmap'

## Usage

Default usage will execute in parallel. Simply pass a block to an Enumerable
(like an Array)

```
puts "You'll see the puts happen instantly, and the sleep in parallel"

[55,65,75,85].pmap{|speed_limit| puts "I can't drive _#{speed_limit}_";
sleep(rand)}

=> You'll see the puts happen instantly, and the sleep in parallel
"I can't drive _55_ ""I can't drive _65_ "
"I can't drive _75_ "
"I can't drive _85_ "
```

Problem: When using with ActiveRecord, you can quickly run out of connections. 
Answer: Specify the max number of threads (actors) to create at once!

```
puts "You should see two distinct groups of timestamps, 3 seconds apart"
puts [1,2,3].pmap(2){|speed_limit| puts Time.now.tap { sleep(3) }}

=> You should see two distinct groups of timestamps, 3 seconds apart
2013-01-29 21:15:01 -0600
2013-01-29 21:15:01 -0600
2013-01-29 21:15:04 -0600
```

We default pmap's threads to the number of Celluloid cores in the system.

## When will this help?

* When the blocks are IO bound (like database or web queries)
* When you're running JRuby or Rubinius
* When you're running C Extensions

## So what will this not help with?

* Pure math or ruby computations

## Image Credit

Ben Scheirman (@subdigital) originally used the awesome Celluloid He-Man image
in a presentation on background workers. "He-Man and the Masters of the
Universe," AND "She-Ra: Princess of Power" are copyright Mattel.

More information on He-Man can be found at the unspeakably wow site: http://castlegrayskull.org

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
