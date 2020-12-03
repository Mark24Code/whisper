require_relative 'lib/whisper/version'

Gem::Specification.new do |spec|
  spec.name          = "whisper"
  spec.version       = Whisper::VERSION
  spec.authors       = ["Mark24"]
  spec.email         = ["mark.zhangyoung@qq.com"]

  spec.summary       = %q{Whisper is LAN chat software}
  spec.description   = %q{Chat in LAN.}
  spec.homepage      = "https://mark24code.github.io/whisper/"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  # spec.metadata["allowed_push_host"] = "https://mark24code.github.io/whisper/"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/Mark24Code/whisper/"
  spec.metadata["changelog_uri"] = "https://github.com/Mark24Code/whisper/releases/new"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
