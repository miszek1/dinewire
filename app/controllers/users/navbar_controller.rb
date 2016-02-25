class ApplicationController < ActionController::Base
  before_filter :disable_nav, only: [:home_page]

