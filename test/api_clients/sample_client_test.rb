# Was generated by the custom generator

require 'test_helper'
class SampleClientTest < ActiveSupport::TestCase

  def setup
    @client = SampleClient.new(token: 'test')
  end

  test 'posts' do
    stub_request(:get, 'https://example.com/posts')
    @client.posts
  end

  test 'update_post' do
    stub_request(:patch, 'https://example.com/posts/1').with(body: "{\"post\":{\"description\":\"sample description\"}}")
    @client.update_post(1, description: 'sample description')
  end

  test 'delete posts' do
    stub_request(:delete, 'https://example.com/posts/1')
    @client.delete_post(1)
  end
end