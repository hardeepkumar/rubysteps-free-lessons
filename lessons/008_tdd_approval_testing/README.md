# Lesson 008 - TDD - Approval Testing

### Running the exercises

See the top-level README for how to run the exercises. This lesson's exercises
are in the `lessons/008_tdd_approval_testing` directory.

If you run into problems, it may be because your vagrant box is out of date. You
can run `vagrant box outdated` to check, and then `vagrant box update` to update
the image. You then need to destroy your local box and restart it, with `vagrant
destroy` and `vagrant up`.

--------

# Approval Testing

It can be tough to wrap your head around TDD, especially when you're learning
TDD along with first learning to program. You will find TDD to be a valuable
skill, and a potential differentiator in terms of the jobs available to you. In
my experience, the jobs that want you to know TDD and know how to actually
benefit from using it, will be the better jobs. That's just my opinion though.

Last week I looked at the bare minimum you need to know in order to start
writing effective tests. I admit that the test framework is not sophisticated in
any way, but it can get the job done. You could implement that kind of framework
in any programming language in order to bootstrap your TDD abilities before you
learn enough to begin using a more complete test framework.

I have always been a fan of minimalism in code - I tend to use only a fraction
of the APIs available to me in a library, for example. I recently became aware
of a style of TDD that I think really lowers the barrier to entry in terms of
what you need to understand to in order to be effective with TDD. It is based
off of a technique called the Golden Master - used in software testing as well
as industrial manufacturing - but what makes it really powerful is the way it
adapts TDD to the way that you may already be working.

--------

## Exercise 1 - Introducing approval testing

We're going to start really simply here so you can see the basic pieces, and
then move on to an example where we actually TDD a piece of functionality using
approval testing. I'm using Katrina Owen's approvals library, which works with
any test framework (and even without a framework, I think).

When you learn to program, your process goes something like this:

1. Write some code
2. Run it to see if it works
3. If it works, move on. If not, change it and go to 2

If you've heard anything about TDD, you've probably heard that the process goes
something like this:

1. Write a failing test
2. Write the code needed to make the test pass
3. Refactor the working code

People can struggle with writing the failing test first. How do you write a test
before you have any code to test? What if you write the wrong test? How do you
write a good test?

Approval testing combines the two approaches by letting you write some code and
then run it to see if it works, same as you would do in a non-TDD approach. With
approval testing though, you output some information about the running
program. A human - maybe you the programmer, or working with a tester or
business analyst - visually inspects the output and approves it as correct, or
rejects it as incorrect. If approved, the output gets saved locally into an
`approvals/` directory. Now every time you run the test suite, the output gets
compared against the previously approved output. If it's the same, the test
passes. If it differs, the test fails and you have to determine whether the code
has broken or the requirements have changed.

We'll walk through some examples so you can get a feel for it. Approval testing
lets you write code in a way that might feel more natural to you right now, but
still write unit tests and get them kind of "just in time". In a way, approval
testing gets the computer to write the test for you.

Approval testing is still TDD, because you write the test upfront. It differs
from more "traditional" TDD in that you define the expectation after you've
written the implementation code, whereas in traditional TDD you define the
expectation upfront. Approval testing allows you to incrementally change the
expectation (the approved output) simply by changing the code, running it, and
determining whether it's correct.

Here's a simple example of a test written with RSpec and Approvals:

```ruby
describe RubySteps do
  it 'has a cool lesson 007' do
    verify { RubySteps.lesson_007 }
  end
end
```

That's it! Take a look at `exercise_1_approvals_spec.rb` and run it with `bundle
exec rspec exercise_1_approvals_spec.rb`. You should see the test pass. I've
already run the test and saved the approval, which is why it passes. Every time
you run the test, it saves the output of each verify block. You can then verify
that the code still works by running `bundle exec approvals verify`. This
compares the output from the test run to whatever was saved as an approval.

The verify block saves the output of that block into a file, which gets approved
and then compared against for later runs. You can see the approved output in
`spec/fixtures/approvals/rubysteps/has_a_cool_lesson_007.approved.txt`.

Okay, let's move on to something a bit more interesting - approval testing the
Ruby core library.

--------

## Exercise 2 - Approval testing the core library

Last week we learned about how to write tests for built-in Ruby functionality in
order to gain experience writing tests, as well as to solidify our understanding
of the core library. In this exercise, we'll look at how approval tests can
simplify these kinds of tests, and allow us to express them in a natural way.

Take a look at `exercise_2a_string_spec.rb` and run it with `bundle exec rspec
exercise_2a_string_spec.rb`.

You'll notice that the tests look a bit different from before - instead of
defining an explicit expectation, we simply write a piece of code and state an
intention to verify it. The approvals library takes care of the verification.

So far I've shown you how to work with passing approval tests, but how do you do
TDD with them? I've included a pending example in exercise 2a, indicated by a
call to `xit` as opposed to `it`. Enable it and try to run the specs again - the
test will fail because there is no approved output saved locally. It has saved
the received output though, so you can approve it. Do that by running `bundle
exec approvals verify` again, and you'll see a diff runner asking if you want to
approve the diff. Approve it, and then run the tests and approvals again. You'll
see that everything passes.

Because approvals works based off of string output, we can verify any piece of
code that produces a string. That allows us to express tests in many different
ways - as long as they produce a string we can approve, we can write a test
however we want. Interestingly, the .Net version of approvals supports diffs on
audio files, images etc. It would be really cool to bring that to Ruby at some
point.

Take a look at `exercise_2b_string_combined_spec.rb`. In it, you'll see the same
three methods from before, only this time they're tested in a single verify
block rather than individual blocks. Additionally, I've written a little bit of
code to produce combined output that I can verify. Take a look inside the
approvals file to see the output. Again, you can enable the pending test to step
through the workflow of TDD w/ approval testing - run the test, see it fail due
to a missing approval, and then run approvals verify and approve the output.

Of course, there's nothing particularly unique to String about the code I
wrote. We could easily extract a method to generate that sort of output for any
object. `exercise_2c_objects_spec.rb` does just that. Try adding some of your
own objects or methods.

I hope that last example gives you an idea of how powerful approval testing
is. It can be very similar to writing custom expectation matchers or test
methods. In fact, approval testing works on the idea that custom expectation
matchers are so important that we should basically be using them all the time,
and have a simple way of creating them and changing them.

--------

## Exercise 3 - TDD with approval testing

Now that we've got a bit of a handle on the basics of approval testing, I'm
going to show you how you can use this technique to incrementally write software
and do TDD. Instead of incrementally building a design by writing one small test
after another, we can write one approval test and keep changing its approval
file, using the difference in the approval file to drive the next change to the
code.

In `exercise_3_approval_tdd_spec.rb` I have simulated what that process might
look like. I have written multiple versions of the approval test line (the same
each time, but it allows the approvals gem to keep track of them separately),
and multiple versions of the implementation. As you go through the different
versions, keep in mind this flow I followed to create them:

1. Write the first version of the approval test, and a first implementation
2. Run the test, see it fail. Run approvals verify, and approve the output
3. Change the approved output! It lives in `spec/fixtures/approvals`
4. Now that the approved output is different, the test fails. Our next failing
test!
5. Change the code to pass the test. When that passes, verify the
approvals. Both commands should come back clean when the test output matches the
approved output.
6. Repeat 3-5 or 1-5 depending on whether you're changing an existing test or
adding a new one.

--------

# Wrap up

Approval testing is a very powerful technique - I immediately recognized how it
could make my own work a lot simpler, as well as make TDD more accessible to
people just getting familiar with it. I have kept the exercises intentionally
short and simple today so that you can start practicing the technique on your
own. There really is not much to it, and it lets you ignore most of a test
framework because all you have to do is write some code which generates a
string. However you want to generate that string is up to you.

This lesson introduces the basic technique of approval testing and gives you a
starting off point for writing your own automated tests. You can write powerful,
effective test suites using only the technique I've showed you so far. In the
coming lessons, I will demonstrate how to encode scenarios in tests, and use
approval tests to once again simplify the process.

--------

## References

* [Approval Tests](http://blog.approvaltests.com)
* [Gold Master Testing](http://blog.codeclimate.com/blog/2014/02/20/gold-master-testing/) - Code Climate
* [approvals library (ruby)](https://github.com/kytrinyx/approvals) - Katrina Owen
