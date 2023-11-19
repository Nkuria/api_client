class ApiClientGenerator < Rails::Generators::NamedBase
  # rails g api_client Todo
  # rails d api_client Todo

  source_root File.expand_path('templates', __dir__)

  # any publice method is automatically run bu the generator
  def copy_templates
    template 'client.rb', "app/api_clients/#{file_path}_client.rb"
    template 'client_test.rb', "test/api_clients/#{file_path}_client_test.rb"
  end


end