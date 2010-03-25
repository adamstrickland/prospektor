class Admin::AdminController < ApplicationController
  layout 'admin'
  access_control :DEFAULT => 'admin'
end