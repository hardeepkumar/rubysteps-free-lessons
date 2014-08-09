# Lesson 010 - Refactoring - Legacy Code

### Running the exercises

See the top-level README for how to run the exercises. This lesson's exercises
are in the `lessons/010_refactoring_legacy_code` directory.

If you run into problems, it may be because your vagrant box is out of date. You
can run `vagrant box outdated` to check, and then `vagrant box update` to update
the image. You then need to destroy your local box and restart it, with `vagrant
destroy` and `vagrant up`.

--------

# Refactoring Legacy Code

How do you refactor when you don't have a test suite? How do you get the test
coverage you need in order to refactor safely, without spending tons of time
upfront writing tests to cover your entire codebase? When you work with legacy
code - loosely defined as production code with no test coverage - you need to
make changes while following the prime directive of working business software:
don't break anything.

As you know from the previous refactoring lesson, refactoring means changing
code without changing behavior. When working with legacy code, you will need to
do both - change the behavior to introduce new functionality or fix bugs, while
not changing any other existing behavior. You may also need to make changes to
the structure of the code to support the new functionality or bug fixes.

Most people lament legacy code as being very difficult to work with - because it
is! However, legacy code provides a unique opportunity to make an investment
that pays off in several ways, provided that you make pragmatic decisions about
how and where to add test coverage.

When working with legacy code, you can:

* add tests for better coverage
* refactor for new understanding
* improve the quality of existing code

Let's look at how to do that.

--------

## Exercise 1 - Test-driving legacy code

This is my favorite technique for adding test coverage to a legacy code base. I
learned it from Michael Feathers' fantastic book called "Working Effectively
with Legacy Code". It's a very simple technique: you take a piece of code that
you want to test, comment out every line, and then write tests that drive out
the responsibility for each line, one at a time.

Take a look at `exercise_1a_legacy.rb` - it's the starting piece of legacy code
that we'll add tests for. You don't need to do anything with it right now
(although feel free to dive right in if you like!). I'm simply using it as an
example of what happens.

This code is a simple order object that prints out a receipt. I'd like to add
tests to it so I can refactor, add functionality, and fix bugs, all without
introducing new bugs. I'll focus on the `#print_receipt` method here.

Read each of the following examples one after the other. They demonstrate how I
use tests to drive out single lines of code. I only uncomment the line of code
when the test creates a need for it.

* `rspec exercise_1a_legacy_1_spec.rb` - pending examples for the main behaviors
* `rspec exercise_1a_legacy_2_spec.rb` - quick extract method refactor
* `rspec exercise_1a_legacy_3_spec.rb` - first failing example
* `rspec exercise_1a_legacy_4_spec.rb` - make it pass
* `rspec exercise_1a_legacy_5_spec.rb` - add the order time

I have driven out the first few lines of code. Use those examples as a starting
point to add tests and drive out the remaining lines. Are there any lines of
code that aren't needed? How do you know?

Now that you have some test coverage, you can refactor this method however you
please. We'll look at some examples in a later lesson, but for now, give it your
best shot. Perhaps you want to revisit Lesson 008 on Easty OOP for some ideas?

--------

# Wrap up

In this lesson, I've shown you a powerful but simple technique for refactoring
legacy code. By commenting legacy code and driving it out line-by-line, you can
approximate the TDD process. You can also identify dead code quite easily.  It's
the best technique that I've found for adding tests to legacy code, because it
forces me to understand why every single line of code exists.

I have gotten a lot of mileage out of this technique over the years. If you use
it, you will increase your test coverage and your understanding of the code, and
make changes confidently and safely. As you go about your work, practice this
technique for working effectively with legacy code.

--------

## References

* [Working Effectively with Legacy Code](http://www.c2.com/cgi/wiki?WorkingEffectivelyWithLegacyCode) - Michael Feathers
