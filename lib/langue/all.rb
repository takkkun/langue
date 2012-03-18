Gem::Specification.each do |gem|
  require gem.name if gem.name =~ /^langue-/
end
