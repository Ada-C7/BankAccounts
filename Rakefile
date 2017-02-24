require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs = ["lib"]
  t.warning = false
  t.test_files = FileList['specs/*_spec.rb']
end

task default: :test
