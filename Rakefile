require 'rake/testtask'


Rake::TestTask.new do |t|
  t.libs = ["lib"]
  t.warning = true
  t.test_files = FileList['specs/*_spec.rb']  #runs all the tests in spec.rb files
end

task default: :test
