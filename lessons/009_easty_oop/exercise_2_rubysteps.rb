require 'set'

class RubySteps
  def initialize(emailer)
    @emailer = emailer
    @users = Set.new
  end

  def add_user(user)
    @users.add user
    user.deliver_welcome_email(@emailer)
    @users.each {|u| u.member_registered(user, @emailer) }
    true
  end
end

class User
  attr_reader :name

  def initialize(name, email)
    @name = name
    @email = email
    @friends = Set.new
  end

  def deliver_welcome_email(emailer)
    emailer.deliver_email(
      subject: "Welcome to RubySteps, #{@name}!",
      to_email: @email,
      to_name: @name,
      body: "This is gonna be so much fun"
      )
    true
  end

  def member_registered(new_user, emailer)
    emailer.deliver_email(
      subject: "Your friend has joined RubySteps!",
      to_email: @email,
      to_name: @to_name,
      body: "Why don't you give a warm welcome to #{new_user.name}" # whoops, not East :)
      ) if @friends.include?(new_user)
    true
  end

  def befriend(other_user)
    unless @friends.include?(other_user)
      @friends.add other_user
      other_user.befriend self
    end
    true
  end
end

class FakeEmailer
  def initialize(output)
    @output = output
  end

  def deliver_email(options)
    subject = options.fetch :subject
    to_email = options.fetch :to_email
    to_name = options.fetch :to_name
    body = options.fetch :body

    parts = [
      "Subject: #{subject}",
      "To: #{to_name} <#{to_email}>",
      "",
      body
    ]

    @output.puts parts.join("\n")
    @output.puts
  end
end

pat = User.new 'Pat', 'pat@example.org'
jay = User.new 'Jay', 'jay@example.org'
mom = User.new 'mom', 'mom@example.org'

jay.befriend mom

rs = RubySteps.new(FakeEmailer.new($stdout))

rs.add_user pat
rs.add_user jay
rs.add_user mom
