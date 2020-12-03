# frozen_string_literal: true

class FilterHomeController < ApplicationController
  layout "filter_home"

  def index
    @group_names = SiteGroup.all.map(&:name)
    @site_names = Site.all.map.map(&:name)
    @tags = ActsAsTaggableOn::Tag.all.map {|t| t.name}.uniq 
    @user_email = current_user.try(:email) || ""
  end
end
