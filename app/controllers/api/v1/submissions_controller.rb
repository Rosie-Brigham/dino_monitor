module Api
  module V1
    class SubmissionsController < BaseController

      def index
        submissions_scope ||= reliable? ? scope.reliable : scope

        unsorted_sites.compact.each do |id|
          submissions_scope = submissions_scope.exclude_unsorted(id)
        end
        paginate json: submissions_scope.order(record_taken: :desc), per_page: page_size
      end

      def data
        # TODO - add some specs you lazy sod.
        date = (Date.today - 1.year).beginning_of_month

        submissions ||= scope_without_images(date)
        submissions_data = SubmissionsDataCreateService.new(submissions, Date.today - 1.year).create
        render json: submissions_data
      end

      private

        def scope
          Submission.with_attached_image.search_site(site_filter).type_search(type_filter).with_tags(tag_filter)
        end

        def scope_without_images(date)
          Submission.where('record_taken >= ?', date).search_site(site_filter).type_search(type_filter).with_tags(tag_filter)
        end

        def permitted_params
          params.permit(:reliable, 
                        :site_id,
                        :site_filter,
                        :type_filter,
                        :tags,
                        :bespoke_size,
                        :page,
                        :pagination)
        end

        def page_size
          params[:bespoke_size] || (params[:page] && params[:page][:size]) || 10
        end

        def paginate?
          permitted_params[:pagination] == "true"
        end

        def reliable?
          permitted_params[:reliable] == "true"
        end

        def site_filter
          Site.find_by(name: permitted_params[:site_filter]).id if permitted_params[:site_filter].present?
        end

        def type_filter
          permitted_params[:type_filter]
        end

        def tag_filter
          permitted_params[:tags]
        end
        
        def unsorted_sites
          @unsorted_sites||= Site::UNSORTED_SITES.map {|name| Site.find_by(name: name).try(:id) }
        end
    end
  end
end