# frozen_string_literal: true

class FilterHomeController < ApplicationController
  layout "filter_home"

  def index
    @group_names = create_site_object
    @tags = ActsAsTaggableOn::Tag.all.map {|t| t.name}.uniq 
    @user_email = current_user.try(:email) || ""
  end

  private

  def create_site_object
    obj = []
    SiteGroup.all.each do |group| 
      site_names = []
      site_names << { label: "#{group.name} (group)", value: group.name, type: "site_group" }
      group.sites.map { |site| site_names << {label: site.name, value: site.name, type: "site_name" }}

      obj << { label: group.name, options: site_names }
    end

    obj
  end
end

