# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AserviceWorker do
  let(:perform) { subject.perform(class_name, method_name, *args) }
  let(:example_class) { ExampleService }
  let(:class_name) { example_class.name }
  let(:method_name) { 'call' }
  let(:args) { %w[a b] }

  it 'call service' do
    expect(example_class).to receive(method_name.to_sym).with('a', 'b')
    perform
  end
end
