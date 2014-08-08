# Lesson 009 - OOP - Easty OOP

### Running the exercises

See the top-level README for how to run the exercises. This lesson's exercises
are in the `lessons/009_oop_easty_oop` directory.

If you run into problems, it may be because your vagrant box is out of date. You
can run `vagrant box outdated` to check, and then `vagrant box update` to update
the image. You then need to destroy your local box and restart it, with `vagrant
destroy` and `vagrant up`.

--------

# Lesson Name

How do you write good OO programs? How do you know that your design follows good
OO principles? How do you know when you need to follow good OO principles, and
when they're overkill?

You may have asked yourself some of these questions as you program and learn. I
have talked about this in the program so far - the previous OOP lesson on
messaging, and the refactoring lesson on simple rules. You also might have come
across things like SOLID, which I've mentioned a bit but have yet to go into
much detail.

In Lesson 004, I defined design as the definition and delineation of messages
within a system. When I talk about object-oriented design, I specifically mean
the messages in the system, the objects that send each other messages, and the
protocols they use to send those messages.

My friend James Ladd has come up with a way of describing object-oriented design
decisions that I have found helpful in my work as a programmer and as a
teacher. He calls it the East-oriented principle, describing the way messages
flow in the system: from left to right.

It turns out that our decisions about the messages that live in the system and
how they flow through it have a big impact on our ability to understand and
change code. Tightly-coupled code happens when too many messages go back and
forth, and each side of the coupling knows too much about the details of the
other. By making a decision to write East-oriented code, you create a structure
with a simplified control flow - Ruby executes its statements top to bottom, and
then messages go from left to right. When a chain of messages completes, it
moves on to the next line and triggers that chain of messages.

East-oriented code allows for powerful, concise code. Each line of code can
trigger a lot of behavior, because of the cascade of messages. Compare this with
the inefficient approach of pulling data out of objects and then making
decisions, where you have to understand what each line of code does, and how
they all fit together. East-oriented code lets you express a powerful idea in
one simple message send, and if you need to know more about the details then you
can follow the chain of messages.

--------

## Exercise 1 - You already know East

The main idea behind east-oriented code is collaboration. Objects collaborate
with one another to do different things. If you've studied any design patterns,
you may have noticed that the majority of the design patterns involve
colloration or enable it in some way.

The east-oriented rule is simple: send messages to objects you know about, and
pass along any information they need in order to get the job done. This results
in code that makes its dependencies explicit - hidden dependencies lead to
tightly-coupled, difficult-to-maintain code.

You're already familiar with a common example of east-oriented code: `puts` from
the standard library. `puts` takes any object and calls the `#to_s` method on
it. Of course, internally, puts uses the return value of `#to_s`, so I suppose
you might argue that it's not fully east-oriented. In this case, I think of the
`#to_s` call as being a matter of convenience - the protocol could just as
easily require a string, in which case you'd have to call `#to_s` on your own
object before passing it in.

Whenever you call `puts` in your code, you are implicitly coupling to the
`Kernel#puts` call. Every object in Ruby includes `Kernel`, so this isn't some
sort of bad coupling, but it does obscure some side effects. When you run that
bit of code, it prints something to the console - wouldn't it be nice if we knew
of the potential side effects, rather than having them be completely hidden from
callers?

Take a look at `exercise_1a_side_effects.rb`. It shows a single method that has
a single side effect - it prints something to the screen. You know this because
of the method name, but you don't necessarily know the nature of the side
effects and where they happen.

If you look at `exercise_1b_east_oriented.rb`, you'll see an example of that
same code, made east-oriented. It's a small difference, but it enables a great
deal of power. Instead of depending directly on the `puts` defined in Kernel,
this code now depends on an interface - it expects a collaborator, and it
expects that collaborator to have a particular method. This lets us pass in any
object that responds to that method. What if we want to wrap every message in
stars? We can do that with East-oriented code. See `exercise_1c_wrapper.rb` for
an example. Of course, because our `StringWrapper` object is east-oriented, we
can create even more objects that it collaborates with.

You're also familiar with another instance of the east principle - everywhere
blocks are used, you're using east-oriented code. In one sense you're just
passing a function around to be used. This is a basic form of east - high levels
pass functions to execute to lower levels. Looking at Ruby's implementation,
you're actually passing around an object that responds to `#call`. Take a look
at `exercise_1d_callable.rb` to see another example of East in action - this
time we rely on ruby's `&` operator to call `#to_proc` on the `Chicken` class,
which returns a lambda (which responds to `#call`) which then gets called by our
`run_block` method (and of course, passing around `$stdout` so our East-oriented
code can use it!).

--------

## Exercise 2 - Easy notifications with east-oriented code

In most software systems, we need to send notifications. I don't mean Facebook
notifications, although those are certainly a form of software notification. I
mean simply indicating to other parts of a sytem that something has happened,
and giving them the information they need to understand the event.

This notification style is probably the core of OOP and the east-oriented
principle. Objects perform work, and send notifications to other objects that
some work has been done. These other objects wait for events, and then do their
own work according to business rules.

Let's look at how we can build a simple system based on the East principle. This
system will communicate to other objects by means of messages, and the majority
of the messages will be notifications.

I'll use a simulation of the RubySteps mailing list as an example. Take a look
at `exercise_2_rubysteps.rb` to see the program. Trace the flow of messages
through the system to see how work gets done. You can run the program with `ruby
exercise_2_rubysteps.rb` to see what happens.

Looking at this code, we can evaluate it against SOLID. I think it demonstrates
at least three of the principles:

* Single Responsibility Principle - each object in the system only has one
  reason to change. `RubySteps` manages business rules for subscribers, `User`
  manages the logic around friends, and `FakeEmailer` sends out the... fake
  emails.
* Open-Closed Principle - we can extend the behavior of the system simply by
  introducing new objects. We don't have to change the existing implementations
  in order to achieve new behavior.
* Dependency-Inversion Principle - each object depends on abstractions, rather
  than details. Dependencies are passed in, rather than being hidden deep inside
  the implementation.

I can actually tie the Liskov-Substitutability Principle and
Interface-Segregation Principles to this too, but I'm going to save those for
another day :)

--------

## Exercise 3 - Extending the system

Here I'll leave you on your own, to extend the system that I've created so
far. You can do anything you want with it, but remember to practice the
East-oriented principle in your own code. Look at how the East principle has
enabled you to write new code that extends the behavior of this system, without
having to make any changes to the existing code.

Can you think of other ways to extend the system? Maybe you want to hook up a
real emailer. Maybe you want to include a count of the friends that have signed
up, or keep track of the last friend to sign up. Maybe you want to add new
notifications. What are you able to add, without changing any of the existing
code (adding new methods is fine) because of the East-oriented design?

--------

# Wrap up

In this lesson, I've shown you a simple way that you can write clean,
object-oriented code. The East principle focuses on the messages that happen
between objects, which allows you to extend the behavior of the system by
introducing new objects. You probably won't follow the East principle in all of
your code, but you will find it helpful to think about as a way of achieve
clean, object-oriented code.

I find the East principle combined with JB Rainsberger's two rules of simple
design to be all I need to keep in mind as I work, and I can end up with a
design I like. When I'm done, I can evaluate it in terms of SOLID, DRY, etc and
see how the design stacks up. We'll use the East principle a lot more in future
lessons, so make sure you read up on the references and experiment with the idea
in your own code.

--------

## References

* [East Oriented Code](http://jamesladdcode.com/?p=12) - James Ladd
* [ADDCast interview w/ James](http://addcasts.com/2011/04/21/episode-4-special-guest-james-ladd-talks-to-us-about-running-smalltalk-on-the-jvm-immutability-and-how-to-write-good-oo-code/) (optional, but fun :)
* [Object collaboration patterns (pdf)](http://streamlinedmodeling.com/papers/collaboration_patterns.pdf) - Jill Nicola
* [Single-Responsibility Principle](http://blog.8thlight.com/uncle-bob/2014/05/08/SingleReponsibilityPrinciple.html)
* [Open-Closed Principle](http://blog.8thlight.com/uncle-bob/2014/05/12/TheOpenClosedPrinciple.html)
* [Dependency-Inversion Principle](http://c2.com/cgi/wiki?DependencyInversionPrinciple)
