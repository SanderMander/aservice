# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Service included aservice' do
  before do
    expect(AserviceWorker).to(
      receive(:set).at_least(:once).with(queue: Aservice::Config.queue).and_call_original
    )
  end

  describe 'call_async' do
    let(:service_call) { ExampleService.call_async('a', 'b') }
    it 'call service method asynchroniously' do
      expect_any_instance_of(Sidekiq::Worker::Setter).to(
        receive(:perform_async).with(ExampleService.name, 'call', 'a', 'b').and_call_original
      )
      service_call
    end
  end

  describe 'call_after' do
    let(:job) { ExampleService.call_async('a', 'b') }
    let(:service_call) { ExampleService.call_after(job, 'a', 'b') }

    it 'call service method asynchroniously' do
      expect_any_instance_of(Sidekiq::Worker::Setter).to(
        receive(:perform_after).with(job, 'ExampleService', 'call', 'a', 'b').and_call_original
      )
      service_call
    end
  end

  describe 'any_async' do
    let(:service_call) { ExampleService.any_async('a', 'b') }
    it 'call service method asynchroniously' do
      expect_any_instance_of(Sidekiq::Worker::Setter).to(
        receive(:perform_async).with(ExampleService.name, 'any', 'a', 'b').and_call_original
      )
      service_call
    end
  end

  describe 'no_method_async' do
    let(:service_call) { ExampleService.no_method_async('a', 'b') }
    it 'raise exception' do
      expect do
        service_call
      end.to raise_exception(NoMethodError)
    end
  end
end
