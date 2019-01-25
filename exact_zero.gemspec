
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
	spec.name          = "exact_zero"
	spec.version       = "0.0.1"
	spec.authors       = ["Masahiro Nomoto"]
	spec.email         = ["hmmnrst@users.noreply.github.com"]

	spec.summary       = %q{Provides `Numeric#exact_zero?` to avoid ZeroDivisionError}
	spec.homepage      = "https://github.com/hmmnrst/exact_zero"
	spec.license       = "MIT"

	# Specify which files should be added to the gem when it is released.
	# The `git ls-files -z` loads the files in the RubyGem that have been added into git.
	spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
		`git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
	end
	spec.bindir        = "exe"
	spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
	spec.require_paths = ["lib"]

	spec.add_development_dependency "bundler"
	spec.add_development_dependency "rake"
	spec.add_development_dependency "rspec", "~> 3.0"
end
