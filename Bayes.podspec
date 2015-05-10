Pod::Spec.new do |s|
  s.name         = "Bayes"
  s.version      = "0.0.1"
  s.summary      = "Utilities for Bayes"
  s.description  = <<-DESC
                   Utilities for Bayes

                   * Probabilities
                   * Classifier
                   * etc
                   DESC
  s.homepage     = "http://github.com/fcanas/Bayes"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Fabian Canas" => "fcanas@gmail.com" }
  s.social_media_url   = "http://twitter.com/fcanas"
  s.source       = { :git => "https://github.com/fcanas/Bayes.git", :tag => "0.0.1" }
  
  s.source_files  = "Bayes", "bayes/**/*.{h,swift}"
  s.exclude_files = "Classes/Exclude"
  s.dependency "Set", "~> 1.4"
end
