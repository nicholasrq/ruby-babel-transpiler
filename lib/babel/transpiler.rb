require 'execjs'
require 'babel/source'
require 'babel/transpiler/version'

module Babel
  module Transpiler
    def self.version
      VERSION
    end

    def self.source_version
      Source::VERSION
    end

    def self.source_path
      Source::PATH
    end

    def self.script_path
      File.join(source_path, "babel.js")
    end

    def self.context
      script = File.read(script_path, encoding: 'UTF-8')
      @context ||= ExecJS.compile("var self = this; " + script)
    end

    def self.transform(code, options = {})
      context.call('babel.transform', code, options.merge('ast' => false))
    end
  end
end
