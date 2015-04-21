#!/usr/bin/env ruby

require 'crypto-toolbox'

if ARGV[0].nil?
  $stderr.puts "Missing Argument: Ciphertext (hexstring)"
else
  ciphertext = ARGV[0]
  
  Analyzers::PaddingOracle::Analyzer.new.analyze(ciphertext)
end

