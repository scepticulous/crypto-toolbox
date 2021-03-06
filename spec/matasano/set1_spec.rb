require 'spec_helper'


RSpec.describe Matasano::Solver do

  context "#solve1" do
    let(:input)  { "49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d" }
    let(:output) { "SSdtIGtpbGxpbmcgeW91ciBicmFpbiBsaWtlIGEgcG9pc29ub3VzIG11c2hyb29t" }
    it "solves the challange" do
      expect(subject.solve1(input)).to eq(output)
    end
  end
  
  context "solve2" do
    let(:c1)     { "1c0111001f010100061a024b53535009181c" }
    let(:c2)     { "686974207468652062756c6c277320657965" }
    let(:output) { "746865206b696420646f6e277420706c6179" }
    it "solves the challange" do
      expect(subject.solve2(c1,c2)).to eq(output)
    end
  end
  
  context "solve3" do
    let(:input) { "746865206b696420646f6e277420706c6179" }
    it "solves the challange" do
      expect(subject.solve3(input)).to eq("the kid don't play")
    end
  end

  context "solve4",cpu_burner: true do
    let(:input) { File.read("challange-input/matasano/set1-challange4.txt").split("\n") }
    it "solves the challange" do
      expect(subject.solve4(input)).to eq("Now that the party is jumping\n")
    end
  end

  context "solve5" do
    let(:key)       { "ICE" }
    let(:input)     { "Burning 'em, if you ain't quick and nimble\nI go crazy when I hear a cymbal" }
    let(:output)    { "0b3637272a2b2e63622c2e69692a23693a2a3c6324202d623d63343c2a26226324272765272a282b2f20430a652e2c652a3124333a653e2b2027630c692b20283165286326302e27282f".upcase }

    
    it "solves the challange " do
      expect(subject.solve5(input,key)).to eq(output)
    end
  end

  context "challange6"  do
    let(:input) { File.read("challange-input/matasano/set1-challange6.txt") }
    let(:plain) { "I'm back and I'm ringin' the bell" }
    it "solves the challange" do
      expect(subject.solve6(input).first.str).to include(plain)
    end
  end
  
  context "challange7" do
    let(:key)   { "YELLOW SUBMARINE" }
    let(:input) { File.read("challange-input/matasano/set1-challange7.txt") }
    let(:plain) { "I'm back and I'm ringin' the bell" }

    it "solves the challange" do
      expect(subject.solve7(input,key).str).to include(plain)
    end
  end

  context "challange8" do
    let(:input)  { File.read("challange-input/matasano/set1-challange8.txt").split("\n").map{|c| CryptBuffer.from_hex(c)} }
    let(:result_index) { 132 }
    let(:result_msg)   { "D880619740A8A19B7840A8A31C810A3D08649AF70DC06F4FD5D2D69C744CD283E2DD052F6B641DBF9D11B0348542BB5708649AF70DC06F4FD5D2D69C744CD2839475C9DFDBC1D46597949D9C7E82BF5A08649AF70DC06F4FD5D2D69C744CD28397A93EAB8D6AECD566489154789A6B0308649AF70DC06F4FD5D2D69C744CD283D403180C98C8F6DB1F2A3F9C4040DEB0AB51B29933F2C123C58386B06FBA186A"  }

    it "finds the correct index" do
      expect(subject.solve8(input).first).to eq(result_index)
    end
    
    it "contains the correct ciphertext" do
      expect(subject.solve8(input)[1].hex).to eq(result_msg)
    end
  end

end



