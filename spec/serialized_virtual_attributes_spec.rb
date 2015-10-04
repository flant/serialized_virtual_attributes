require 'spec_helper'

describe SerializedVirtualAttributes do
  it 'has a version number' do
    expect(SerializedVirtualAttributes::VERSION).not_to be nil
  end

  before(:all) do
    class Test < ActiveRecord::Base
      serialize :data, Hash
    end
  end

  it 'should raise ArgumentError if no :to parameter specified' do
    expect { Test.serialized_virtual_attribute :fail }.to raise_error ArgumentError
  end

  it 'should raise ArgumentError if :to parameter is not serialized attribute' do
    expect { Test.serialized_virtual_attribute :fail, to: :name }.to raise_error ArgumentError
  end

  describe 'Model with correct serialized_virtual_attributes' do
    before(:example) do
      Test.serialized_virtual_attribute :one, to: :data
      Test.serialized_virtual_attribute :two, to: :data, typecast: Integer
      Test.serialized_virtual_attribute :three, :four, to: :data, prefix: :pre

      @t = Test.new
    end

    it 'should define getter and setter to virtual attribute' do
      expect(@t).to respond_to :one
      expect(@t).to respond_to :one=
    end

    it 'should typecast attribute' do
      @t.two = '25'
      expect(@t.two).to eq(25)
    end

    it 'should define prefixed getter and setter' do
      expect(@t).to respond_to :pre_three
      expect(@t).to respond_to :pre_three=
    end
  end
end
