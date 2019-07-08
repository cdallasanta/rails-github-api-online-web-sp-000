class RepositoriesController < ApplicationController

  def index
    login_resp = Faraday.get("https://api.github.com/user") do |req|
      req.headers = {
        Authorization: "token #{session[:token]}"
      }
    end

    @login_info = JSON.parse(login_resp.body)

    repo_resp = Faraday.get("https://api.github.com/user/repos") do |req|
      req.headers = {
        Authorization: "token #{session[:token]}",
      }
    end

    @repos = JSON.parse(repo_resp.body)
  end

  def create
    binding.pry
    resp = Faraday.post("https://api.github.com/user/repos") do |req|
      req.body = { 'name': params[:name] }.to_json
      req.headers = {
        Authorization: "token #{session[:token]}",
        Accept: 'application/json'
      }
    end

    redirect_to root_path
  end

end
