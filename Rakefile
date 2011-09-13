require "spec/rake/spectask"

task :default => :spec

# RSpec 1.3
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.spec_files = FileList['spec/encoded_polyline/*_spec.rb']
end