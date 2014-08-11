# RubySteps

Welcome to the RubySteps project. Here you will find all the lessons that you
have access to. You can run each lesson on a vagrant virtual machine which contains all
the software necessary to run the lesson.

You can clone this repo! You should see a clone button in the GitLab
interface. I want you to use this as an experimental playground. Feel free to
mess with all of the exercises, add your own code, whatever. You can even use it
just to practice git if you want. Please see the license about copying and
distributing RubySteps content. Short version: you may make personal backups,
and you may share any free lessons, but you may not share paid lessons.

## For the hacker types

RubySteps provides a pre-configured virtual machine so that you can run the
examples as easily as possible. However, you may wish to use your existing
configuration to run the RubySteps lessons, and that's fine. Each lesson will
include its configuration as well as notes on any third-party dependencies. If
you have any questions with running the lessons on your setup, please email
pat@patmaddox.com

## Easy as 1, 2, 3(-ish)

The basic steps to setting up the RubySteps environment are to install vagrant
and virtualbox, then clone the RubySteps source code and launch the box.

1. [Download and install VirtualBox](https://www.virtualbox.org/wiki/Downloads)
2. [Download and install Vagrant](https://docs.vagrantup.com/v2/installation/index.html)
3. Clone the RubySteps repository and launch the vagrant box (run the following
three lines of code in your terminal)

```
git clone https://github.com/RubySteps/rubysteps.git
cd rubysteps
vagrant up
```

After launching the vagrant environment, you can ssh into it with `vagrant
ssh`. Once inside, run `ruby hello.rb` to verify that you have a working
environment. You should see the text "Hello RubySteps".

If you get any errors when running vagrant up, make sure that you have the
latest vagrant and virtualbox versions installed and try again. You may also
need to restart your box, or even reinstall it fresh. Many common problems go
away when you are running the latest version of everything.

I will publish updates to the vagrant box as I change the development
environment. You can determine whether your installation is up to date by
running `vagrant box outdated`. Please ensure that your box is up to date.

*Windows users may find [this install guide](https://bitbucket.org/kotp/rlo_core_course_ruby_students/wiki/WindowsInstall) useful for setting up vagrant on Windows.*

### The ish

If you don't have git installed, you can install it with
[these instructions](https://help.github.com/articles/set-up-git). You only need
to do the "Setting Up Git" section - the "Next steps" section don't apply to
RubySteps. You certainly can celebrate if you want though :)

If you have no idea what the git / cd / vagrant lines are about, don't
worry. They're commands that programmers use to interact with the
computer. You'll learn the standard ones over time. For now, take some time to
learn how to launch your terminal and enter commands, like the ones above.

## Lessons

Lessons will appear in the lessons/ directory. I will send out emails when new
lessons are released. You can always `git pull` in order to fetch the latest
updates.

### Running the exercises

You will find the exercises as a series of .rb files in each lesson directory.

The vagrant virtual machine comes preinstalled with all the software you need in
order to run the exercises. You can check that your vagrant box is up to date by
running `vagrant box outdated`.

Exercises use ruby 2.1.2.

To run the lessons from within the vagrant box, simply ssh and cd to the
/vagrant folder which you will see vagrant has linked to the rubysteps directory
on your host machine.

```
vagrant up
vagrant ssh
```

Now from within the vagrant machine:

```
cd /vagrant/lessons
```
