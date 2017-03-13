directories %w(lib spec) \
 .select{|d| Dir.exists?(d) ? d : UI.warning("Directory #{d} does not exist")}

guard :rspec, cmd: "bundle exec rspec", all_on_start: true, first_match: true do
  require "guard/rspec/dsl"
  dsl = Guard::RSpec::Dsl.new(self)

  # RSpec files
  rspec = dsl.rspec
  watch(rspec.spec_files)
  watch(%r{^spec/.+\.rb$}) { rspec.spec_dir }
  watch(%r{^lib/.+\.rb$}) { rspec.spec_dir }
end
