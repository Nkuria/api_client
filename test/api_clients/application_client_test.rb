require 'test_helper'

class ApplicationClientTest < ActiveSupport::TestCase
  def setup
    @client = ApplicationClient.new('token')
  end

  test 'token' do
    assert_equal 'token', @client.token
  end

  test 'get' do
    stub_request(:get, 'https://example.com')
    @client.send(:get, '/')
  end

  test 'get with query params' do
    stub_request(:get, 'https://example.com?foo=bar')
    @client.send(:get, '/', query: { foo: 'bar' })
  end

  test 'authorization header' do
    stub_request(:get, 'https://example.com').with(
      headers: {
        'Authorization': 'bearer token'
      }
    )
    @client.send(:get, '/')
  end

  test 'post' do
    stub_request(:post, 'https://example.com/todos').with(
      body: '{"foo":{"bar":"barz"}}'
    )
    @client.send(:post, '/todos', body: {
                   foo: {
                     bar: 'barz'
                   }
                 })
  end

  test 'put' do
    stub_request(:put, 'https://example.com/todos/1').with(
      body: '{"foo":{"bar":"barz"}}'
    )
    @client.send(:put, '/todos/1', body: {
                   foo: {
                     bar: 'barz'
                   }
                 })
  end

  test 'delete' do
    stub_request(:delete, 'https://example.com/todos/1').with(
      query: {
        foo: 'bar'
      }
    ).to_return(status: 204)

    @client.send(:delete, '/todos/1', query: {foo: 'bar'})
  end

  test '500' do
    stub_request(:get, "https://example.com").to_return(status: 500)
    assert_raises ApplicationClient::Error do
      @client.send(:get, '/')
    end
  end
end
