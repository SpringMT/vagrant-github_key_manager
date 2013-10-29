require 'vagrant/ui'
require 'io/console'

module Vagrant
  module UI
    class Basic
      def ask_noecho(message, opts=nil)
        super(message)

        # We can't ask questions when the output isn't a TTY.
        raise Errors::UIExpectsTTY if !$stdin.tty? && !Vagrant::Util::Platform.cygwin?

        # Setup the options so that the new line is suppressed
        opts ||= {}
        opts[:new_line] = false if !opts.has_key?(:new_line)
        opts[:prefix]   = false if !opts.has_key?(:prefix)

        # Output the data
        say(:info, message, opts)

        # Get the results and chomp off the newline. We do a logical OR
        # here because `gets` can return a nil, for example in the case
        # that ctrl-D is pressed on the input.
        input = $stdin.noecho(&:gets) || ""
        input.chomp
      end
    end
  end
end

