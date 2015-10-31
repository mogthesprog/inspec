# encoding: utf-8
# copyright: 2015, Vulcano Security GmbH
# author: Christoph Hartmann
# author: Dominik Richter
# license: All rights reserved

# Usage:
#
# describe os_env('PATH') do
#   its(:split) { should_not include('') }
#   its(:split) { should_not include('.') }
# end

class OsEnv < Inspec.resource(1)
  name 'os_env'

  attr_reader :content
  def initialize(env)
    @osenv = env
    @command_result = inspec.command("su - root -c 'echo $#{env}'")
    @content = @command_result.stdout.chomp
  end

  def split
    # -1 is required to catch cases like dir1::dir2:
    # where we have a trailing :
    @content.split(':', -1)
  end

  def exit_status
    @command_result.exit_status.to_i
  end

  def to_s
    "Environment Variable #{@osenv}"
  end
end
