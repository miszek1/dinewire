# -*- encoding: utf-8 -*-
# stub: airbrake-ruby 1.4.4 ruby lib

Gem::Specification.new do |s|
  s.name = "airbrake-ruby"
  s.version = "1.4.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Airbrake Technologies, Inc."]
  s.date = "2016-07-11"
  s.description = "Airbrake Ruby is a plain Ruby notifier for Airbrake (https://airbrake.io), the\nleading exception reporting service. Airbrake Ruby provides minimalist API that\nenables the ability to send any Ruby exception to the Airbrake dashboard. The\nlibrary is extremely lightweight, contains no dependencies and perfectly suits\nplain Ruby applications. For apps that are built with Rails, Sinatra or any\nother Rack-compliant web framework we offer the airbrake gem\n(https://github.com/airbrake/airbrake). It has additional features such as\nreporting of any unhandled exceptions automatically, integrations with Resque,\nSidekiq, Delayed Job and many more.\n"
  s.email = "support@airbrake.io"
  s.homepage = "https://airbrake.io"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.4.6"
  s.summary = "Ruby notifier for https://airbrake.io"

  s.installed_by_version = "2.4.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, ["~> 3"])
      s.add_development_dependency(%q<rake>, ["~> 10"])
      s.add_development_dependency(%q<pry>, ["~> 0"])
      s.add_development_dependency(%q<webmock>, ["~> 1"])
      s.add_development_dependency(%q<benchmark-ips>, ["~> 2"])
    else
      s.add_dependency(%q<rspec>, ["~> 3"])
      s.add_dependency(%q<rake>, ["~> 10"])
      s.add_dependency(%q<pry>, ["~> 0"])
      s.add_dependency(%q<webmock>, ["~> 1"])
      s.add_dependency(%q<benchmark-ips>, ["~> 2"])
    end
  else
    s.add_dependency(%q<rspec>, ["~> 3"])
    s.add_dependency(%q<rake>, ["~> 10"])
    s.add_dependency(%q<pry>, ["~> 0"])
    s.add_dependency(%q<webmock>, ["~> 1"])
    s.add_dependency(%q<benchmark-ips>, ["~> 2"])
  end
end
